//
//  CustomTextLabel.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/09.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class CustomTextLabel : UILabel {
  
  init(title : String) {
    super.init(frame: .zero)
    text = title
    textColor = UIColor.white
    textAlignment = .center
    font = UIFont.boldSystemFont(ofSize: 30)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
