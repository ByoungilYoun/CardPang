//
//  LoginController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/06.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class LoginController : UIViewController {
  
  //MARK: - Properties
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  private func configureUI() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    
    
    let upperColor = UIColor(red: 205/255.0, green: 53/255.0, blue: 134/255.0, alpha: 1.0)
    let lowerColor = UIColor(red: 233/255.0, green: 171/255.0, blue: 67/255.0, alpha: 1.0)
    let gradient = CAGradientLayer()
    gradient.colors = [upperColor.cgColor, lowerColor.cgColor]
    gradient.locations = [0, 1]
    gradient.frame = view.frame
    view.layer.addSublayer(gradient)
  }
}
