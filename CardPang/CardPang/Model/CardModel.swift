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
    
    var generatedNumbersArray = [Int]()
    
    var generatedCardsArray = [Card]()
    
    while generatedNumbersArray.count < 6 {
      let randomNumber = arc4random_uniform(13) + 1
      
      if generatedNumbersArray.contains(Int(randomNumber)) == false {
        
        generatedNumbersArray.append(Int(randomNumber))
        print(randomNumber)
        
        let cardOne = Card()
        cardOne.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardOne)
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardTwo)
      }
   
    }
    
    for i in 0...generatedCardsArray.count - 1 {
      
      let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
      let temporaryStorage = generatedCardsArray[i]
      generatedCardsArray[i] = generatedCardsArray[randomNumber]
      generatedCardsArray[randomNumber] = temporaryStorage
    }
    return generatedCardsArray
  }
  
  //MARK: - getNormalCards()
  func getNormalCards() -> [Card] {
    
    var generatedNumbersArray = [Int]()
    var generatedCardsArray = [Card]()
    
    while generatedNumbersArray.count < 8 {
      let randomNumber = arc4random_uniform(13) + 1
      
      if generatedNumbersArray.contains(Int(randomNumber)) == false {
        
        generatedNumbersArray.append(Int(randomNumber))
        print(randomNumber)
        let cardOne = Card()
        cardOne.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardOne)
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardTwo)
      }
    }
    
    for i in 0...generatedCardsArray.count - 1 {
      let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
      let temporaryStorage = generatedCardsArray[i]
      generatedCardsArray[i] = generatedCardsArray[randomNumber]
      generatedCardsArray[randomNumber] = temporaryStorage
    }
    return generatedCardsArray
  }
  
  //MARK: - getHardCards()
  func getHardCards() -> [Card] {
    var generatedNumbersArray = [Int]()
    var generatedCardsArray = [Card]()
    
    while generatedNumbersArray.count < 10 {
      let randomNumber = arc4random_uniform(13) + 1
      
      if generatedNumbersArray.contains(Int(randomNumber)) == false {
        generatedNumbersArray.append(Int(randomNumber))
        
        print(randomNumber)
        let cardOne = Card()
        cardOne.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardOne)
        
        let cardTwo = Card()
        cardTwo.imageName = "card\(randomNumber)"
        generatedCardsArray.append(cardTwo)
      }
    }
    for i in 0...generatedCardsArray.count - 1 {
      
      let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
      let temporaryStorage = generatedCardsArray[i]
      generatedCardsArray[i] = generatedCardsArray[randomNumber]
      generatedCardsArray[randomNumber] = temporaryStorage
    }
    
    return generatedCardsArray
  }
}
