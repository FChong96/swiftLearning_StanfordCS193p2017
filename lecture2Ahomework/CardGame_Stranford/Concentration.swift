//
//  Concentration.swift
//  CardGame_Stranford
//
//  Created by 冯冲 on 2019/12/9.
//  Copyright © 2019 冯冲. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card] ()
    var startCard:Bool?
    
    var indexOfOneAndOnlyFaceUpCard:Int?
    
    func chooseCard(at index:Int)
    {
        if startCard == true {
            Card.identifierFactory = 0
            
            for index in cards.indices{
                cards[index].isMatched = false
                cards[index].isFaceUp = false
            }
            
            indexOfOneAndOnlyFaceUpCard = nil
            startCard = false
        }
        
        if !cards[index].isMatched{
            //这里引用matchIndex表示之前被翻的牌的索引，如果有值则表示有一张牌已经翻了
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil //不管匹不匹配，此时两张牌朝上
            }else{
                //这里是说没有牌被翻或者有两张牌被翻，此时indexOfOneAndOnlyFaceUpCard中没有值
                for filpDownIndex in cards.indices{
                    cards[filpDownIndex].isFaceUp = false
                }//无论哪种情况这里的牌都应该是背面
                //然后翻这次的牌
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int){
    
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
        
        //shuffle the cards（洗牌）
        for shuffleIndex in cards.indices{
            let randomIndex = Int(arc4random_uniform(UInt32(2 * numberOfPairsOfCards - 2)))
            let current = cards[shuffleIndex]
            cards[shuffleIndex] = cards[randomIndex]
            cards[randomIndex] = current
        }
        
    }
}
