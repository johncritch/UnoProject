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
    
    //Deck of Cards
    var cards: Array<UnoGame<String>.Card> {
        game.cards
    }
    
    var players: Array<UnoGame<String>.Player> {
        game.players
    }
    
    var inPlayCards: Array<UnoGame<String>.Card> {
        game.inPlayCards.filter { $0.isDealt }
    }
    
    var canPlay: Bool {
        game.canPlay
    }
    
    var isWinner: Bool {
        game.isWinner
    }
    
    var winningMessage: String {
        game.winningMessage
    }
    
    var highScore: Int {
        game.highScore
    }
    
    var displayMessage: String {
        game.displayMessage
    }
    
    var topCardNumber: Int {
        inPlayCards.last!.number
    }
    
    var topCardColor: Color {
        inPlayCards.last!.color
    }
    
    //Spacing for animations when cards change
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
    
    // Stops play when theres a winner
    var isWin: Bool = false
    
    var alreadyDealt: Bool = false
    
    // Shop Color Chooser
    var chooseColorPopUp: Bool = false
    
    // Show Winner Screen
    var winnerPopUp: Bool = false
    
    var wildCard: UnoGame<String>.Card = UnoGame.Card(number: 12, color: Color.blue, id: 200)
    
    var wildPlayer: UnoGame<String>.Player = UnoGame.Player(isOnSide: false, id: 10)

    // Whos turn
    var playerTurn = 1
    
    // Animation Multiplier
    var turnAnimation: Double = 0
    
    var isReverse = 1
    
    var specialMessage = ""
    
    var winnerMessage = ""
    
    var isNewGame: Bool = true
    
    
    // MARK: Model Functions
    
    func draw(player: UnoGame<String>.Player, message: String = "") -> Bool {
        if let drawnCard = cards.last {
            game.removeFromStack(card: drawnCard)
            DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) {
                withAnimation (
                    Animation.linear(duration: 1.4).delay(Double(self.turnAnimation))
                ) {
                    self.game.drawCard(card: drawnCard, player: player, message: message)
                }
            }
            print("Player \(player.id) drew a \(drawnCard.color) \(drawnCard.number)")
            if player.id == 1 {
                if (drawnCard.color == topCardColor || drawnCard.number == topCardNumber || drawnCard.color == Color.black) && drawnCard.id != player.lastPlayedCard.id {
                    print("Still \(playerTurn)'s Turn")
                    return true
                }
            }
            if playerTurn == 1 {
                game.playerOneCannotPlay()
                turnAnimation = 0
                compAI()
            }
            return false
        }
        return true
    }
    
    func playCard(card: UnoGame<String>.Card, player: UnoGame<String>.Player, desiredColor: Color = Color.red) -> Bool {
        if player.id == playerTurn && card.id != player.lastPlayedCard.id && (card.color == topCardColor || card.number == topCardNumber || card.color == Color.black) {
            if player.cards.count == 1 {
                isWin = true
            }
            if player.id == 1 {
                game.playerOneCannotPlay()
            }
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
                Animation.linear(duration: 1).delay(0.3 + turnAnimation)
            ) {
                playedCard = game.playCard(card: card, player: player, desiredColor: desiredColor, message: specialMessage)
                print("Player \(player.id) played a \(card.color) \(card.number).")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) { [self] in
                withAnimation (
                    Animation.easeOut(duration: 1.5).delay(turnAnimation)
                ) {
                    game.remove(card: card, player: player)
                }
            }
            withAnimation (
                Animation.linear(duration: 0.1).delay(1.4 + turnAnimation)
            ) {
                game.discard(card: playedCard)
            }
            
            if card.number > 9 {
                specialCard(card: card, player: player)
            }
            
            return true
        } else {
            return false
        }
    }
    
    private func findPosition(card: UnoGame<String>.Card, player: UnoGame<String>.Player, x: CGFloat, y: CGFloat) {
        game.findPosition(card: card, player: player, x: x, y: y)
    }
    
    private func getNumInHand(card: UnoGame<String>.Card, player: UnoGame<String>.Player) -> Int {
        return game.getNumInHand(card: card, player: player)
    }
    
    //MARK: Helper Functions
    
    private func whosNext() -> Int {
        var turn = playerTurn
 
        turn = turn + isReverse
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
                turnAnimation += 0.5
                let drawnCard = game.cards.last
                game.removeFromStack(card: drawnCard!)
                DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) { [self] in
                    withAnimation (
                        Animation.linear(duration: 1.4).delay(Double(self.turnAnimation))
                    ) {
                        game.drawCard(card: drawnCard!, player: players[nextToPlay], message: specialMessage)
                    }
                }
            }
            nextPlayer()
            print(playerTurn)
            print("Draw 2!")
            
        } else if card.number == 14 {
            specialMessage = "Wild Card! Draw 4!"
            for _ in 0...3 {
                turnAnimation += 0.5
                let drawnCard = game.cards.last
                game.removeFromStack(card: drawnCard!)
                DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) { [self] in
                    
                    withAnimation (
                        Animation.linear(duration: 1.4).delay(Double(turnAnimation))
                    ) {
                        game.drawCard(card: drawnCard!, player: players[nextToPlay], message: specialMessage)
                    }
                }
            }
            nextPlayer()
            print("Draw 4!")
        }
    }
    
    // Computer Generated AI
    func compAI() {
        nextPlayer()
        turnAnimation += 1.5
        while playerTurn != 1 {
            if !isWin {
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
                turnAnimation += 1.5
            } else {
                playerTurn = 1
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + turnAnimation) { [self] in
            game.playerOneCanPlay()
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
    
    // Calculates the x and y positions of each card to the discard pile
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
    
    private func getSpacing(numCards: Double) -> Double {
        let spacing = -1 * (((70 * numCards) - 280) / numCards)
        if spacing < -30 {
            return spacing
        } else {
            return -30
        }
    }
    
    func newGame() {
        game.isWinner = false
        game = UnoGameViewModel.createGame()
        isWin = false
        dealCards()
        playerTurn = 1
        turnAnimation = 0
        isReverse = 1
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
