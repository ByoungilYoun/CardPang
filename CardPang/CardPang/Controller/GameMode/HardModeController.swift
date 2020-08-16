//
//  HardModeController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class HardModeController : UIViewController {
  //MARK: - Properties
  private let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let timeLabel : UILabel = {
    let lb = UILabel()
    lb.text = "남은 시간: "
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    lb.textAlignment = .center
    return lb
  }()
  
  private let secondLabel : UILabel = {
    let lb = UILabel()
    lb.text = "0.00"
    lb.font = UIFont.boldSystemFont(ofSize: 20)
    return lb
  }()
  
  var timer : Timer?
  var milliseconds : Float = 50 * 1000
  var model = CardModel()
  var cardArray = [Card]()
  var firstFlippedCardIndex : IndexPath?
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
    configureUI()
    cardArray = model.getHardCards()
    
    timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
  }
  
  //MARK: - Standard
  struct Standard {
    static let standard : CGFloat = 10
    static let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  }
  //MARK: - setNavi()
  private func setNavi() {
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
    navigationItem.leftBarButtonItem?.tintColor = .white
  }
  
  private func configureUI() {
    view.addSubview(timeLabel)
    timeLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(60)
      $0.leading.equalToSuperview().offset(120)
    }
    
    view.addSubview(secondLabel)
    secondLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(60)
      $0.leading.equalTo(timeLabel.snp.trailing)
    }
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .clear
    collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(secondLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  
  //MARK: - objc func
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func timerElapsed() {
    milliseconds -= 1
    
    let seconds = String(format: "%.2f", milliseconds / 1000)
    secondLabel.text = "\(seconds)"
    
    if milliseconds <= 0 {
      timer?.invalidate()
      secondLabel.textColor = .red
      checkGameEnded()
    }
  }
}

//MARK: - UICollectionViewDataSource
extension HardModeController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    cardArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
    let card = cardArray[indexPath.row]
    cell.setCard(card)
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension HardModeController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if milliseconds <= 0 {
      return
    }
    
    let cell = collectionView.cellForItem(at: indexPath) as! CardCell
    
    let card = cardArray[indexPath.row]
    if card.isFlipped == false && card.isMatched == false {
      cell.flip()
      card.isFlipped = true
      
      if firstFlippedCardIndex == nil {
        firstFlippedCardIndex = indexPath
      } else {
        checkForMatches(indexPath)
      }
    }
  }
  
  func checkForMatches(_ secondFlippedCardIndex : IndexPath) {
    let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCell
    let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCell
    
    let cardOne = cardArray[firstFlippedCardIndex!.row]
    let cardTwo = cardArray[secondFlippedCardIndex.row]
    
    if cardOne.imageName == cardTwo.imageName {
      cardOne.isMatched = true
      cardTwo.isMatched = true
      cardOneCell?.remove()
      cardTwoCell?.remove()
      checkGameEnded()
    } else {
      cardOne.isFlipped = false
      cardTwo.isFlipped = false
      cardOneCell?.flipBack()
      cardTwoCell?.flipBack()
    }
    
    if cardOneCell == nil {
      collectionView.reloadItems(at: [firstFlippedCardIndex!])
    }
    firstFlippedCardIndex = nil
  }
  
  func checkGameEnded() {
    var isWon = true
    
    for card in cardArray {
      if card.isMatched == false {
        isWon = false
        break
      }
    }
    
    var title = ""
    var message = ""
    
    if isWon == true {
      if milliseconds > 0 {
        timer?.invalidate()
      }
      title = "축하합니다!"
      message = "모두 맞추셨어요!"
    } else {
      if milliseconds > 0 {
        return
      }
      title = "아쉬워요"
      message = "모두 못맞추셨네요"
    }
    showAlert(title, message)
  }
  
  func showAlert(_ title : String, _ message : String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HardModeController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    Standard.standard
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    Standard.inset
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.size.width - Standard.inset.left - Standard.inset.right - (Standard.standard * 3)
    let realWidth = width / 4
    return CGSize(width: realWidth, height: 100)
  }
}

