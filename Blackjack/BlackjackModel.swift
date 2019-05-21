//
//  BlackjackModel.swift
//  Blackjack
//
//  Created by iOSDev on 5/20/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import Foundation

class BlackjackModel {
    var playerHand: [Int]
    var dealerHand: [Int]
    
    init() {
        playerHand = [Int]()
        dealerHand = [Int]()
    }
    
    func clearHands() {
        playerHand.removeAll()
        dealerHand.removeAll()
    }
}
