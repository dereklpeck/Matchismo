//
//  SetCard.swift
//  Matchismo1
//
//  Created by Derek Peck on 10/2/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

class SetCard : Card {
    
    // MARK: Class Variables
    let SUIT_MATCH_SCORE = 1
    
    //MARK: Properties
    var shape: String! {
        didSet {
            if !contains(SetCard.validShapes(), shape) {
                shape = "?"
            }
        }
    }
    
    var number: Int! {
        didSet {
            if number < 0 || number > SetCard.maxNumber() {
                number = 0
            }
        }
    }
    
    var color: String! {
        didSet {
            if !contains(SetCard.validColors(), color) {
                color = "?"
            }
        }
    }
    
    var shade: Double! {
        didSet {
            if !contains(SetCard.validShades(), shade) {
                shade = 0
            }
        }
    }
    
    // MARK: Match Function
    
    override func match(otherCards: [Card]) -> Int {
        var score = 0
        var matchedSuit = true
        var matchedRank = true
        // Match 2 cards
        if otherCards.count == 2 { // Match 3 cards
            
//            if let otherCard = otherCards.last as? PlayingCard {
//                if otherCard.suit == suit {
//                    score = SUIT_MATCH_SCORE
//                } else if otherCard.rank == rank {
//                    score = RANK_MATCH_SCORE
//                }
//            }
        }
        return score
    }
    
    // MARK: Helper Methods
    
    class func validShapes() -> [String] {
        return ["▲", "●", "■"]
    }
    
    class func validColors() -> [String] {
        return ["Blue", "Red", "Green"]
    }
    
    private class func shapeNumbers() -> [String] {
        return ["1", "2", "3"]
    }
    
    class func maxNumber() -> Int {
        return shapeNumbers().count
    }
    
    class func validShades() -> [Double] {
        return [0.0, 0.5, 1.0]
    }
    
}
