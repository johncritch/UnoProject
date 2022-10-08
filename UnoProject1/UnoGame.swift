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
    private(set) var players: Array<Player>
    private(set) var inPlayCards: Array<Card>
    var handSize: Int
    var newGame: Bool = false
    var turn: Int
    var firstCard: Card
    var topCardNumber: Int
    var topCardColor: Color
    var displayMessage: String
    var colors = [Color.red, Color.blue, Color.yellow, Color.green]
    
    init() {
        cards = Array<Card>()
        
        players = [
            Player(id: 1),
            Player(id: 2),
            Player(id: 3),
            Player(id: 4),
            Player(id: 5)
        ]
        
        inPlayCards = Array<Card>()
        
        handSize = 7;
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
        
        cards.append(Card(number: 10, color: Color.red, id: 81))
        cards.append(Card(number: 10, color: Color.blue, id: 82))
        cards.append(Card(number: 10, color: Color.blue, id: 83))
        cards.append(Card(number: 10, color: Color.green, id: 84))
        cards.append(Card(number: 10, color: Color.green, id: 85))
        cards.append(Card(number: 10, color: Color.yellow, id: 86))
        cards.append(Card(number: 10, color: Color.yellow, id: 87))
        cards.append(Card(number: 10, color: Color.red, id: 88))
        
        cards.append(Card(number: 11, color: Color.red, id: 90))
        cards.append(Card(number: 11, color: Color.red, id: 91))
        cards.append(Card(number: 11, color: Color.blue, id: 92))
        cards.append(Card(number: 11, color: Color.blue, id: 93))
        cards.append(Card(number: 11, color: Color.green, id: 94))
        cards.append(Card(number: 11, color: Color.green, id: 95))
        cards.append(Card(number: 11, color: Color.yellow, id: 96))
        cards.append(Card(number: 11, color: Color.yellow, id: 97))
        
        cards.append(Card(number: 12, color: Color.red, id: 100))
        cards.append(Card(number: 12, color: Color.red, id: 101))
        cards.append(Card(number: 12, color: Color.blue, id: 102))
        cards.append(Card(number: 12, color: Color.blue, id: 103))
        cards.append(Card(number: 12, color: Color.green, id: 104))
        cards.append(Card(number: 12, color: Color.green, id: 105))
        cards.append(Card(number: 12, color: Color.yellow, id: 106))
        cards.append(Card(number: 12, color: Color.yellow, id: 107))
        
        cards.append(Card(number: 13, color: Color.black, id: 110))
        cards.append(Card(number: 13, color: Color.black, id: 111))
        cards.append(Card(number: 13, color: Color.black, id: 112))
        cards.append(Card(number: 13, color: Color.black, id: 113))
        cards.append(Card(number: 13, color: Color.black, id: 114))
        cards.append(Card(number: 14, color: Color.black, id: 115))
        cards.append(Card(number: 14, color: Color.black, id: 116))
        cards.append(Card(number: 14, color: Color.black, id: 117))
        
        cards.shuffle()
        
        for _ in 1...handSize {
            var playerCard = cards.first!
            playerCard.isFaceUp = true
            playerCard.isDealt = false
            players[0].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            players[1].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            players[2].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            players[3].cards.append(playerCard)
            cards.removeFirst(1)
            
            
        }
        
        for _ in 0...0 {
            var playerCard = cards.first!
            
        }
        var playerCard = cards.first!
        playerCard.isDealt = false
        players[4].cards.append(playerCard)
        cards.removeFirst(1)
        
        firstCard = cards.first!
        firstCard.isFaceUp.toggle()

        if firstCard.color == Color.black {
            firstCard.color = Color.red
        }
        
        cards.removeFirst(1)
        inPlayCards.append(firstCard)
        
        
        topCardNumber = inPlayCards[0].number
        topCardColor = inPlayCards[0].color
        
        displayMessage = ""
    }
    
    mutating func playCard(card: Card, player: Player, desiredColor: Color = Color.red, message: String = "") {
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenCardIndex = players[chosenPlayerIndex].cards.firstIndex(matching: card) {
                var playedCard = players[chosenPlayerIndex].cards.remove(at: chosenCardIndex)
                playedCard.isFaceUp = true
                if playedCard.color == Color.black {
                    if player.id != 1 {
                        playedCard.color = colors.randomElement()!
                    } else {
                        playedCard.color = desiredColor
                    }
                }
                inPlayCards.append(playedCard)
                displayMessage = message
            }
        }
    }
