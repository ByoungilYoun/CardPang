//
//  RegisterationController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/09.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon"))
  
  private let emailTextField = CustomTextField(placeholder: "이메일")
  private let fullnameTextField = CustomTextField(placeholder: "성명")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "비밀번호")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signUpButton : AuthButton = {
    let button = AuthButton(type: .system)
    button.title = "계정 생성"
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.addTarget(self, action: #selector(handleSignUP), for: .touchUpInside)
    
    return button
  }()
  
  private let alreadyHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
        
        let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
        let attributedTitle = NSMutableAttributedString(string: "계정이 있으신가요? ", attributes: atts)
        
        let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "로그인하기", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        return button
  }()
  
  //MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setUI()
    setConstraints()
  }
  
  //MARK: - setUI()
  private func setUI() {
    view.addSubview(iconImage)
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, signUpButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30 , paddingLeft: 30, paddingRight: 30)
    
    view.addSubview(alreadyHaveAccountButton)
  }
  
  //MARK: - setConstraint()
  private func setConstraints() {
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
      $0.top.equalTo(40)
    }
    
    alreadyHaveAccountButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
    }
  }
  
  //MARK: - @objc func
  @objc func handleSignUP() {
    
  }
  
  @objc func showLoginController() {
    navigationController?.popViewController(animated: true)
  }
}
