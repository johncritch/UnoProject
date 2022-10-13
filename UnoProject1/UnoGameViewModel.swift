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
        game.inPlayCards.filter { $0.isDealt }
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
    
    var lastPlayedCard: UnoGame<String>.Card = UnoGame.Card(number: 12, color: Color.blue, id: 201)
    
    var canPlay: Bool = true
    
    var alreadyDealt: Bool = false
    
    var chooseColorPopUp: Bool = false
    
    var winnerPopUp: Bool = false
    
    var wildCard: UnoGame<String>.Card = UnoGame.Card(number: 12, color: Color.blue, id: 200)
    
    var wildPlayer: UnoGame<String>.Player = UnoGame.Player(isOnSide: false, id: 10)

    var playerTurn = 1
    
    var turnAnimation: Double = 0
    
    var playable = false
    
    var isReverse = 1
    
    var displayMessage: String {
        game.displayMessage
    }
    var specialMessage = ""
    
    var winnerMessage = ""
    
    var isNewGame: Bool = true
    
    func draw(player: UnoGame<String>.Player, message: String = "") -> Bool {
        if let drawnCard = cards.last {
            DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                withAnimation (
                    Animation.linear(duration: 1.4).delay(Double(self.turnAnimation))
                ) {
                    self.game.drawCard(player: player, message: message)
                }
            }
            print("Player \(playerTurn) Drew")

            if drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black {
                print("Still \(playerTurn)'s Turn")
                if playerTurn == 1 {
                    turnAnimation = 0
                }
            } else if playerTurn == 1 {
                compAI()
            } else {
                return false
            }
        }
        return true
    }
    
    func playCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player, desiredColor: Color = Color.red) -> Bool {
        if player.id == playerTurn && card.id != lastPlayedCard.id && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black) {
            specialMessage = getSpecialMessage(card: card)
            
            let numInHand = getNumInHand(card: card, player: player)
            let spacing = getSpacing(numCards: Double(player.cards.count))
            let spaceFromDiscard = spaceFromDiscard(numInHand: numInHand, handCount: player.cards.count, spacing: spacing, isOnSide: player.isOnSide)
            
            if player.id == 1 {
                findPosition(card: card, player: player, x: spaceFromDiscard, y: (geometryHeight/2 - 55) * -1)
            } else if player.id == 2 {
                findPosition(card: card, player: player, x: (geometryWidth/2 - 95) * -1, y: spaceFromDiscard)
            } else if player.id == 3 {
                findPosition(card: card, player: player, x: spaceFromDiscard, y: geometryHeight/2 - 55)
            } else {
                findPosition(card: card, player: player, x: geometryWidth/2 - 15, y: spaceFromDiscard)
            }
            
            var playedCard = cards.first!
            withAnimation (
                Animation.linear(duration: 1).delay(0.3 + self.turnAnimation)
            ) {
                playedCard = self.game.playCard(card: card, player: player, desiredColor: desiredColor, message: self.specialMessage)
            }
            lastPlayedCard = card
            DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                withAnimation (
                    Animation.easeOut(duration: 1.4).delay(self.turnAnimation)
                ) {
                    self.game.remove(card: card, player: player)
                }
            }
            withAnimation (
                Animation.linear(duration: 0.1).delay(1.3 + self.turnAnimation)
            ) {
                self.game.discard(card: playedCard)
                self.isWin()
            }
            
            if card.number > 9 {
                specialCard(card: card, player: player)
            }
            
            return true
        } else {
            return false
        }
    }
    
    private func whosNext() -> Int {
        var turn = playerTurn + isReverse
        if turn > 4 {
            turn = 1
        } else if turn < 1 {
            turn = 4
        }
        return turn
    }
    
    private func nextPlayer() {
        playerTurn += isReverse
        if playerTurn > 4 {
            playerTurn = 1
        } else if playerTurn < 1 {
            playerTurn = 4
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
        let nextToPlay = whosNext()
        if card.number == 10 {
            print("Skipped player \(playerTurn)")
            nextPlayer()
        } else if card.number == 11 {
            isReverse *= -1
            print("Reversed!")
        } else if card.number == 12 {
            specialMessage = "Draw 2!"
            
            for _ in 0...1 {
                turnAnimation += 1.5
                DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                    withAnimation (
                        Animation.linear(duration: 1.4).delay(Double(self.turnAnimation))
                    ) {
                        self.game.drawCard(player: self.players[nextToPlay], message: self.specialMessage)
                    }
                }
            }
            nextPlayer()
            print(playerTurn)
            print("Draw 2!")
            
        } else if card.number == 14 {
            specialMessage = "Wild Card! Draw 4!"
            for _ in 0...3 {
                turnAnimation += 1.5
                DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                    withAnimation (
                        Animation.linear(duration: 1.4).delay(Double(self.turnAnimation))
                    ) {
                        self.game.drawCard(player: self.players[nextToPlay], message: self.specialMessage)
                    }
                }
            }
            nextPlayer()
            print("Draw 4!")
        }
    }
    
    func compAI() {
        nextPlayer()
        turnAnimation += 1.5
        while playerTurn != 1 {
            whatTurn()
            var playable = false
            for card in players[playerTurn].cards {
                if playCard(card: card, player: players[playerTurn]) {
                    playable.toggle()
                    nextPlayer()
                    break
                }
            }
            
            if !playable {
                if !draw(player: players[playerTurn]) {
                    nextPlayer()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                self.isWin()
            }
            turnAnimation += 1.5
            
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
    
    func isWin(){
        var winner = ""
        if players[1].cards.isEmpty || players[2].cards.isEmpty || players[3].cards.isEmpty || players[4].cards.isEmpty {
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
        }
    }
    
    private func getSpacing(numCards: Double) -> Double {
        let spacing = -1 * (((70 * numCards) - 280) / numCards)
        if spacing < -30 {
            return spacing
        } else {
            return -30
        }
    }
    
    func newGame() {
        game = UnoGameViewModel.createGame()
        playerTurn = 1
        turnAnimation = 0
        playable = false
        isReverse = 1
        dealCards()
        specialMessage = ""
        winnerPopUp = false
        geometryWidth = 0
        geometryHeight = 0
    }
    
    func dealCards() {
        withAnimation (
            Animation.easeInOut(duration: 0.5)
        ) {
            game.deal()
            objectWillChange.send()
        }
        alreadyDealt = true
    }
}
