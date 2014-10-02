//
//  SetCard.swift
//  Matchismo1
//
//  Created by Derek Peck on 10/2/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

class SetCard : Card {
    
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