//                var playedCard = p1Cards.remove(at: chosenIndex)
//                if playedCard.color == Color.black {
//                    playedCard.color = Color.red
//                    card.color = Color.red
//                }
//                inPlayCards.append(playedCard)
//            }
//        } else if  player == 2 {
//            if let chosenIndex = p2Cards.firstIndex(matching: card) {
//                var playedCard = p2Cards.remove(at: chosenIndex)
//                playedCard.isFaceUp.toggle()
//                if playedCard.color == Color.black {
//                    playedCard.color = Color.red
//                    card.color = Color.red
//                }
//                inPlayCards.append(playedCard)
//            }
//        } else if player == 3 {
//            if let chosenIndex = p3Cards.firstIndex(matching: card) {
//                var playedCard = p3Cards.remove(at: chosenIndex)
//                playedCard.isFaceUp.toggle()
//                if playedCard.color == Color.black {
//                    playedCard.color = Color.red
//                    card.color = Color.red
//                }
//                inPlayCards.append(playedCard)
//            }
//        } else {
//            if let chosenIndex = p4Cards.firstIndex(matching: card) {
//                var playedCard = p4Cards.remove(at: chosenIndex)
//                playedCard.isFaceUp.toggle()
//                if playedCard.color == Color.black {
//                    playedCard.color = Color.red
//                    card.color = Color.red
//                }
//                inPlayCards.append(playedCard)
//            }
//        }
//        topCardNumber = card.number
//        topCardColor = card.color
//    }
    
    mutating func drawCard(card: Card, player: Player, message: String = "") {
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenIndex = cards.firstIndex(matching: card) {
                var drawnCard = cards.remove(at: chosenIndex)
                if player.id == 1 {
                    drawnCard.isFaceUp = true
                }
                players[chosenPlayerIndex].cards.append(drawnCard)
                displayMessage = message
            }
        }
    }
//        if var topCard = cards.last! {
//            if let chosenIndex = cards.firstIndex(matching: cards.l) {
//                cards[chosenIndex].player = 5
//            cards.removeLast(1)
//
//            if player == 1 {
//                topCard.isFaceUp.toggle()
//                p1Cards.append(topCard)
//            } else if player == 2 {
//                p2Cards.append(topCard)
//            } else if player == 3 {
//                p3Cards.append(topCard)
//            } else {
//                p4Cards.append(topCard)
//            }
//        }
//    }

    
    mutating func deal(cardIndex: Int) {
        if cardIndex >= 0 && cardIndex < handSize {
            players[0].cards[cardIndex].isDealt = true
        }
        if cardIndex >= handSize && cardIndex < handSize * 2 {
            players[1].cards[cardIndex - handSize].isDealt = true
        }
        if cardIndex >= handSize * 2 && cardIndex < handSize * 3 {
            players[2].cards[cardIndex - (handSize * 2)].isDealt = true
        }
        if cardIndex >= handSize * 3 && cardIndex < handSize * 4 {
            players[3].cards[cardIndex - (handSize * 3)].isDealt = true
        }
    }
    
    struct Player: Identifiable {
        var cards = Array<Card>()
        var id: Int
    }
    
    struct Card: Identifiable {
        fileprivate(set) var isDealt = true
        var tilt = Double.random(in: -3...3)
        var player = 0
        var isFaceUp = true
        var number: Int
        var color: Color
        var id: Int
    }
}

