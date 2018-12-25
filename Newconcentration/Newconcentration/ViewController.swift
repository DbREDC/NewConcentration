//
//  ViewController.swift
//  Newconcentration
//
//  Created by 孙鹏鹏 on 2018/12/18.
//  Copyright © 2018 孙鹏鹏.a All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards : (buttonGroup.count + 1) / 2)

    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "FlipCount : \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var buttonGroup: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = buttonGroup.index(of : sender){
            flipCount += 1
            game.chooseCard(at: cardNumber)
            updateViewFormModel()
            //filpCard(withEmoji: emojiGroup[cardNumber], on: sender)
        }
    }
    
    func updateViewFormModel() {
        for index in buttonGroup.indices {
            let button = buttonGroup[index]
            let card = game.cards[index]
            if !card.isFaceUp {
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.setTitle(" ", for: UIControl.State.normal)
            }else{
                button.backgroundColor =  #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                button.setTitle(getEmoji(for : card), for: UIControl.State.normal)
            }
        }
    }
    var emojiGroup = ["😈","👻","💄","💍","🐶","🐷","🐸","🐵","🐥","🦄","🐠","🦀","🐿","🍄","🍎","🥝","🌽","🍞","🍔","🍙","🏀","🎲","🚗","🚄","⌚️","⏰"]
    
    var emoji = [Int:String]()
    
    func getEmoji(for card : Card) -> String {
        if emoji[card.identifier] == nil , emojiGroup.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiGroup.count)))
            emoji[card.identifier] = emojiGroup.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // shuffleEmoji()
    }
    
//    func shuffleEmoji() {
//        let emojiNumber = emojiGroup.count
//        for i in 0..<emojiNumber {
//            let j = Int(arc4random_uniform(UInt32(emojiNumber-i)))+i
//            if i != j {
//                (emojiGroup[i],emojiGroup[j]) = (emojiGroup[j],emojiGroup[i])
//            }
//        }
//    }
    
}

