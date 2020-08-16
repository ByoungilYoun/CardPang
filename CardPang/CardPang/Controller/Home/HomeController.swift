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
      showWelcomeLabel()
    }
  }
  
  private let welcomeLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 28)
    label.text = "Welcome User"
    label.alpha = 0
    return label
  }()
  
  private let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  var gameMode = ["Easy", "Normal", "Hard"]
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    authenticateUser()
    configureUI()
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "Fruit Pang"
    
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleLogout))
    navigationItem.leftBarButtonItem?.tintColor = .white
    
    view.addSubview(welcomeLabel)
    welcomeLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(150)
    }
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(GameModeCell.self, forCellWithReuseIdentifier: GameModeCell.identifier)
    collectionView.backgroundColor = .clear
    collectionView.layer.cornerRadius = 10
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      
    }
  }
  
  private struct Standard {
    static let standard : CGFloat = 20
    static let inset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  //MARK: - showWelcomeLabel()
  fileprivate func showWelcomeLabel() {
    guard let user = user else {return}
    guard user.hasSeenOnboarding else {return}
    welcomeLabel.text = "환영합니다, \(user.fullname) 님!"
    UIView.animate(withDuration: 1) {
      self.welcomeLabel.alpha = 1
    }
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
    controller.delegate = self 
    let navi = UINavigationController(rootViewController: controller)
    navi.modalPresentationStyle = .fullScreen
    self.present(navi, animated: true)
  }
  
  //MARK: - authenticateUser()
    func authenticateUser() {
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
    
    let controller = OnboardingController()
       controller.delegate = self
       controller.modalPresentationStyle = .fullScreen
       present(controller, animated: true)
  }
  
  //MARK: - fetchUser()
   func fetchUser() {
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

  //MARK: - OnboardingControllerDelegate
extension HomeController : OnboardingControllerDelegate {
  func controllerWantsToDismiss(_ controller: OnboardingController) {
    controller.dismiss(animated: true, completion: nil)

    Service.updateUserHasSeenOnboarding { (error, ref) in
      self.user?.hasSeenOnboarding = true
      print("Debug : Did set has seen onboarding")
    }
  }
}
  
  //MARK: - AuthenticationDelegate
extension HomeController : AuthenticationDelegate {
  func authenticationComplete() {
    dismiss(animated: true, completion: nil)
    fetchUser()
  }
}

  //MARK: - UICollectionViewDataSource
extension HomeController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameModeCell.identifier, for: indexPath) as! GameModeCell
    cell.backgroundColor = .lightGray
    cell.layer.cornerRadius = 20
    cell.configure(gameMode[indexPath.row])
//    cell.backgroundColor = .clear
    return cell
  }
}

  //MARK: - UICollectionViewDelegate
extension HomeController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0 :
      let controller = EasyModeController()
      navigationController?.pushViewController(controller, animated: true)
    case 1 :
      let controller = NormalModeController()
      navigationController?.pushViewController(controller, animated: true)
    case 2 :
      let controller = HardModeController()
      navigationController?.pushViewController(controller, animated: true)
    default :
      break
    }
  }
}
  //MARK: - UICollectionViewDelegateFlowLayout
extension HomeController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    Standard.inset
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.size.width - Standard.inset.left - Standard.inset.right
    return CGSize(width: width, height: 100)
  }
  
  
}
