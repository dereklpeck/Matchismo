//
//  CardMatchingGame.swift
//  Matchismo1
//
//  Created by Derek Peck on 9/18/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

class CardMatchingGame {
  private var score = 0
  private lazy var cards: [Card] = []
  let FLIP_COST = 1
  let MATCH_BONUS = 4
  let MISMATCH_PENALTY = 2
  
  init(cardCount: Int, deck: Deck) {
    for i in 0 ..< cardCount {
      if let card = deck.drawRandomCard() {
        cards.append(card)
      }
    }
  }
  
  func flipCardAtIndex(index: Int, mode: Int) -> NSString? {
     var result: String = ""
    if let card = cardAtIndex(index) {
      if !card.unplayable {
        if !card.faceUp {
          result = "Flipped up \(card.contents)"
          var cardArray: [Card] = [Card]()
          for otherCard in cards {
            if otherCard.faceUp && !otherCard.unplayable {
              
              if mode == 0 {
                // match 2 cards
                let matchScore = card.match([otherCard], mode: mode)
                
                if matchScore > 0 {
                  otherCard.unplayable = true
                  card.unplayable = true
                  score += matchScore * MATCH_BONUS
                  result = "Matched \(card.contents) & \(otherCard.contents) for \(matchScore * MATCH_BONUS) points"
                  break
                } else {
                  score -= MISMATCH_PENALTY
                  result = "\(card.contents) & \(otherCard.contents) don't match: \(MISMATCH_PENALTY) point penalty"
                }
              } else {
                // match 3 or more cards
                cardArray.append(otherCard)
              }
            }
          }
          if mode == 1 {
            let matchScore = card.match(cardArray, mode: mode)
            
            if matchScore > 0 {
              for eachCard in cardArray {
                eachCard.unplayable = true
              }
              card.unplayable = true
              score += matchScore * MATCH_BONUS
              
              result = "Matched \(card.contents)"
              for oneCard in cardArray {
                result += " & \(oneCard.contents)"
              }
              result += " for \(matchScore * MATCH_BONUS) points"
            } else if cardArray.count == 2{
              score -= MISMATCH_PENALTY
              result = "\(card.contents)"
              for oneCard in cardArray {
                result += " & \(oneCard.contents)"
              }
              result += " don't match: \(MISMATCH_PENALTY) point penalty"
            }
          }
          
          
          score -= FLIP_COST
        }
        card.faceUp = !card.faceUp
      }
    }
    return result
  }
  
  func cardAtIndex(index: Int) -> Card? {
    if index >= 0 || index < cards.count {
      return cards[index]
    }
    
    return nil
  }
  
  func currentScore() -> Int {
    return score
  }
  
}