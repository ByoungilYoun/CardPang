//
//  LoginController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/06.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import SnapKit

class LoginController : UIViewController {
  
  //MARK: - Properties
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon"))
  private let titleLabel = CustomTextLabel(title: "Card Pang")
  
  private let emailTextField = CustomTextField(placeholder: "이메일")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "비밀번호")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let loginButton : AuthButton = {
    let button = AuthButton()
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  private let forgotButton : UIButton = {
    let button = UIButton(type: .system)
    
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    let attributedTitle = NSMutableAttributedString(string: "비밀번호를 잊어버리셨나요?", attributes: atts)
    
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.boldSystemFont(ofSize: 15)]
    attributedTitle.append(NSAttributedString(string: " 여기를 클릭하세요.", attributes: boldAtts))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
    return button
  }()
  
  private let googleButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "googleIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.setTitle("Google 로그인", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
    return button
  }()
  
  private let appleButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "appleLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
    button.setTitle("Apple 로그인", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
    return button
  }()
  
  private let dontHaveAccountButton : UIButton = {
    let button = UIButton(type: .system)
    let atts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.systemFont(ofSize: 15)]
    let attributedTitle = NSMutableAttributedString(string: "아직 계정이 없으신가요?", attributes: atts)
    
    let boldAtts : [NSAttributedString.Key : Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font : UIFont.boldSystemFont(ofSize: 15)]
    attributedTitle.append(NSAttributedString(string: " 계정 생성", attributes: boldAtts))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    
    button.addTarget(self, action: #selector(showRegisterationController), for: .touchUpInside)
    return button
  }()
  
  //MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    setGradient()
    setNavi()
    setUI()
    setConstraints()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
  }
  
  //MARK: - setUI()
  private func setUI(){
    view.addSubview(iconImage)
    view.addSubview(titleLabel)
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotButton])
    stackView.axis = .vertical
    stackView.spacing = 15
    view.addSubview(stackView)
    stackView.anchor(top : titleLabel.bottomAnchor, left : view.leftAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 32, paddingRight: 32)
    
    view.addSubview(googleButton)
    view.addSubview(appleButton)
    view.addSubview(dontHaveAccountButton)
  }
  
  
  
  //MARK: - setConstraint()
  private func setConstraints() {
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
      $0.top.equalTo(40)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(iconImage.snp.bottom).offset(10)
    }
    
    googleButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(forgotButton.snp.bottom).offset(20)
    }
    
    appleButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(googleButton.snp.bottom).offset(10)
    }
    
    dontHaveAccountButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
    }
    
  }
  
  //MARK: - setGradient()
  private func setGradient() {
    let upperColor = UIColor(red: 205/255.0, green: 53/255.0, blue: 134/255.0, alpha: 1.0)
    let lowerColor = UIColor(red: 233/255.0, green: 171/255.0, blue: 67/255.0, alpha: 1.0)
    let gradient = CAGradientLayer()
    gradient.colors = [upperColor.cgColor, lowerColor.cgColor]
    gradient.locations = [0, 1]
    gradient.frame = view.frame
    view.layer.addSublayer(gradient)
  }
  
  //MARK: - objf Functions
  
  @objc func handleLogin() {
    
  }
  
  @objc func showForgotPassword() {
    
  }
  
  @objc func handleGoogleLogin() {
    
  }
  
  @objc func handleAppleLogin() {
    
  }
  
  @objc func showRegisterationController() {
    
  }
}
