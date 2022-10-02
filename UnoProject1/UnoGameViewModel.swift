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
    
//    var cards: Array<UnoGame<String>.Card> {
//        game.cards
//    }
    
    var cards: Array<UnoGame<String>.Card> {
        game.cards
    }
    
    var inPlayCards: Array<UnoGame<String>.Card> {
        game.inPlayCards
    }
    
    var p1Cards: Array<UnoGame<String>.Card> {
        game.p1Cards
//            .filter { $0.isDealt }
    }
    
    var p2Cards: Array<UnoGame<String>.Card> {
        game.p2Cards
//            .filter { $0.isDealt }
    }
    
    var p3Cards: Array<UnoGame<String>.Card> {
        game.p3Cards
//            .filter { $0.isDealt }
    }
    
    var p4Cards: Array<UnoGame<String>.Card> {
        game.p4Cards
//            .filter { $0.isDealt }
    }

    var turn = 1
    
    var playable = false
    
    var isReverse = 1
    
    func playCard(card: UnoGame<String>.Card, player: Int) -> Bool {
        if player == turn && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black){
            
            game.playCard(card: card, player: player)
            
            if card.number > 9 {
                specialCard(num: card.number)
            }
                
            turn += isReverse
            if turn > 4 {
                turn = 1
            } else if turn < 1 {
                turn = 4
            }
            return true
            
            
//            if game.newGame {
//                newGame()
//            }
        } else {
            return false
        }
    }
    
    func specialCard(num: Int) {
        if num == 10 {
            turn += isReverse
            print("Skiped!")
        } else if num == 11 {
            isReverse *= -1
            print("Reversed!")
        } else if num == 12 {
            turn += isReverse
            game.drawCard(player: turn)
            game.drawCard(player: turn)
            print("Draw 2!")
        }
    }
    
    func newGame() {
        turn = 1
        game = UnoGameViewModel.createGame()
    }
    
    func dealCards() {
        dealPlayer1()
        dealPlayer2()
        dealPlayer3()
        dealPlayer4()
//        for index in 0..<game.cards.count {
//            withAnimation (
//                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
//            ) {
//                game.deal(cardIndex: index)
//            }
//        }
    }
    
    func dealPlayer1() {
        for index in 0..<game.p1Cards.count {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
            ) {
                game.deal(cardIndex: index, player: 1)
            }
        }
    }
    
    func dealPlayer2() {
        for index in 0..<game.p2Cards.count {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
            ) {
                game.deal(cardIndex: index, player: 2)
            }
        }
    }
    
    func dealPlayer3() {
        for index in 0..<game.p3Cards.count {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
            ) {
                game.deal(cardIndex: index, player: 3)
            }
        }
    }
    
    func dealPlayer4() {
        for index in 0..<game.p4Cards.count {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
            ) {
                game.deal(cardIndex: index, player: 4)
            }
        }
    }
    
    func draw() {
        if let drawnCard = cards.last {
            game.drawCard(player: turn)
            print("Player \(turn) Drew")
            
            if drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black {
                print("Still \(turn)'s Turn")
            } else {
                turn += isReverse
                if turn > 4 {
                    turn = 1
                } else if turn < 1 {
                    turn = 4
                }
            }
        }
    }
    
    func compAI() {
        while turn != 1 {
            whatTurn()
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
            isWin()
        }
        print("Back to you-------------------------")
    }
    
    func whatTurn() {
        print("Player \(turn) Went")
    }
    
    func isWin() {
        if p1Cards.isEmpty || p2Cards.isEmpty || p3Cards.isEmpty || p4Cards.isEmpty {
            newGame()
        }
    }
}
