//
//  Concentration.swift
//  Newconcentration
//
//  Created by 孙鹏鹏 on 2018/12/23.
//  Copyright © 2018 孙鹏鹏. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard : Int?
    
    func chooseCard(at index : Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards : Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        for i in cards.indices {
            let j = Int(arc4random_uniform(UInt32(cards.count)))
            if i != j {
                (cards[i],cards[j]) = (cards[j],cards[i])
            }
        }
    }
}
