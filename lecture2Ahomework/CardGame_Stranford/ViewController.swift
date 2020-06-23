//
//  ViewController.swift
//  CardGame_Stranford
//
//  Created by 冯冲 on 2019/11/12.
//  Copyright © 2019 冯冲. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards:(cardsButton.count + 1 ) / 2)//classes get a free init with no arguments
    
    var flipCount:Int = 0{
        didSet{
            flipConutLabel.text = "flips:\(flipCount)"
        }
    }
    
    @IBOutlet weak var flipConutLabel: UILabel!
    @IBOutlet var cardsButton: [UIButton]!
    
    //MARK:handle start/restart
    @IBAction func startGame(_ sender: Any) {
        flipCount = 0
        game.startCard = true
        for index in cardsButton.indices{
            let button = cardsButton[index]

            button.setTitle(" ", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1

        if let cardNumber = cardsButton.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else{
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
        for index in cardsButton.indices{
            let button = cardsButton[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle(" ", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["👻","🎃","🤡","👹","🐲","👿"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        //如果字典里没有表情，而数组中有，会随机选择一个表情放入字典并在数组中删除
        if emoji[card.identifier] == nil, emojiChoices.count>0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
     }
}

