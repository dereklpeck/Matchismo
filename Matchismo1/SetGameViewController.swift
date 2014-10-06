//
//  SetGameViewController.swift
//  Matchismo1
//
//  Created by Derek Peck on 10/6/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import UIKit

class SetGameViewController : UIViewController {
    var game: CardMatchingGame!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            game = CardMatchingGame(cardCount: cardButtons.count, deck: SetCardDeck())
            drawCards()
        }
    }
    
    // MARK: Useful functions ---------------
    
    var flipCount: Int = 0 {
        didSet {
            flipLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var results: NSAttributedString = NSAttributedString(string: "") {
        didSet {
            historyLabel.attributedText = results
        }
    }
    
    func indexOfButton(button: UIButton) -> Int {
        for i in 0 ..< cardButtons.count {
            if button == cardButtons[i] {
                return i
            }
        }
        return -1
    }
    
    func updateUI() {
        for button in cardButtons {
            let card = game.cardAtIndex(indexOfButton(button))!
            button.enabled = !card.unplayable
        }
        scoreLabel.text = "Score: \(game.currentScore())"
    }
    
    func drawCards() {
        for button in cardButtons {
            let card = game.cardAtIndex(indexOfButton(button))!
            button.setAttributedTitle(SetGameViewController.getAttributedString(card as SetCard), forState: .Normal)
        }
    }
    
    class func getAttributedString(card: SetCard) -> NSAttributedString {
        var contents = NSMutableAttributedString(string: "")
        println("Card Contents: " + card.contents)
        for i in 1 ... card.number {
            var temp = NSMutableAttributedString(string: card.shape)
            switch card.color {
                case "Blue":
                    temp.addAttributes([NSForegroundColorAttributeName: UIColor.blueColor().colorWithAlphaComponent(CGFloat(card.shade)), NSStrokeWidthAttributeName : -5,
                        NSStrokeColorAttributeName : UIColor.blueColor()], range: NSRange(location: 0,length: temp.length))
                case "Green":
                            temp.addAttributes([NSForegroundColorAttributeName: UIColor.greenColor().colorWithAlphaComponent(CGFloat(card.shade)), NSStrokeWidthAttributeName : -5,
                    NSStrokeColorAttributeName : UIColor.greenColor()], range: NSRange(location: 0,length: temp.length))                case "Red":
                    temp.addAttributes([NSForegroundColorAttributeName: UIColor.redColor().colorWithAlphaComponent(CGFloat(card.shade)), NSStrokeWidthAttributeName : -5,
                                NSStrokeColorAttributeName : UIColor.redColor()], range: NSRange(location: 0,length: temp.length))            default:
                                temp.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor().colorWithAlphaComponent(CGFloat(card.shade)), NSStrokeWidthAttributeName : -5,
                        NSStrokeColorAttributeName : UIColor.blackColor()], range: NSRange(location: 0,length: temp.length))
            }
            contents.appendAttributedString(temp)
        }
        
        return contents
    }
    
    // MARK: UI Interactions ---------------
    
    @IBAction func selectCard(sender: UIButton) {
        var output = game.flipCardAtIndex(indexOfButton(sender), mode: 1)
        results = output.attributed!
        ++flipCount
        updateUI()
    }
    
    @IBAction func dealNewGame(sender: UIButton) {
        game = CardMatchingGame(cardCount: cardButtons.count, deck: SetCardDeck())
        flipCount = 0
        for button in cardButtons {
            button.enabled = true
        }
        updateUI()
        results = NSMutableAttributedString(string: "")
    }
    
}