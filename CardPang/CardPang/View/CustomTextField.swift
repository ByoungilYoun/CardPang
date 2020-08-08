//
//  CustomTextField.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/09.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class CustomTextField : UITextField {
  
  init(placeholder : String) {
    super.init(frame: .zero)
    
    let spacer = UIView()
    spacer.setDimensions(height: 40, width: 12)
    leftView = spacer
    leftViewMode = .always
    
    borderStyle = .none
    textColor = .white
    keyboardAppearance = .dark
    backgroundColor = UIColor(white: 1, alpha: 0.1)
    setHeight(height: 40)
    attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1.0, alpha: 0.7)])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
