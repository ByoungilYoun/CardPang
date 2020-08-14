//
//  CardModel.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import Foundation

class CardModel {
  
  //MARK: - getEasyCards()
  func getEasyCards() -> [Card] {
    
    var generatedCardsArray = [Card]()
    
    for _ in 1...6 {
      let randomNumber = arc4random_uniform(13) + 1
      print("generating a random number : \(randomNumber)")
      
      let cardOne = Card()
      cardOne.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardOne)
      
      let cardTwo = Card()
      cardTwo.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardTwo)
    }
    return generatedCardsArray
  }
  
  //MARK: - getNormalCards()
  func getNormalCards() -> [Card] {
    
    var generatedCardsArray = [Card]()
    
    for _ in 1...8 {
      let randomNumber = arc4random_uniform(13) + 1
      
      let cardOne = Card()
      cardOne.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardOne)
      
      let cardTwo = Card()
      cardTwo.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardTwo)
    }
    return generatedCardsArray
  }
  
  //MARK: - getHardCards()
  func getHardCards() -> [Card] {
    
    var generatedCardsArray = [Card]()
    
    for _ in 1...10 {
      let randomNumber = arc4random_uniform(13) + 1
      
      let cardOne = Card()
      cardOne.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardOne)
      
      let cardTwo = Card()
      cardTwo.imageName = "card\(randomNumber)"
      generatedCardsArray.append(cardTwo)
    }
    return generatedCardsArray
  }
}
