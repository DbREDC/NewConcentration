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
    var cardDidAppear = [Int:Bool]()
    var indexDidAppear = [Int:Bool]()
    var totalScore = 0
    
    func chooseCard(at index : Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    totalScore += 2
                    cardDidAppear[cards[index].identifier] = nil
                }
                //实现减分,如果两张牌之前都出现过,-2,如果第一张牌是之前出现过的,但是第二张牌之前没出现
                if cardDidAppear[cards[index].identifier] ?? false,cardDidAppear[cards[matchIndex].identifier] ?? false{
                    totalScore += -2
                }else if cardDidAppear[cards[matchIndex].identifier] == nil , !(indexDidAppear[index] ?? false){
                    
                }else if cardDidAppear[cards[index].identifier] ?? false || cardDidAppear[cards[matchIndex].identifier] ?? false {
                    totalScore += -1
                }
                
                cardDidAppear[cards[matchIndex].identifier] = true
                cardDidAppear[cards[index].identifier] = true
                indexDidAppear[index] = true
                indexDidAppear[matchIndex] = true
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
    
    
    func startNewGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].didAppear = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        cardDidAppear = [Int:Bool]()
        totalScore = 0
        shuffleCards()
    }
    
    func shuffleCards() {
        for i in cards.indices {
            let j = Int(arc4random_uniform(UInt32(cards.count)))
            if i != j {
                (cards[i],cards[j]) = (cards[j],cards[i])
            }
        }
    }
    
    init(numberOfPairsOfCards : Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        shuffleCards()
    }
}
