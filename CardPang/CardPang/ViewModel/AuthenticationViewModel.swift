//
//  AuthenticationViewModel.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/10.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

//MARK: - protocol AuthenticationViewModel
protocol AuthenticationViewModel {
  var formIsValid : Bool {get}
  var shouldEnableButton : Bool {get}
  var buttonTitleColor : UIColor {get}
  var buttonBackgroundColor : UIColor {get}
}

protocol FormViewModel {
  func updateForm() 
}
//MARK: - LoginViewModel
struct LoginViewModel : AuthenticationViewModel {
  var email : String?
  var password : String?
  
  var formIsValid : Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
  
  var shouldEnableButton : Bool {
    formIsValid
  }
  
  var buttonTitleColor : UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor : UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    return formIsValid ? enabledPurple : disabledPurple
  }
}
//MARK: - RegisterationViewModel
struct RegisterationViewModel : AuthenticationViewModel {
  var email : String?
  var password : String?
  var fullname : String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false
  }
  
  var shouldEnableButton: Bool {
    return formIsValid
  }
  
  var buttonTitleColor: UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor: UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    return formIsValid ? enabledPurple : disabledPurple
  }
}
//MARK: - ResetPasswordViewModel
struct ResetPasswordViewModel : AuthenticationViewModel {
  var email : String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false
  }
  
  var shouldEnableButton: Bool {
    return formIsValid
  }
  
  var buttonTitleColor: UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }
  
  var buttonBackgroundColor: UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    let disabledPurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    return formIsValid ? enabledPurple : disabledPurple
  }
  
  
}
