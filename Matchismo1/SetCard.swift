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
    let SET_MATCH_SCORE = 3
    
    // MARK: Properties
    var shape: String! {
        didSet {
            if !contains(SetCard.validShapes(), shape) {
                shape = "?"
            }
            contents = "\(number)\(shape)\(color)\(shade)"
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
        var matched = false
        
        
        
        // for each card, update each dictionary. Key = string(color, number, etc) Value = count
        // if dictionary.count = 1 or 3 (also check the counts) then it is a valid match
        if otherCards.count >= 2{
            // create 4 dictionaries
            var shapeDictionary = [String: Int]()
            var colorDictionary = [String: Int]()
            var countDictionary = [Int: Int]()
            var shadeDictionary = [Double: Int]()
            
            // Mark first card
            shapeDictionary.updateValue(1, forKey: shape)
            colorDictionary.updateValue(1, forKey: color)
            countDictionary.updateValue(1, forKey: number)
            shadeDictionary.updateValue(1, forKey: shade)
            
            for otherCard in otherCards {
                if let setCard = otherCard as? SetCard {
                    // Shape
                    if let n = shapeDictionary[setCard.shape] {
                        shapeDictionary.updateValue(n + 1, forKey:setCard.shape)
                    } else {
                        shapeDictionary.updateValue(1, forKey:setCard.shape)
                    }
                    
                    // Color
                    if let n = colorDictionary[setCard.shape] {
                        colorDictionary.updateValue(n + 1, forKey:setCard.color)
                    } else {
                        colorDictionary.updateValue(1, forKey:setCard.color)
                    }
                    
                    // Shade
                    if let n = shadeDictionary[setCard.shade] {
                        shadeDictionary.updateValue(n + 1, forKey:setCard.shade)
                    } else {
                        shadeDictionary.updateValue(1, forKey:setCard.shade)
                    }
                    
                    // Count
                    if let n = countDictionary[setCard.number] {
                        countDictionary.updateValue(n + 1, forKey:setCard.number)
                    } else {
                        countDictionary.updateValue(1, forKey:setCard.number)
                    }
                }
            }
            
            if shapeDictionary.count != 2 && countDictionary.count != 2 && colorDictionary.count != 2 && shadeDictionary.count != 2{
                matched = true
            }
        }
        
        if matched {
            score = SET_MATCH_SCORE
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
        return [0.0, 0.2, 1.0]
    }
    
}
