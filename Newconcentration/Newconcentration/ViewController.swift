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
    
    var cardDidAppear = [Int:Bool]()
    
    var scoreCount = 0 {
        didSet {
            scoreLable.text = "Score : \(scoreCount)"
        }
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.startNewGame()
        emoji = [Int:String]()
        currentTheme = chooseTheme()
        flipCount = 0
        updateViewFormModel()
    }
    
    @IBOutlet var buttonGroup: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = buttonGroup.index(of : sender){
            flipCount += 1
            game.chooseCard(at: cardNumber)
            updateViewFormModel()
        }
    }
    
    func updateViewFormModel() {
        scoreCount = game.totalScore
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
    
    var emojiTheme = [["🐶","🐱","🐭","🐸","🐵","🐔","🐥","🦋","🦀","🐅"],["🍏","🍎","🍉","🍇","🍒","🌽","🍆","🥦","🌭","🍔"],["⚽️","🏀","🏈","🎱","🏓","🥊","🎽","🎹","🎼"],["🚗","🚌","🚒","🚲","🚖","🚄","🚆","✈️","🛳","🚁"],["⌚️","🖨","🖥","📞","⏱","🔋","🔌","🛢","⛏","🔑"],["😀","😅","😇","😍","😋","🤨","😏","😡","😰","🤩"]]
    
    var currentTheme = [String]()
    
    var emoji = [Int:String]()
    
    func getEmoji(for card : Card) -> String {
        
        if emoji[card.identifier] == nil , currentTheme.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(currentTheme.count)))
            emoji[card.identifier] = currentTheme.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func chooseTheme() -> [String] {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiTheme.count)))
        return emojiTheme[randomIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.startNewGame()
        currentTheme = chooseTheme()
        scoreCount = 0
    }
    
}

