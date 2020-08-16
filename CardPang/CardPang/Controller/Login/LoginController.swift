//
//  LoginController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/06.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import GoogleSignIn

protocol AuthenticationDelegate : class {
  func authenticationComplete()
}

class LoginController : UIViewController {
  
  //MARK: - Properties
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "Main Icon"))
  private let titleLabel = CustomTextLabel(title: "Fruit Pang")
  
  private let emailTextField = CustomTextField(placeholder: "이메일")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "비밀번호")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let loginButton : AuthButton = {
    let button = AuthButton()
    button.title = "로그인"
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
    button.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
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
  
  private var viewModel = LoginViewModel()
  weak var delegate : AuthenticationDelegate?
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
    setUI()
    setConstraints()
    configureNotificationObservers()
    configureGoogleSignIn()
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
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    
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
  //MARK: - configureNotificationObservers()
  private func configureNotificationObservers () {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
  
  //MARK: - configureGoogleSignIn()
  private func configureGoogleSignIn() {
    GIDSignIn.sharedInstance()?.presentingViewController = self
    GIDSignIn.sharedInstance()?.delegate = self
  }
  //MARK: - objc Functions
  
  @objc func handleLogin() {
    guard let email = emailTextField.text else {return}
    guard let password = passwordTextField.text  else {return}
    
    showLoader(true)
    
    Service.logUserIn(withEmail: email, password: password) { (result, error) in
      self.showLoader(false)
      if let error = error {
        print("Debug : Error in Signing in \(error.localizedDescription)")
        return
      }
      self.delegate?.authenticationComplete()
    }
  }
  
  @objc func showForgotPassword() {
    let controller = ResetPasswordController()
    controller.email = emailTextField.text
    controller.delegate = self 
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func handleGoogleLogin() {
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  @objc func handleAppleLogin() {
    
  }
  
  @objc func showRegisterationController() {
    let controller = RegistrationController()
    controller.delegate = delegate
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func textDidChange(_ sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else {
      viewModel.password = sender.text
    }
    updateForm()
  }
}

//MARK: - extension FormViewModel
extension LoginController : FormViewModel {
  func updateForm() {
    loginButton.isEnabled = viewModel.shouldEnableButton
    loginButton.backgroundColor = viewModel.buttonBackgroundColor
    loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}

//MARK: - extension UITextFieldDelegate 
extension LoginController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTextField.endEditing(true)
    passwordTextField.endEditing(true)
    return true
  }
}
//MARK: - extension GIDSignInDelegate
extension LoginController : GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    Service.signInWithGoogle(didSignInFor: user) { (error, ref) in
      self.delegate?.authenticationComplete()
      self.dismiss(animated: true, completion: nil)
    }
  }
}

extension LoginController : ResetPasswordControllerDelegate {
  func didSendResetPasswordLink() {
    navigationController?.popViewController(animated: true)
    self.showMessage(withTitle: "", message: MSG_RESET_PASSWORD_LINK_SENT)
  }
}
