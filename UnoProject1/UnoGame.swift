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
    var turn: Int
    var firstCard: Card
    var topCardNumber: Int
    var topCardColor: Color
    var displayMessage: String
    var colors = [Color.red, Color.blue, Color.yellow, Color.green]
    var isWinner = false
    var winningMessage = ""
    
    init() {
        cards = Array<Card>()
        
        players = [
            Player(isOnSide: false, id: 0),
            Player(isOnSide: false, id: 1),
            Player(isOnSide: true, id: 2),
            Player(isOnSide: false, id: 3),
            Player(isOnSide: true, id: 4)
        ]
        
        inPlayCards = Array<Card>()
        
        handSize = 7;
        turn = 1;
        
        cards.append(Card(number: 0, color: Color.blue, id: 1, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.blue, id: 2, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.blue, id: 3, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.blue, id: 4, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.blue, id: 5, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.blue, id: 6, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.blue, id: 7, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.blue, id: 8, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.blue, id: 9, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.blue, id: 10, x: 0, y: 0))
        cards.append(Card(number: 0, color: Color.blue, id: 41, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.blue, id: 42, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.blue, id: 43, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.blue, id: 44, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.blue, id: 45, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.blue, id: 46, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.blue, id: 47, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.blue, id: 48, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.blue, id: 49, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.blue, id: 50, x: 0, y: 0))
        
        cards.append(Card(number: 0, color: Color.red, id: 11, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.red, id: 12, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.red, id: 13, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.red, id: 14, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.red, id: 15, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.red, id: 16, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.red, id: 17, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.red, id: 18, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.red, id: 19, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.red, id: 20, x: 0, y: 0))
        cards.append(Card(number: 0, color: Color.red, id: 51, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.red, id: 52, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.red, id: 53, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.red, id: 54, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.red, id: 55, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.red, id: 56, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.red, id: 57, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.red, id: 58, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.red, id: 59, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.red, id: 60, x: 0, y: 0))
        
        cards.append(Card(number: 0, color: Color.yellow, id: 21, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.yellow, id: 22, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.yellow, id: 23, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.yellow, id: 24, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.yellow, id: 25, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.yellow, id: 26, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.yellow, id: 27, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.yellow, id: 28, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.yellow, id: 29, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.yellow, id: 30, x: 0, y: 0))
        cards.append(Card(number: 0, color: Color.yellow, id: 61, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.yellow, id: 62, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.yellow, id: 63, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.yellow, id: 64, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.yellow, id: 65, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.yellow, id: 66, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.yellow, id: 67, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.yellow, id: 68, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.yellow, id: 69, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.yellow, id: 70, x: 0, y: 0))
        
        cards.append(Card(number: 0, color: Color.green, id: 31, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.green, id: 32, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.green, id: 33, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.green, id: 34, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.green, id: 35, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.green, id: 36, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.green, id: 37, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.green, id: 38, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.green, id: 39, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.green, id: 40, x: 0, y: 0))
        cards.append(Card(number: 0, color: Color.green, id: 71, x: 0, y: 0))
        cards.append(Card(number: 1, color: Color.green, id: 72, x: 0, y: 0))
        cards.append(Card(number: 2, color: Color.green, id: 73, x: 0, y: 0))
        cards.append(Card(number: 3, color: Color.green, id: 74, x: 0, y: 0))
        cards.append(Card(number: 4, color: Color.green, id: 75, x: 0, y: 0))
        cards.append(Card(number: 5, color: Color.green, id: 76, x: 0, y: 0))
        cards.append(Card(number: 6, color: Color.green, id: 77, x: 0, y: 0))
        cards.append(Card(number: 7, color: Color.green, id: 78, x: 0, y: 0))
        cards.append(Card(number: 8, color: Color.green, id: 79, x: 0, y: 0))
        cards.append(Card(number: 9, color: Color.green, id: 80, x: 0, y: 0))
        
        cards.append(Card(number: 10, color: Color.red, id: 81, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.blue, id: 82, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.blue, id: 83, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.green, id: 84, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.green, id: 85, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.yellow, id: 86, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.yellow, id: 87, x: 0, y: 0))
        cards.append(Card(number: 10, color: Color.red, id: 88, x: 0, y: 0))
        
        cards.append(Card(number: 11, color: Color.red, id: 90, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.red, id: 91, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.blue, id: 92, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.blue, id: 93, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.green, id: 94, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.green, id: 95, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.yellow, id: 96, x: 0, y: 0))
        cards.append(Card(number: 11, color: Color.yellow, id: 97, x: 0, y: 0))
        
        cards.append(Card(number: 12, color: Color.red, id: 100, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.red, id: 101, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.blue, id: 102, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.blue, id: 103, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.green, id: 104, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.green, id: 105, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.yellow, id: 106, x: 0, y: 0))
        cards.append(Card(number: 12, color: Color.yellow, id: 107, x: 0, y: 0))
        
        cards.append(Card(number: 13, color: Color.black, id: 110, x: 0, y: 0))
        cards.append(Card(number: 13, color: Color.black, id: 111, x: 0, y: 0))
        cards.append(Card(number: 13, color: Color.black, id: 112, x: 0, y: 0))
        cards.append(Card(number: 13, color: Color.black, id: 113, x: 0, y: 0))
        cards.append(Card(number: 13, color: Color.black, id: 114, x: 0, y: 0))
        cards.append(Card(number: 14, color: Color.black, id: 115, x: 0, y: 0))
        cards.append(Card(number: 14, color: Color.black, id: 116, x: 0, y: 0))
        cards.append(Card(number: 14, color: Color.black, id: 117, x: 0, y: 0))
        
        cards.shuffle()
        
        for _ in 1...handSize {
            var playerCard = cards.first!
            playerCard.isFaceUp = true
            playerCard.isDealt = false
            playerCard.player = 1
            players[1].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            playerCard.player = 2
            players[2].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            playerCard.player = 3
            players[3].cards.append(playerCard)
            cards.removeFirst(1)
            
            playerCard = cards.first!
            playerCard.isDealt = false
            playerCard.player = 4
            players[4].cards.append(playerCard)
            cards.removeFirst(1)
        }
        
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
    
    mutating func playCard(card: Card, player: Player, desiredColor: Color = Color.red, message: String = "") -> Card {
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenCardIndex = players[chosenPlayerIndex].cards.firstIndex(matching: card) {
                players[chosenPlayerIndex].cards[chosenCardIndex].isFaceUp = true
                var playedCard = players[chosenPlayerIndex].cards[chosenCardIndex]
                if playedCard.color == Color.black {
                    if player.id != 1 {
                        playedCard.color = colors.randomElement()!
                    } else {
                        playedCard.color = desiredColor
                    }
                }
                displayMessage = message
                players[chosenPlayerIndex].lastPlayedCard = playedCard
                return playedCard
            }
        }
        return cards.first!
    }
    
    mutating func remove(card: Card, player: Player) {
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenCardIndex = players[chosenPlayerIndex].cards.firstIndex(matching: card) {
                players[chosenPlayerIndex].cards.remove(at: chosenCardIndex)
                if players[chosenPlayerIndex].cards.isEmpty {
                    if player.id == 1 {
                        winningMessage = "You Win!"
                    } else {
                        winningMessage = "Player \(player.id) Wins!"
                    }
                    isWinner = true
                }
            }
        }
    }
    
    mutating func discard(card: Card) {
        var discardCard = card
        discardCard.isDealt = true
        inPlayCards.append(discardCard)
    }

    mutating func drawCard(card: Card, player: Player, message: String = "") {
        var drawnCard = card
        drawnCard.player = player.id
        if player.id == 1 {
            drawnCard.isFaceUp = true
        }
        players[player.id].cards.append(drawnCard)
        displayMessage = message
    }
    
    mutating func removeFromStack(card: Card) {
        if let chosenCardIndex = cards.firstIndex(matching: card) {
            cards.remove(at: chosenCardIndex)
        }
    }
    
