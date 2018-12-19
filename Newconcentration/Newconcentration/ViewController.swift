//
//  ViewController.swift
//  Newconcentration
//
//  Created by 孙鹏鹏 on 2018/12/18.
//  Copyright © 2018 孙鹏鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emojiGroup = ["😈","👻","💄","💍","🐶","🐷","🐸","🐵","🐥","🦄","🐠","🦀","🐿","🍄","🍎","🥝","🌽","🍞","🍔","🍙","🏀","🎲","🚗","🚄","⌚️","⏰"]
    
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
            filpCard(withEmoji: emojiGroup[cardNumber], on: sender)
        }
    }
    
    func filpCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle(" ", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleEmoji()
    }
    
    func shuffleEmoji() {
        let emojiNumber = emojiGroup.count
        for i in 0..<emojiNumber {
            let j = Int(arc4random_uniform(UInt32(emojiNumber-i)))+i
            if i != j {
                (emojiGroup[i],emojiGroup[j]) = (emojiGroup[j],emojiGroup[i])
            }
        }
    }
    
}

