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
    let MATCH_BONUS = 5
    let SET_MATCH_BONUS = 7
    let MISMATCH_PENALTY = 2
    let SET_MISMATCH_PENALTY = 3
  
    init(cardCount: Int, deck: Deck) {
        for i in 0 ..< cardCount {
            if let card = deck.drawRandomCard() {
                cards.append(card)
            }
        }
    }
  
    func flipCardAtIndex(index: Int, mode: Int) -> (string: NSString?, attributed: NSAttributedString?) {
        var result: String = ""
        var setResult = NSMutableAttributedString(string: "")
        if let card = cardAtIndex(index) {
            if !card.unplayable {
                if !card.faceUp {
                    if mode == 0 {
                        result = "Flipped up \(card.contents)"
                    } else if mode == 1 {
                        setResult = NSMutableAttributedString(string: "Flipped ")
                        setResult.appendAttributedString(SetGameViewController.getAttributedString(card as SetCard))
                    }
                    var cardArray: [Card] = [Card]()
                    for otherCard in cards {
                        if otherCard.faceUp && !otherCard.unplayable {
                            if mode == 0 {
                                // match 2 cards
                                let matchScore = card.match([otherCard])
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
                            }
                            else if mode == 1 { // Set Card Mode
                                cardArray.append(otherCard)
                            }
                        }
                    }
                    if mode == 1 { // Set Card Mode
                        let matchScore = card.match(cardArray)
                        if matchScore > 0 {
                            for eachCard in cardArray {
                                eachCard.unplayable = true
                            }
                            card.unplayable = true
                            score += matchScore * SET_MATCH_BONUS
                            setResult = NSMutableAttributedString(string: "Matched ")
                            setResult.appendAttributedString(SetGameViewController.getAttributedString(card as SetCard))
                            for oneCard in cardArray {
                                setResult.appendAttributedString(NSMutableAttributedString(string: " & "))
                                setResult.appendAttributedString(SetGameViewController.getAttributedString(oneCard as SetCard))
                            }
                            setResult.appendAttributedString(NSMutableAttributedString(string: " for \(matchScore * MATCH_BONUS) points"))
                        } else if cardArray.count == 2{
                            score -= MISMATCH_PENALTY
                            setResult = NSMutableAttributedString(string: "")
                            setResult.appendAttributedString(SetGameViewController.getAttributedString(card as SetCard))
                            for oneCard in cardArray {
                                setResult.appendAttributedString(NSMutableAttributedString(string: " & "))
                                setResult.appendAttributedString(SetGameViewController.getAttributedString(oneCard as SetCard))
                            }
                            setResult.appendAttributedString(NSMutableAttributedString(string: " don't match: \(SET_MISMATCH_PENALTY) point penalty"))
                        }
                    }
                    score -= FLIP_COST
                }
                card.faceUp = !card.faceUp
            }
        }
        return (result, setResult)
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