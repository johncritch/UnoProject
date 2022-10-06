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
    var canPlay: Bool = true
    
    var alreadyDealt: Bool = false
    
    var chooseColorPopUp: Bool = false
    
    var winnerPopUp: Bool = false
    
    var wildCard: UnoGame<String>.Card = UnoGame.Card(number: 12, color: Color.blue, id: 200)
    
    var wildPlayer: UnoGame<String>.Player = UnoGame.Player(id: 10)

    var playerTurn = 1
    
    var turn = 0
    
    var playable = false
    
    var isReverse = 1
    
    var displayMessage: String {
        game.displayMessage
    }
    var specialMessage = ""
    
    func draw(player: UnoGame<String>.Player, message: String = "") {
        if canPlay || player.id != 1 {
            canPlay = false
            if let drawnCard = cards.last {
                withAnimation (
                    Animation.easeIn(duration: 0.3).delay(Double(turn) * 1)
                ) {
                    game.drawCard(card: drawnCard, player: player, message: message)
                    turn += 1
                    objectWillChange.send()
                }
                print("Player \(playerTurn) Drew")
                
                if drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black {
                    print("Still \(playerTurn)'s Turn")
                    if player.id == 1 {
                        canPlay = true
                        turn = 0
                    }
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
    }
    
    func playCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player, desiredColor: Color = Color.red) -> Bool {
        if canPlay || player.id != 1 {
            if player.id == playerTurn && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black){
                canPlay = false
                objectWillChange.send()
                specialMessage = getSpecialMessage(card: card)
                
                withAnimation (
                    Animation.easeOut(duration: 0.3).delay(Double(turn) * 1)
                ) {
                    game.playCard(card: card, player: player, desiredColor: desiredColor, message: specialMessage)
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
        return false
    }
    
    func getSpecialMessage(card: UnoGame<String>.Card) -> String {
        if card.number < 10 {
            return ""
        } else if card.number == 10 {
            return "Skipped"
        } else if card.number == 11 {
            return "Reversed!"
        } else if card.number == 12 {
            return "Draw 2!"
        } else if card.number == 13 {
            return "Wild Card!"
        } else if card.number == 14 {
            return "Wild Card! Draw 4!"
        } else {
            return ""
        }
    }
    
    func specialCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player) {
        if card.number == 10 {
            playerTurn += isReverse
            print("Skipped player \(playerTurn)")
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
        } else if card.number == 11 {
            isReverse *= -1
            print("Reversed!")
        } else if card.number == 12 {
            specialMessage = "Draw 2!"
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
                        game.drawCard(card: drawnCard, player: players[playerTurn - 1], message: specialMessage)
                    }
                    turn += 1
                }
            }
            print("Draw 2!")
        } else if card.number == 14 {
            specialMessage = "Wild Card! Draw 4!"
            playerTurn += isReverse
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
            for _ in 0...3 {
                withAnimation (
                    Animation.easeIn(duration: 0.3).delay(Double(turn) * 1)
                ) {
                    if let drawnCard = cards.last {
                        game.drawCard(card: drawnCard, player: players[playerTurn - 1], message: specialMessage)
                    }
                    turn += 1
                }
            }
            print("Draw 4!")
        }
    }
    
    func newGame() {
        playerTurn = 1
        turn = 0
        playable = false
        isReverse = 1
        game = UnoGameViewModel.createGame()
        dealCards()
        specialMessage = ""
        winnerPopUp = false
    }
    
    func dealCards() {
        for index in 0...(game.handSize * 4) {
            withAnimation (
                Animation.easeInOut(duration: 0.3).delay(Double(0) * 0.25)
            ) {
                game.deal(cardIndex: index)
                objectWillChange.send()
            }
        }
        alreadyDealt = true
    }
    
    func compAI() {
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
        canPlay = true
    }
    
    func chooseColor(card: UnoGame<String>.Card, player: UnoGame<String>.Player) {
        if canPlay {
            withAnimation(.spring().delay(0.25)) {
                chooseColorPopUp.toggle()
                objectWillChange.send()
                wildCard = card
                wildPlayer = player
            }
        }
    }
    
    func whatTurn() {
        print("Player \(playerTurn) Went")
    }
    
    func isWin() {
        if players[0].cards.isEmpty || players[1].cards.isEmpty || players[2].cards.isEmpty || players[3].cards.isEmpty {
            withAnimation(.spring().delay(0.25)) {
                winnerPopUp.toggle()
                objectWillChange.send()
                newGame()
            }
            
        }
    }
}
