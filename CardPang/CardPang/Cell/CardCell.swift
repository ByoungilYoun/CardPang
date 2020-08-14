//
//  CardCell.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class CardCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "CardCell"
  private let frontImageView = UIImageView()
  private let backImageView = UIImageView()
  
  var card : Card?
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame : frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - configureUI()
  private func configureUI() {
    contentView.addSubview(frontImageView)
    contentView.addSubview(backImageView)
    
    frontImageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    backImageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: -  setCard() 
  func setCard(_ card : Card) {
    self.card = card
    
    if card.isMatched == true {
      backImageView.alpha = 0
      frontImageView.alpha = 0
      return
    } else {
      backImageView.alpha = 1
      frontImageView.alpha = 1
    }
    
    frontImageView.image = UIImage(named: card.imageName)
    frontImageView.contentMode = .scaleAspectFit
    backImageView.image = UIImage(named: "back")
    backImageView.contentMode = .scaleAspectFit
    
    if card.isFlipped == true {
      UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    } else {
      UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
  }
  
  //MARK: - flip()
  func filp() {
    UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
  }
  
  //MARK: - flipBack()
  func flipBack() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    }
  }
  
  //MARK: - remove()
  func remove() {
    backImageView.alpha = 0
    
    UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
      self.frontImageView.alpha = 0
    }, completion: nil)
  }
}
