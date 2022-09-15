//
//  UnoGameViewModel.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import Foundation
import SwiftUI

class UnoGameViewModel: ObservableObject {

    @Published var game = createGame()

    
    static private func createGame() -> UnoGame<String> {
        UnoGame<String>()
    }
    var topCardNumber: Int {
        game.topCardNumber
    }
    
    var topCardColor: Color {
        game.topCardColor
    }
    
    var cards: Array<UnoGame<String>.Card> {
        game.cards
    }
    
    var inPlayCards: Array<UnoGame<String>.Card> {
        game.inPlayCards
    }
    
    var p1Cards: Array<UnoGame<String>.Card> {
        game.p1Cards
    }
    
    var p2Cards: Array<UnoGame<String>.Card> {
        game.p2Cards
    }
    
    var p3Cards: Array<UnoGame<String>.Card> {
        game.p3Cards
    }
    
    var p4Cards: Array<UnoGame<String>.Card> {
        game.p4Cards
    }

    var turn = 1
    
    var playable = false
    
    func playCard(card: UnoGame<String>.Card, player: Int) -> Bool {
        if player == turn && (card.color == topCardColor || card.number == topCardNumber){
            
            game.playCard(card: card, player: player)
                
            turn = turn + 1
            if turn > 4 {
                turn = 1
            }
             return true
            
            
//            if game.newGame {
//                newGame()
//            }
        } else {
            return false
        }
    }
    
    func newGame() {
        turn = 1
        game = UnoGameViewModel.createGame()
    }
    
    func draw() {
        if let drawnCard = cards.last {
            game.drawCard(player: turn)
            
            if drawnCard.color == topCardColor || drawnCard.number == topCardNumber {
                print("Still Your Turn")
            } else {
                turn = turn + 1
                if turn > 4 {
                    turn = 1
                }
            }
        }
    }
    
    func compAI() {
        while turn != 1 {
            let players = [p2Cards, p3Cards, p4Cards]
            let playersCards = players[turn - 2]
            var playable = false
            
            for card in playersCards {
                if playCard(card: card, player: turn) {
                    playable.toggle()
                    break
                }
            }
            if !playable {
                draw()
            }
            runGame()
        }
    }
    
    func runGame() {
        if !p1Cards.isEmpty && !p2Cards.isEmpty && !p3Cards.isEmpty && !p4Cards.isEmpty {
            if turn == 1 {
                print("Player 1's Turn")
            }
            if turn == 2 {
                print("Player 2's Turn")
            }
            if turn == 3 {
                print("Player 3's Turn")
            }
            if turn == 4 {
                print("Player 4's Turn")
            }
        } else {
            newGame()
        }
    }
}
