//
//  CardGameViewController.swift
//  Matchismo1
//
//  Created by Steve Liddle on 9/10/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import UIKit

class CardGameViewController : UIViewController {
  
  var game: CardMatchingGame!
  lazy var cards: [UIButton: Card]! = [UIButton: Card]()
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var flipLabel: UILabel!
//  @IBOutlet weak var gameModeSwitch: UISegmentedControl!
  @IBOutlet weak var historyLabel: UILabel!
  
  @IBOutlet var cardButtons: [UIButton]! {
    didSet {
      game = CardMatchingGame(cardCount: cardButtons.count, deck: PlayingCardDeck())
    }
  }

  //MARK: Useful functions ---------------
  
  var flipCount: Int = 0 {
      didSet {
        flipLabel.text = "Flips: \(flipCount)"
      }
  }
  
  var results: String = "" {
    didSet {
      historyLabel.text = results
    }
  }
  
  
  func updateUI() {
    let cardBack = UIImage(named: "CardBack")
    let cardFront = UIImage(named: "CardFront")
    var flippedCards: [Card] = [Card]()
    
    for button in cardButtons {
      let card = game.cardAtIndex(indexOfButton(button))!
      
      if card.faceUp {
        button.setTitle(card.contents, forState: .Normal)
        button.setBackgroundImage(cardFront, forState: .Normal)
        button.enabled = !card.unplayable
        flippedCards.append(card)
      } else {
        button.setTitle("", forState: .Normal)
        button.setBackgroundImage(cardBack, forState: .Normal)
      }
    }
    scoreLabel.text = "Score: \(game.currentScore())"
  }
  
  func indexOfButton(button: UIButton) -> Int {
    for i in 0 ..< cardButtons.count {
      if button == cardButtons[i] {
        return i
      }
    }
    return -1
  }
  
  //MARK: UI Interactions ---------------
  
  @IBAction func flipCard(sender: UIButton) {
    results = game.flipCardAtIndex(indexOfButton(sender))!
    ++flipCount
    updateUI()
//    gameModeSwitch.enabled = false
  }
  
  @IBAction func dealNewGame(sender: UIButton) {
    game = CardMatchingGame(cardCount: cardButtons.count, deck: PlayingCardDeck())
    flipCount = 0
    for button in cardButtons {
      button.enabled = true
    }
    updateUI()
//    gameModeSwitch.enabled = true
    results = ""
  }

//  @IBAction func indexChanged(sender: UISegmentedControl) {
//    switch gameModeSwitch.selectedSegmentIndex {
//      case 0:
//        print("2 Card\n");
//      case 1:
//        print("3 Card\n");
//      default:
//        break;
//    }
//  }
}





