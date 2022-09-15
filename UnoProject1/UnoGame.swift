//
//  UnoGame.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import Foundation
import UIKit
import SwiftUI

struct UnoGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var p1Cards: Array<Card>
    private(set) var p2Cards: Array<Card>
    private(set) var p3Cards: Array<Card>
    private(set) var p4Cards: Array<Card>
    private(set) var inPlayCards: Array<Card>
    var handSize: Int
    var newGame: Bool = false
    var turn: Int
    var topCardNumber: Int
    var topCardColor: Color
    
    init() {
        cards = Array<Card>()
        p1Cards = Array<Card>()
        p2Cards = Array<Card>()
        p3Cards = Array<Card>()
        p4Cards = Array<Card>()
        inPlayCards = Array<Card>()
        handSize = 5;
        turn = 1;
        
        cards.append(Card(number: 0, color: Color.blue, id: 1))
        cards.append(Card(number: 1, color: Color.blue, id: 2))
        cards.append(Card(number: 2, color: Color.blue, id: 3))
        cards.append(Card(number: 3, color: Color.blue, id: 4))
        cards.append(Card(number: 4, color: Color.blue, id: 5))
        cards.append(Card(number: 5, color: Color.blue, id: 6))
        cards.append(Card(number: 6, color: Color.blue, id: 7))
        cards.append(Card(number: 7, color: Color.blue, id: 8))
        cards.append(Card(number: 8, color: Color.blue, id: 9))
        cards.append(Card(number: 9, color: Color.blue, id: 10))
        cards.append(Card(number: 0, color: Color.blue, id: 41))
        cards.append(Card(number: 1, color: Color.blue, id: 42))
        cards.append(Card(number: 2, color: Color.blue, id: 43))
        cards.append(Card(number: 3, color: Color.blue, id: 44))
        cards.append(Card(number: 4, color: Color.blue, id: 45))
        cards.append(Card(number: 5, color: Color.blue, id: 46))
        cards.append(Card(number: 6, color: Color.blue, id: 47))
        cards.append(Card(number: 7, color: Color.blue, id: 48))
        cards.append(Card(number: 8, color: Color.blue, id: 49))
        cards.append(Card(number: 9, color: Color.blue, id: 50))
        
        cards.append(Card(number: 0, color: Color.red, id: 11))
        cards.append(Card(number: 1, color: Color.red, id: 12))
        cards.append(Card(number: 2, color: Color.red, id: 13))
        cards.append(Card(number: 3, color: Color.red, id: 14))
        cards.append(Card(number: 4, color: Color.red, id: 15))
        cards.append(Card(number: 5, color: Color.red, id: 16))
        cards.append(Card(number: 6, color: Color.red, id: 17))
        cards.append(Card(number: 7, color: Color.red, id: 18))
        cards.append(Card(number: 8, color: Color.red, id: 19))
        cards.append(Card(number: 9, color: Color.red, id: 20))
        cards.append(Card(number: 0, color: Color.red, id: 51))
        cards.append(Card(number: 1, color: Color.red, id: 52))
        cards.append(Card(number: 2, color: Color.red, id: 53))
        cards.append(Card(number: 3, color: Color.red, id: 54))
        cards.append(Card(number: 4, color: Color.red, id: 55))
        cards.append(Card(number: 5, color: Color.red, id: 56))
        cards.append(Card(number: 6, color: Color.red, id: 57))
        cards.append(Card(number: 7, color: Color.red, id: 58))
        cards.append(Card(number: 8, color: Color.red, id: 59))
        cards.append(Card(number: 9, color: Color.red, id: 60))
        
        cards.append(Card(number: 0, color: Color.yellow, id: 21))
        cards.append(Card(number: 1, color: Color.yellow, id: 22))
        cards.append(Card(number: 2, color: Color.yellow, id: 23))
        cards.append(Card(number: 3, color: Color.yellow, id: 24))
        cards.append(Card(number: 4, color: Color.yellow, id: 25))
        cards.append(Card(number: 5, color: Color.yellow, id: 26))
        cards.append(Card(number: 6, color: Color.yellow, id: 27))
        cards.append(Card(number: 7, color: Color.yellow, id: 28))
        cards.append(Card(number: 8, color: Color.yellow, id: 29))
        cards.append(Card(number: 9, color: Color.yellow, id: 30))
        cards.append(Card(number: 0, color: Color.yellow, id: 61))
        cards.append(Card(number: 1, color: Color.yellow, id: 62))
        cards.append(Card(number: 2, color: Color.yellow, id: 63))
        cards.append(Card(number: 3, color: Color.yellow, id: 64))
        cards.append(Card(number: 4, color: Color.yellow, id: 65))
        cards.append(Card(number: 5, color: Color.yellow, id: 66))
        cards.append(Card(number: 6, color: Color.yellow, id: 67))
        cards.append(Card(number: 7, color: Color.yellow, id: 68))
        cards.append(Card(number: 8, color: Color.yellow, id: 69))
        cards.append(Card(number: 9, color: Color.yellow, id: 70))
        
        cards.append(Card(number: 0, color: Color.green, id: 31))
        cards.append(Card(number: 1, color: Color.green, id: 32))
        cards.append(Card(number: 2, color: Color.green, id: 33))
        cards.append(Card(number: 3, color: Color.green, id: 34))
        cards.append(Card(number: 4, color: Color.green, id: 35))
        cards.append(Card(number: 5, color: Color.green, id: 36))
        cards.append(Card(number: 6, color: Color.green, id: 37))
        cards.append(Card(number: 7, color: Color.green, id: 38))
        cards.append(Card(number: 8, color: Color.green, id: 39))
        cards.append(Card(number: 9, color: Color.green, id: 40))
        cards.append(Card(number: 0, color: Color.green, id: 71))
        cards.append(Card(number: 1, color: Color.green, id: 72))
        cards.append(Card(number: 2, color: Color.green, id: 73))
        cards.append(Card(number: 3, color: Color.green, id: 74))
        cards.append(Card(number: 4, color: Color.green, id: 75))
        cards.append(Card(number: 5, color: Color.green, id: 76))
        cards.append(Card(number: 6, color: Color.green, id: 77))
        cards.append(Card(number: 7, color: Color.green, id: 78))
        cards.append(Card(number: 8, color: Color.green, id: 79))
        cards.append(Card(number: 9, color: Color.green, id: 80))
        
        cards.shuffle()
        
        for _ in 1...handSize {
            var playerOneCard = cards.first!
            playerOneCard.isFaceUp = true
            p1Cards.append(playerOneCard)
            cards.removeFirst(1)
            p2Cards.append(cards.first!)
            cards.removeFirst(1)
            p3Cards.append(cards.first!)
            cards.removeFirst(1)
            p4Cards.append(cards.first!)
            cards.removeFirst(1)
        }
        var firstCard = cards.first!
        firstCard.isFaceUp.toggle()
        
        cards.removeFirst(1)
        inPlayCards.append(firstCard)
        
        
        topCardNumber = inPlayCards[0].number
        topCardColor = inPlayCards[0].color
    }
    
    mutating func playCard(card: Card, player: Int) {
        if player == 1 {
            if let chosenIndex = p1Cards.firstIndex(matching: card) {
                let playedCard = p1Cards.remove(at: chosenIndex)
                inPlayCards.append(playedCard)
            }
        } else if  player == 2 {
            if let chosenIndex = p2Cards.firstIndex(matching: card) {
                var playedCard = p2Cards.remove(at: chosenIndex)
                playedCard.isFaceUp.toggle()
                inPlayCards.append(playedCard)
            }
        } else if player == 3 {
            if let chosenIndex = p3Cards.firstIndex(matching: card) {
                var playedCard = p3Cards.remove(at: chosenIndex)
                playedCard.isFaceUp.toggle()
                inPlayCards.append(playedCard)
            }
        } else {
            if let chosenIndex = p4Cards.firstIndex(matching: card) {
                var playedCard = p4Cards.remove(at: chosenIndex)
                playedCard.isFaceUp.toggle()
                inPlayCards.append(playedCard)
            }
        }
        topCardNumber = card.number
        topCardColor = card.color
    }
    
    mutating func drawCard(player: Int) {
        if var topCard = cards.last {
            cards.removeLast(1)
            
            if player == 1 {
                topCard.isFaceUp.toggle()
                p1Cards.append(topCard)
            } else if player == 2 {
                p2Cards.append(topCard)
            } else if player == 3 {
                p3Cards.append(topCard)
            } else {
                p4Cards.append(topCard)
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isPlayable = false
        var number: Int
        var color: Color
        var id: Int
    }
}
