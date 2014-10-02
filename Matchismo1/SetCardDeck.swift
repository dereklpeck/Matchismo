//
//  SetCardDeck.swift
//  Matchismo1
//
//  Created by Derek Peck on 10/2/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

class SetCardDeck: Deck {
    override init() {
        super.init()
        
        for shape in SetCard.validShapes() {
            for color in SetCard.validColors() {
                for shade in SetCard.validShades() {
                    for number in 1 ... SetCard.maxNumber() {
                        var card = SetCard()
                        
                        card.number = number
                        card.shade = shade
                        card.color = color
                        card.shape = shape
                        addCard(card, atTop: true)
                    }
                }
            }
        }
    }
}
