//
//  Card.swift
//  Newconcentration
//
//  Created by 孙鹏鹏 on 2018/12/23.
//  Copyright © 2018 孙鹏鹏. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
