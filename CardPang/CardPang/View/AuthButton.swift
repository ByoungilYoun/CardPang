//
//  AuthButton.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/09.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class AuthButton : UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 5
    setTitle("로그인", for: .normal)
    backgroundColor = UIColor.systemPurple.withAlphaComponent(0.5)
    setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    setHeight(height: 40)
    isEnabled = false 
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
