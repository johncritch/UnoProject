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
                    Text(unoGame.displayMessage)
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
                            print(unoGame.playerTurn)
                        }
                }
                .coordinateSpace(name: "menu")
                .frame(width: 150, height: 80)
                .position(x: (reader.size.width / 2) - widthAdjust, y: (reader.size.height / 2) - heightAdjust)
                
                ZStack {
                    ForEach(unoGame.cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                unoGame.draw(player: unoGame.players[unoGame.playerTurn])
                            }
                    }
                }
                .coordinateSpace(name: "stack")
                .position(x: reader.size.width * 1/2 - 40, y: reader.size.height * 1/2)
                
                ZStack {
                    ForEach(unoGame.inPlayCards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .onAppear {
                                unoGame.geometryWidth = reader.size.width
                                unoGame.geometryHeight = reader.size.height
                            }
                    }
                }
                .coordinateSpace(name: "discard")
                .position(x: reader.size.width * 1/2 + 40, y: reader.size.height * 1/2)
                
                HStack(spacing: unoGame.player1Spacing) {
                    ForEach(unoGame.players[1].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                if card.number == 13 || card.number == 14 {
                                    unoGame.chooseColor(card: card, player: unoGame.players[1])
                                } else if unoGame.playCard(card: card, player: unoGame.players[1]) {
                                    unoGame.compAI()
                                }
                            }
                    }
                }
                .coordinateSpace(name: "player1")
                .position(x: reader.size.width * 1/2, y: reader.size.height - 55)
                
                VStack(spacing: unoGame.player2Spacing - 30) {
                    ForEach(unoGame.players[2].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
//                                unoGame.playCard2(card: card, player: unoGame.players[2])
                            }
                    }
                }
                .coordinateSpace(name: "player2")
                .position(x: reader.size.width - 55, y: reader.size.height * 1/2)
           

                HStack(spacing: unoGame.player3Spacing) {
                    ForEach(unoGame.players[3].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .onTapGesture {
//                                unoGame.playCard2(card: card, player: unoGame.players[3])
                            }
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                    }
                }
                .coordinateSpace(name: "player3")
                .position(x: reader.size.width * 1/2, y: 55)
                    
      
                VStack(spacing: unoGame.player4Spacing - 30) {
                    ForEach(unoGame.players[4].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
//                                unoGame.playCard2(card: card, player: unoGame.players[4])
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
        .overlay(alignment: .bottom) {
            if unoGame.chooseColorPopUp {
                ColorPicker(chosenColor: self.$chosenColor)
            }
        }
        .overlay(alignment: .bottom) {
            if unoGame.isWinner {
                WinningView(won: self.$won, message: unoGame.winningMessage)
            }
        }
        .onChange(of: chosenColor) { newColor in
            unoGame.chooseColorPopUp.toggle()
            if unoGame.playCard(card: unoGame.wildCard, player: unoGame.wildPlayer, desiredColor: chosenColor) {
                unoGame.compAI()
            }
        }
        .onChange(of: won) { newColor in
            unoGame.newGame()
            won = false
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

