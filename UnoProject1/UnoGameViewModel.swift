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
    
    var player1Spacing: Double {
        getSpacing(numCards: Double(game.players[1].cards.count))
    }
    
    var player2Spacing: Double {
        getSpacing(numCards: Double(game.players[2].cards.count))
    }
    
    var player3Spacing: Double {
        getSpacing(numCards: Double(game.players[3].cards.count))
    }
    
    var player4Spacing: Double {
        getSpacing(numCards: Double(game.players[4].cards.count))
    }
    
    var geometryWidth: Double = 0
    
    var geometryHeight: Double = 0
    
    var canPlay: Bool = true
    
    var alreadyDealt: Bool = false
    
    var chooseColorPopUp: Bool = false
    
    var winnerPopUp: Bool = false
    
    var wildCard: UnoGame<String>.Card = UnoGame.Card(number: 12, color: Color.blue, id: 200)
    
    var wildPlayer: UnoGame<String>.Player = UnoGame.Player(isOnSide: false, id: 10)

    var playerTurn = 1
    
    var turnAnimation = 0
    
    var playable = false
    
    var isReverse = 1
    
    var displayMessage: String {
        game.displayMessage
    }
    var specialMessage = ""
    
    var winnerMessage = ""
    
    func draw(player: UnoGame<String>.Player, message: String = "") {
        canPlay = false
        if let drawnCard = cards.last {
            withAnimation (
                Animation.easeIn(duration: 0.3)
            ) {
                game.drawCard(card: drawnCard, player: player, message: message)
//                turn += 1
//                objectWillChange.send()
            }
//            print("Player \(playerTurn) Drew")
//
//            if drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black {
//                print("Still \(playerTurn)'s Turn")
//                if player.id == 1 {
//                    canPlay = true
//                    turn = 0
//                }
//            } else if playerTurn == 1 {
//                playerTurn += isReverse
//                if playerTurn > 4 {
//                    playerTurn = 1
//                } else if playerTurn < 1 {
//                    playerTurn = 4
//                }
////                compAI()
//            } else {
//                playerTurn += isReverse
//                if playerTurn > 4 {
//                    playerTurn = 1
//                } else if playerTurn < 1 {
//                    playerTurn = 4
//                }
//            }
            
        }
    }
    
    func playCard2(card: UnoGame<String>.Card, player: UnoGame<String>.Player, desiredColor: Color = Color.red){

        let numInHand = getNumInHand(card: card, player: player)
        let spacing = getSpacing(numCards: Double(player.cards.count))
        let spaceFromDiscard = spaceFromDiscard(numInHand: numInHand, handCount: player.cards.count, spacing: spacing, isOnSide: player.isOnSide)
        if player.id == 1 {
            findPosition(card: card, player: player, x: spaceFromDiscard, y: (geometryHeight/2 - 120) * -1)
        } else if player.id == 2 {
            findPosition(card: card, player: player, x: (geometryWidth/2 - 95) * -1, y: spaceFromDiscard)
        } else if player.id == 3 {
            findPosition(card: card, player: player, x: spaceFromDiscard, y: geometryHeight/2 - 120)
        } else {
            findPosition(card: card, player: player, x: geometryWidth/2 - 15, y: spaceFromDiscard)
        }
        
        
        var playedCard = cards.first!
        withAnimation (
            Animation.linear(duration: 1).delay(0.3)
        ) {
            playedCard = game.playCard(card: card, player: player, desiredColor: desiredColor, message: specialMessage)
        }
        withAnimation (
            Animation.easeOut(duration: 1.4)
        ) {
            game.remove(card: card, player: player)
        }
        withAnimation (
            Animation.linear(duration: 0.1).delay(1.3)
        ) {
            game.discard(card: playedCard)
        }
    }
    
    func playCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player, desiredColor: Color = Color.red) -> Bool {
        if player.id == playerTurn && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black){
            canPlay = false
            objectWillChange.send()
            specialMessage = getSpecialMessage(card: card)
            
            withAnimation (
                Animation.easeOut(duration: 1.2).delay(0)
            ) {
                game.playCard(card: card, player: player, desiredColor: desiredColor, message: specialMessage)
                turnAnimation += 1
                objectWillChange.send()
            }
            if card.number > 9 {
                specialCard(card: card, player: player)
            }
            if player.id == 1 {
                isWin()
            }
            
            playerTurn += isReverse
            if playerTurn > 4 {
                playerTurn = 1
            } else if playerTurn < 1 {
                playerTurn = 4
            }
            return true
        } else {
            return false
        }
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
                    Animation.easeIn(duration: 0.3).delay(Double(turnAnimation) * 1)
                ) {
                    if let drawnCard = cards.last {
                        game.drawCard(card: drawnCard, player: players[playerTurn - 1], message: specialMessage)
                    }
                    turnAnimation += 1
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
                    Animation.easeIn(duration: 0.3).delay(Double(turnAnimation) * 1)
                ) {
                    if let drawnCard = cards.last {
                        game.drawCard(card: drawnCard, player: players[playerTurn - 1], message: specialMessage)
                    }
                    turnAnimation += 1
                }
            }
            print("Draw 4!")
        }
    }
    
    func newGame() {
        playerTurn = 1
        turnAnimation = 0
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
            withAnimation (
                Animation.easeOut(duration: 0.3).delay(Double(turnAnimation) * 1)
            ) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(turnAnimation)) {
                    if self.playerTurn == 1 {
                        self.canPlay = true
                    }
                    self.isWin()
                }
            }
        }
        print("Back to you---------------------")
        turnAnimation = 0
    }
    
    func chooseColor(card: UnoGame<String>.Card, player: UnoGame<String>.Player) {
        withAnimation(.spring().delay(0.25)) {
            chooseColorPopUp.toggle()
            objectWillChange.send()
            wildCard = card
            wildPlayer = player
        }
    }
    
    func findPosition(card: UnoGame<String>.Card, player: UnoGame<String>.Player, x: CGFloat, y: CGFloat) {
        game.findPosition(card: card, player: player, x: x, y: y)
    }
    
    func getNumInHand(card: UnoGame<String>.Card, player: UnoGame<String>.Player) -> Int {
        return game.getNumInHand(card: card, player: player)
    }
    
    func spaceFromDiscard(numInHand: Int, handCount: Int, spacing: Double, isOnSide: Bool) -> CGFloat {
        var midToDiscard: Double = 0
        var sideModifier: Double = 0
        let middle: Int = (handCount / 2) + 1
        let numFromMiddle = middle - numInHand
        if isOnSide {
            sideModifier = -40 + (Double(numFromMiddle)) * 5
//            sideModifier = 10 * Double(numFromMiddle)
        }
        if handCount.isMultiple(of: 2) {
            midToDiscard = spacing / -1.53
        } else {
            midToDiscard = 40
        }
        let multiplier = (spacing * Double(numFromMiddle)) + (70 * Double(numFromMiddle))
        let toDiscard = multiplier + midToDiscard + sideModifier
        return toDiscard
    }
    
    func whatTurn() {
        print("Player \(playerTurn) Went")
    }
    
    func isWin() -> Bool {
        var winner = ""
        if players[0].cards.isEmpty || players[1].cards.isEmpty || players[2].cards.isEmpty || players[3].cards.isEmpty {
            if players[0].cards.isEmpty {
                winner = "You Win!"
            } else if players[1].cards.isEmpty {
                winner = "Player 2 Wins!"
            } else if players[2].cards.isEmpty {
                winner = "Player 3 Wins!"
            } else {
                winner = "Player 4 Wins!"
            }
            winnerMessage = winner
            withAnimation(.easeInOut.delay(0.25)) {
                winnerPopUp.toggle()
                objectWillChange.send()
                newGame()
            }
            return true
        }
        return false
    }
    
    private func getSpacing(numCards: Double) -> Double {
        var spacing = -1 * (((70 * numCards) - 280) / numCards)
        if spacing < -30 {
            return spacing
        } else {
            return -30
        }
    }
}
