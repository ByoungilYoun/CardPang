//
//  GameModeCell.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class GameModeCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "GameModeCell"
  
  let gameModeLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 50)
    return label
  }()
  //MARK: - init
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(gameModeLabel)
    gameModeLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  func configure(_ mode : String) {
    gameModeLabel.text = mode
  }
}
