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
  private var user : User? {
    didSet {
      presentOnboardingIfNeccessary()
    }
  }
  
  
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
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  //MARK: - logout()
  private func logout() {
    do {
      try Auth.auth().signOut()
      self.presentLoginController()
    } catch {
      print("Debug : Error Signing Out")
    }
  }
  
  //MARK: - presentLoginController()
  fileprivate func presentLoginController() {
    let controller = LoginController()
    let navi = UINavigationController(rootViewController: controller)
    
    navi.modalPresentationStyle = .fullScreen
    self.present(navi, animated: true)
  }
  
  //MARK: - authenticateUser()
  private func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      DispatchQueue.main.async {
        self.presentLoginController()
      }
    } else {
      fetchUser()
  }
}
  //MARK: - presentOnboardingController()
  fileprivate func presentOnboardingIfNeccessary() {
    guard let user = user else {return}
    guard !user.hasSeenOnboarding else {return}
  }
  
  //MARK: - fetchUser()
  private func fetchUser() {
    Service.fetchUser { user in
      self.user = user
    }
  }
  
  
  //MARK: - objc func
  
  @objc func handleLogout() {
    let alert = UIAlertController(title: nil, message: "로그아웃을 하시겠습니까?", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
      self.logout()
    }))
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    present(alert, animated: true)
  }
}

extension HomeController : OnboardingControllerDelegate {
  func controllerWantsToDismiss(_ controller: OnboardingController) {
    controller.dismiss(animated: true, completion: nil)

    Service.updateUserHasSeenOnboarding { (error, ref) in
      self.user?.hasSeenOnboarding = true
      print("Debug : Did set has seen onboarding")
    }
  }
  
  
}
