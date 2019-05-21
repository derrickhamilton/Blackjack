//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by iOSDev on 5/20/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import Foundation

class BlackjackModel {
    var playerHand: [String]
    var dealerHand: [String]
    var deck: [Int]
    
    init() {
        playerHand = [String]()
        dealerHand = [String]()
        deck = [Int]()
        
        // Fill the deck with 4 of each card
        for _ in 0...12 {
            deck.append(4)
        }
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
    
    // Clear the hands after a complete round
    func clearHands() {
        playerHand.removeAll()
        dealerHand.removeAll()
    }
}