//    mutating func deal(cardIndex: Int) {
//        if cardIndex >= 0 && cardIndex < handSize {
//            players[1].cards[cardIndex].isDealt = true
//        }
//        if cardIndex >= handSize && cardIndex < handSize * 2 {
//            players[2].cards[cardIndex - handSize].isDealt = true
//        }
//        if cardIndex >= handSize * 2 && cardIndex < handSize * 3 {
//            players[3].cards[cardIndex - (handSize * 2)].isDealt = true
//        }
//        if cardIndex >= handSize * 3 && cardIndex < handSize * 4 {
//            players[4].cards[cardIndex - (handSize * 3)].isDealt = true
//        }
//    }
    
    mutating func deal() {
        inPlayCards[0].isDealt = true
    }
    
    mutating func findPosition(card: Card, player: Player, x: CGFloat, y: CGFloat) {
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenCardIndex =
                players[chosenPlayerIndex].cards.firstIndex(matching: card) {
                players[chosenPlayerIndex].cards[chosenCardIndex].x = x
                players[chosenPlayerIndex].cards[chosenCardIndex].y = y
            }
        }
    }
    
    mutating func getNumInHand(card: Card, player: Player) -> Int {
        var numInHand = 0
        if let chosenPlayerIndex = players.firstIndex(matching: player) {
            if let chosenCardIndex =
                players[chosenPlayerIndex].cards.firstIndex(matching: card) {
                numInHand = chosenCardIndex + 1
            }
        }
        return numInHand
    }
    
    struct Player: Identifiable {
        var cards = Array<Card>()
        var isOnSide: Bool
        var id: Int
        var lastPlayedCard: Card = Card(number: 0, color: Color.blue, id: 300)
    }
    
    struct Card: Identifiable {
        fileprivate(set) var isDealt = false
        var tilt = Double.random(in: -3...3)
        var player = 5
        var isFaceUp = false
        var number: Int
        var color: Color
        var id: Int
        var x: CGFloat = 0
        var y: CGFloat = 0
        var numInHand: Int = 0
    }
}

