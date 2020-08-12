//
//  OnboardingViewModel.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/12.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

struct OnboardingViewModel {
  private let itemCount : Int
  
  init(itemCount : Int) {
    self.itemCount = itemCount
  }
  
  func shouldShowGetStartedButton (forIndex index : Int) -> Bool {
    return index == itemCount - 1 ? true : false 
  }
}
