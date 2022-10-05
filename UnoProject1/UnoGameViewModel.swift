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
        inPlayCards.last!.number
    }
    
    var topCardColor: Color {
        inPlayCards.last!.color
    }
    
    var cards: Array<UnoGame<String>.Card> {
        game.cards
    }
    
    var players: Array<UnoGame<String>.Player> {
        game.players
    }
    
    var inPlayCards: Array<UnoGame<String>.Card> {
        game.inPlayCards
    }

    var playerTurn = 1
    
    var turn = 0
    
    var playable = false
    
    var isReverse = 1
    
    func draw(player: UnoGame<String>.Player) {
        if let drawnCard = cards.last {
            withAnimation (
                Animation.easeIn(duration: 0.3).delay(Double(turn) * 1)
            ) {
                game.drawCard(card: drawnCard, player: player)
                turn += 1
                objectWillChange.send()
            }
            print("Player \(playerTurn) Drew")
            
            if drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black {
                print("Still \(playerTurn)'s Turn")
            } else if playerTurn == 1 {
                playerTurn += isReverse
                if playerTurn > 4 {
                    playerTurn = 1
                } else if playerTurn < 1 {
                    playerTurn = 4
                }
                compAI()
            } else {
                playerTurn += isReverse
                if playerTurn > 4 {
                    playerTurn = 1
                } else if playerTurn < 1 {
                    playerTurn = 4
                }
            }
        }
    }
    
    func playCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player) -> Bool {
        if player.id == playerTurn && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black){
            withAnimation (
                Animation.easeOut(duration: 0.3).delay(Double(turn) * 1)
            ) {
                game.playCard(card: card, player: player)
                turn += 1
                objectWillChange.send()
            }
            
            if card.number > 9 {
                specialCard(card: card, player: player)
            }
                
            playerTurn += isReverse
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
            return true
            
            
//            if game.newGame {
//                newGame()
//            }
        } else {
            return false
        }
    }
    
    func specialCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player) {
        if card.number == 10 {
            playerTurn += isReverse
            print("Skiped player \(playerTurn)")
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
        } else if card.number == 11 {
            isReverse *= -1
            print("Reversed!")
        } else if card.number == 12 {
            playerTurn += isReverse
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
            for _ in 0...1 {
                withAnimation (
                    Animation.easeIn(duration: 0.3).delay(Double(turn) * 1)
                ) {
                    if let drawnCard = cards.last {
                        game.drawCard(card: drawnCard, player: players[playerTurn - 1])
                        turn += 1
                    }
                }
            }
            print("Draw 2!")
        }
    }
    
    func newGame() {
        playerTurn = 1
        game = UnoGameViewModel.createGame()
        dealCards()
    }
    
    func dealCards() {
        for index in 0...(game.handSize * 4) {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(index) * 0.25)
            ) {
                game.deal(cardIndex: index)
                objectWillChange.send()
            }
        }
    }
    
    func compAI() {
        turn = 1
        while playerTurn != 1 {
            whatTurn()
            let player = players[playerTurn - 1]
            var playable = false
            for card in player.cards {
                if playCard(card: card, player: player) {
                    playable.toggle()
                    break
                }
            }
            
            if !playable {
                draw(player: player)
            }
        
            isWin()
        }
        print("Back to you---------------------")
        turn = 0
    }
    
    func whatTurn() {
        print("Player \(playerTurn) Went")
    }
    
    func isWin() {
        if players[0].cards.isEmpty || players[1].cards.isEmpty || players[2].cards.isEmpty || players[3].cards.isEmpty {
            newGame()
        }
    }
}
