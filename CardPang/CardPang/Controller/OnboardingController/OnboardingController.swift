//
//  OnboardingController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/12.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation
import paper_onboarding

protocol OnboardingControllerDelegate : class {
  func controllerWantsToDismiss(_ controller : OnboardingController)
}

class OnboardingController : UIViewController {
  //MARK: - Properties
  weak var delegate : OnboardingControllerDelegate?
  
  private var onboardingItems = [OnboardingItemInfo]()
  private var onboardingView = PaperOnboarding()
  
  private let getStartButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("시작하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    button.addTarget(self, action: #selector(dismissOnboarding), for: .touchUpInside)
    return button
  }()
  

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureOnboardingDataSource()
  }
  
  //MARK: - uibarstyle
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  //MARK: - configureUI()
  func configureUI() {
    view.addSubview(onboardingView)
    onboardingView.fillSuperview()
    onboardingView.delegate = self
    
    view.addSubview(getStartButton)
    getStartButton.alpha = 0
    getStartButton.centerX(inView: view)
    getStartButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor,
                            paddingBottom: 128)
  }
 
  
  //MARK: - configureOnboardingDataSource()
    func configureOnboardingDataSource() {
    let item1 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "baseline_dashboard_white_48pt").withRenderingMode(.alwaysOriginal), title: Msg_Cardgame, description: Discription_Cardgame , pageIcon: UIImage(), color: .systemBlue, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.boldSystemFont(ofSize: 16))
    
    let item2 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "ic_person_outline_white_2x").withRenderingMode(.alwaysOriginal), title: Msg_Memory, description: Discription_Memory, pageIcon: UIImage(), color: .systemGreen, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.boldSystemFont(ofSize: 16))
    
    let item3 = OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "baseline_insert_chart_white_48pt").withRenderingMode(.alwaysOriginal), title: Msg_TimeLimit, description: Discription_TimeLimit, pageIcon: UIImage(), color: .systemYellow, titleColor: .white, descriptionColor: .white, titleFont: UIFont.boldSystemFont(ofSize: 24), descriptionFont: UIFont.boldSystemFont(ofSize: 16))
    
    onboardingItems.append(item1)
    onboardingItems.append(item2)
    onboardingItems.append(item3)
    
    onboardingView.dataSource = self
    onboardingView.reloadInputViews()
  }
  
  //MARK: - animateGetStartedButton ()
    func animateGetStartedButton (_ shouldShow : Bool) {
    let alpha : CGFloat = shouldShow ? 1 : 0
    UIView.animate(withDuration: 0.5) {
      self.getStartButton.alpha = alpha
    }
  }
  
  //MARK: - objc func
   @objc func dismissOnboarding() {
    delegate?.controllerWantsToDismiss(self)
   }
}

//MARK: - PaperOnboardingDataSource
extension OnboardingController : PaperOnboardingDataSource {
  func onboardingItemsCount() -> Int {
    return onboardingItems.count
  }
  
  func onboardingItem(at index: Int) -> OnboardingItemInfo {
    return onboardingItems[index]
  }
}

//MARK: - PaperOnboardingDelegate
extension OnboardingController : PaperOnboardingDelegate {
  func onboardingWillTransitonToIndex(_ index : Int) {
    let viewModel = OnboardingViewModel(itemCount: onboardingItems.count)
    let shouldShow = viewModel.shouldShowGetStartedButton(forIndex: index)
    animateGetStartedButton(shouldShow)
  }
}
