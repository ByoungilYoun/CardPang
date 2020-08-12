//
//  ResetPasswordController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/10.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

protocol ResetPasswordControllerDelegate : class {
  func didSendResetPasswordLink()
}

class ResetPasswordController : UIViewController {
  
  //MARK: - Properties
  
  private let iconImage = UIImageView(image: #imageLiteral(resourceName: "icon"))
  private let emailTextField = CustomTextField(placeholder: "이메일")
  
  private let resetPasswordButton : AuthButton = {
    let button = AuthButton(type: .system)
    button.title = "비밀번호 초기화 링크 보내기"
    button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    return button
  }()
  
  private let backButton : UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    return button
  }()
  
  private var viewModel = ResetPasswordViewModel()
  
   var email : String?
  weak var delegate : ResetPasswordControllerDelegate?
  //MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setUI()
    setConstraints()
    configureNotificationObservers()
    loadEmail()
  }
  
  //MARK: - setUI()
  private func setUI() {
    view.addSubview(iconImage)
    view.addSubview(backButton)
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50 , paddingLeft: 30, paddingRight: 30)
  }
  
  //MARK: - setConstraints()
  private func setConstraints() {
    iconImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(100)
      $0.top.equalTo(50)
    }
    
    backButton.snp.makeConstraints {
      $0.top.left.equalTo(view.safeAreaLayoutGuide).offset(20)
    }
  }
  
  //MARK: - configureNotificationObservers()
  private func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
  }
  
  //MARK: - loadEmail()
  private func loadEmail() {
    guard let email = email else {return}
    viewModel.email = email
    emailTextField.text = email
    
    updateForm()
  }
  //MARK: - @objc func
  @objc func handleResetPassword() {
    guard let email = viewModel.email else {return}
    
    showLoader(true)
    
    Service.resetPassword(forEmail: email) { error in
      self.showLoader(false)
      if let error = error {
        print("Debug : Failed to reset password \(error.localizedDescription)")
        return
      }
      
      self.delegate?.didSendResetPasswordLink()
    }
  }
  
  @objc func handleGoBack() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func textDidChange(_ sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    }
    updateForm()
  }
}

  //MARK: - extension
extension ResetPasswordController : FormViewModel {
  func updateForm() {
    resetPasswordButton.isEnabled = viewModel.shouldEnableButton
    resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
    resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}
