//
//  ContentView.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/6/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var unoGame: UnoGameViewModel
    @State var chosenColor = Color.black
    @State var won = false
    @State var playedCard: Bool = false
    @State var heightAdjust: Double = 120
    @State var widthAdjust: Double = 0
    @State var orientation = UIDeviceOrientation.unknown
    @State var player1Spacing: Double = 0.0
    @State var player2Spacing: Double = 0.0
    @State var player3Spacing: Double = 0.0
    @State var player4Spacing: Double = 0.0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .overlay(Text("New Game").font(.title).foregroundColor(.white))
                        .onTapGesture {
                            unoGame.newGame()
                            unoGame.dealCards()
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .overlay(Text("Turn").font(.title).foregroundColor(.white))
                        .onTapGesture {
                            print(unoGame.canPlay)
                        }
                }
                .coordinateSpace(name: "menu")
                .frame(width: 150, height: 80)
                .position(x: (reader.size.width / 2) - widthAdjust, y: (reader.size.height / 2) - heightAdjust)
                
                ZStack {
                    ForEach(unoGame.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                unoGame.draw(player: unoGame.players[2])
                            }
                    }
                }
                .coordinateSpace(name: "stack")
                .position(x: reader.size.width * 1/2 - 40, y: reader.size.height * 1/2)
                
                ZStack {
                    ForEach(unoGame.inPlayCards) { card in
                        CardView(card: card)
                    }
                }
                .coordinateSpace(name: "discard")
                .position(x: reader.size.width * 1/2 + 40, y: reader.size.height * 1/2)
                
                HStack(spacing: unoGame.player1Spacing) {
                    ForEach(unoGame.players[0].cards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                let numInHand = unoGame.getNumInHand(card: card, player: unoGame.players[0])
                                let spaceFromDiscard = unoGame.spaceFromDiscard(numInHand: numInHand,handCount: unoGame.players[0].cards.count, spacing: unoGame.player1Spacing)
                                unoGame.findPosition(card: card, player: unoGame.players[0], x: spaceFromDiscard, y: (reader.size.height/2 - 55) * -1)
                                unoGame.playCard2(card: card, player: unoGame.players[0])
                            }
                    }
                }
                .coordinateSpace(name: "player1")
                .position(x: reader.size.width * 1/2, y: reader.size.height - 55)
                
                VStack(spacing: unoGame.player2Spacing - 30) {
                    ForEach(unoGame.players[1].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle.degrees(-90))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                let numInHand = unoGame.getNumInHand(card: card, player: unoGame.players[1])
                                let spaceFromDiscard = unoGame.spaceFromDiscard(numInHand: numInHand,handCount: unoGame.players[1].cards.count, spacing: unoGame.player2Spacing)
                                unoGame.findPosition(card: card, player: unoGame.players[1], x: spaceFromDiscard, y: reader.size.height/2 - 55)
                                unoGame.playCard2(card: card, player: unoGame.players[1])
                            }
                    }
                }
                .coordinateSpace(name: "player2")
                .position(x: reader.size.width - 55, y: reader.size.height * 1/2)
           

                HStack(spacing: unoGame.player3Spacing) {
                    ForEach(unoGame.players[2].cards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                let numInHand = unoGame.getNumInHand(card: card, player: unoGame.players[2])
                                let spaceFromDiscard = unoGame.spaceFromDiscard(numInHand: numInHand,handCount: unoGame.players[2].cards.count, spacing: unoGame.player3Spacing)
                                unoGame.findPosition(card: card, player: unoGame.players[2], x: spaceFromDiscard, y: reader.size.height/2 - 55)
                                unoGame.playCard2(card: card, player: unoGame.players[2])
                            }
                    }
                }
                .coordinateSpace(name: "player3")
                .position(x: reader.size.width * 1/2, y: 55)
                    
      
                VStack(spacing: unoGame.player4Spacing - 30) {
                    ForEach(unoGame.players[3].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle.degrees(90))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                let numInHand = unoGame.getNumInHand(card: card, player: unoGame.players[3])
                                let spaceFromDiscard = unoGame.spaceFromDiscard(numInHand: numInHand,handCount: unoGame.players[3].cards.count, spacing: unoGame.player4Spacing)
                                unoGame.findPosition(card: card, player: unoGame.players[3], x: spaceFromDiscard, y: reader.size.height/2 - 55)
                                unoGame.playCard2(card: card, player: unoGame.players[3])
                            }
                    }
                }
                .coordinateSpace(name: "player4")
                .position(x: 55, y: reader.size.height * 1/2)
                
            }
//            .onRotate { newOrientation in
//                orientation = newOrientation
//                if orientation.isPortrait {
//                    heightAdjust = 120
//                    widthAdjust = 0
//                } else if orientation.isLandscape {
//                    heightAdjust = 0
//                    widthAdjust = 170
//                }
//            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear {
            if !unoGame.alreadyDealt{
                unoGame.dealCards()
            }
        }
    }
    private struct Card {
        static let desiredWidth: CGFloat = 50
    }
}

//struct DeviceRotationViewModifier: ViewModifier {
//    let action: (UIDeviceOrientation) -> Void
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear()
//            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
//                action(UIDevice.current.orientation)
//            }
//    }
//}

// A View wrapper to make the modifier easier to use
//extension View {
//    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
//        self.modifier(DeviceRotationViewModifier(action: action))
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(unoGame: UnoGameViewModel())
    }
}

