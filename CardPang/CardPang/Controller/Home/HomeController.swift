//
//  HomeController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/10.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import Firebase

class HomeController : UIViewController {
  
  //MARK: - Properties
  
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    authenticateUser()
    setNavi()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "Card Pang!"
    
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLogout))
  }
  
  //MARK: - logout()
  private func logout() {
    do {
      try Auth.auth().signOut()
      print("Debug : Signed Out")
    } catch {
      print("Debug : Error Signing Out")
    }
  }
  
  //MARK: - authenticateUser()
  private func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      DispatchQueue.main.async {
        let controller = LoginController()
        let navi = UINavigationController(rootViewController: controller)
        
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true)
      }
    } else {
      print("Debug : User is logged in")
    }
  }
  
  //MARK: - objc func
  
  @objc func handleLogout() {
    logout()
  }
}
