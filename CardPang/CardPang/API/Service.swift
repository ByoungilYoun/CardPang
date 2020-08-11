//
//  Service.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/11.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct Service {
  //MARK: - logUserIn()
  static func logUserIn(withEmail email : String, password : String, completion : AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }
  
  //MARK: - registerUserWithFirebase() 
  static func registerUserWithFirebase(withEmail email : String, password : String, fullname : String, completion : @escaping (DatabaseCompletion)) {
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
      if let error = error {
        print("Debug : Failed to create user with error : \(error.localizedDescription)")
        return
      }
      
      guard let uid = result?.user.uid else {return}
      
      let values = ["email" : email, "fullname" : fullname]
      Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
  }
  
  //MARK: - signInWithGoogle()
 static func signInWithGoogle(didSignInFor user : GIDGoogleUser, completion : @escaping (DatabaseCompletion)) {
    
    guard let authentication = user.authentication else {return}
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
    Auth.auth().signIn(with: credential) { (result, error) in
      if let error = error {
        print("Debug : Failed to sign in with google : \(error.localizedDescription)")
        return
      }
      guard let uid = result?.user.uid else {return}
      guard let email = result?.user.email else {return}
      guard let fullname = result?.user.displayName else {return}
      
      let values = ["email" : email, "fullname" : fullname]
      
      Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
   }
  }
}

