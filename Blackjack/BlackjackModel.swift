//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by iOSDev on 5/20/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import Foundation

// I'm running Swift 4.1, so I need these extension methods for shuffling
/* Credit: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift/24029847 */

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

class BlackjackModel {
    var playerHand: [String]
    var dealerHand: [String]
    var deck: [String]
    var playerMoney: Double
    
    init() {
        playerHand = [String]()
        dealerHand = [String]()
        deck = [String]()
        playerMoney = 500.0
        
        deck = newDeck()
    }
    
    // Utility function for initializing a new deck
    func newDeck()->[String] {
        // Fill the deck with 4 of each card
        for i in 0...12 {
            // Start by translating the int to card type
            var temp = translate(cardNumber: i)
            
            // Now append four of each to the deck
            deck.append(temp)
            deck.append(temp)
            deck.append(temp)
            deck.append(temp)
        }
        
        // Obviously, deck needs to be shuffled
        deck.shuffle()
    }
    
    // Utility function for getting deck count
    // View controller uses it for displaying cards left
    func getDeckCount()->Int {
        return deck.count
    }
    
    // Utility function for translating integer number to card
    // type. 0 is A, 1 is 2, 2 is 3, ... , 10 is J, 11 is Q, 12
    // is K.
    func translate(cardNumber: Int)->String {
        var card: String
        
        switch cardNumber {
            case 0:
                card = "A"
            case 1:
                card = "2"
            case 2:
                card = "3"
            case 3:
                card = "4"
            case 4:
                card = "5"
            case 5:
                card = "6"
            case 6:
                card = "7"
            case 7:
                card = "8"
            case 8:
                card = "9"
            case 9:
                card = "10"
            case 10:
                card = "J"
            case 11:
                card = "Q"
            case 12:
                card = "K"
            default:
                card = "Error"
        }
        
        return card
    }
    
    // Evaluate a hand based on each string in the hand. Returns
    // a tuple because of A being worth either 1 or 11
    func evaluate(playerId: Int)->(Int, Int) {
        // Determine which hand needs to be evaluated
        let hand = playerId == 0 ? playerHand : dealerHand
        
        // Initialize the totals to return
        var lowerVal = 0
        var higherVal = 0
        
        for card in hand {
            if card == "A" {
                lowerVal += 1
                higherVal += 11
            } else if card == "J" || card == "Q" || card == "K" {
                lowerVal += 10
                higherVal += 10
            } else {
                lowerVal += Int(card)!
                higherVal += Int(card)!
            }
        }
        
        // Set each val to be -1 if they are greater than 21.
        // This would mean that the hand has bust.
        if higherVal > 21 {
            higherVal = -1
        }
        
        if lowerVal > 21 {
            lowerVal = -1
        }
        
        return (lowerVal, higherVal)
    }
    
    // Perform all the steps needed for the beginning of the game.
    // The return tuple is the four cards dealt needed for the view.
    func startHands(playerBet: Double)->(String, String, String, String) {
        // 1. Check if the deck needs to be reset
        var size = getDeckCount()
        if size < 10 {
            deck = newDeck()
        }
        
        // 2. Remove player bet from their total
        playerMoney -= playerBet
        
        // 3. Deal the cards alternating between dealer/player
        var playerFirst = draw(playerId: 0)
        var dealerFirst = draw(playerId: 1)
        var playerSecond = draw(playerId: 0)
        var dealerSecond = draw(playerId: 1)
        
        // 4. Return the result tuple
        return (playerFirst, dealerFirst, playerSecond, dealerSecond)
    }
    
    // Perform a draw for a single card
    func draw(playerId: Int)->String {
        var size = getDeckCount()
        var card = deck[size-1]
        deck.remove(at: size-1)
        
        // Check which hand needs to be updated
        if playerId == 0 {
            playerHand.append(card)
        } else {
            dealerhand.append(card)
        }
        
        return card
    }
    
    // Clear the hands after a complete round
    func clearHands() {
        playerHand.removeAll()
        dealerHand.removeAll()
    }
}
