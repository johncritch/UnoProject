//
//  ContentView.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/6/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var unoGame: UnoGameViewModel
    @AppStorage("highScore") var highScore: Int = 0
    @State var chosenColor = Color.black
    @State var won = false
    @State var playedCard: Bool = false
    @State var heightAdjust: Double = 140
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
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 50))
                        .rotation3DEffect(Angle(degrees: (unoGame.isReverse < 0) ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.red)
                        .overlay(Text("Deal Again").font(.title).foregroundColor(.white))
                        .onTapGesture {
                            unoGame.newGame()
//                            unoGame.dealCards()
                        }
                        .frame(height: 50)
                }
                .coordinateSpace(name: "menu")
                .frame(width: 150, height: 140)
                .position(x: (reader.size.width / 2) - widthAdjust, y: (reader.size.height / 2) - heightAdjust)
                
                VStack {
                    Text("High Score: \(String(highScore))")
                        .bold()
                    Spacer()
                    Text(unoGame.displayMessage)
                        .bold()
                }
                .coordinateSpace(name: "menu")
                .frame(width: 150, height: 80)
                .position(x: (reader.size.width / 2) - widthAdjust, y: (reader.size.height / 2) + 110)
            
                
                ZStack {
                    ForEach(unoGame.cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle(degrees: card.tilt))
                            .transition(AnyTransition.offset(x: card.x, y: card.y))
                            .onTapGesture {
                                _ = unoGame.draw(player: unoGame.players[unoGame.playerTurn])
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
                                if unoGame.inPlayCards.count == 1 {
                                    unoGame.geometryHeight -= 135
                                }
                                won = false
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
                                if unoGame.canPlay {
                                    if card.number == 13 || card.number == 14 {
                                        unoGame.chooseColor(card: card, player: unoGame.players[1])
                                    } else if unoGame.playCard(card: card, player: unoGame.players[1]) {
                                        unoGame.compAI()
                                    }
                                }
                            }
                    }
                }
                .coordinateSpace(name: "player1")
                .position(x: reader.size.width * 1/2, y: reader.size.height - 55)
                .shadow(color: .blue, radius: unoGame.canPlay ? 8 : 0)
                
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
            
            // IF I WANT TO IMPLEMENT ROTATION LATER
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
            print(unoGame.highScore)
            if unoGame.highScore > highScore {
                highScore = unoGame.highScore
            }
            unoGame.newGame()
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

