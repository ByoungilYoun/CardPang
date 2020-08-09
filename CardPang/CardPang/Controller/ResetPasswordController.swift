//
//  ResetPasswordController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/10.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

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
    view.addSubview(backButton)
    
    let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    view.addSubview(stackView)
    stackView.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50 , paddingLeft: 30, paddingRight: 30)
  }
  
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
  
  //MARK: - @objc func
  @objc func handleResetPassword() {
    
  }
  
  @objc func handleGoBack() {
    navigationController?.popViewController(animated: true)
  }
}
