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
    @State var heightAdjust: Double = 220
    @State var widthAdjust: Double = 0
    @State var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                HStack(spacing: -30) {
                    ForEach(unoGame.players[0].cards) { card in
                        CardView(card: card)
                    }
                }
                .coordinateSpace(name: "player1")
                .position(x: reader.size.width * 1/2, y: reader.size.height - 55)
                
                VStack(spacing: -50) {
                    ForEach(unoGame.players[1].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle.degrees(-90))
                    }
                }
                .coordinateSpace(name: "player2")
                .position(x: reader.size.width - 55, y: reader.size.height * 1/2)
           

                HStack(spacing: -30) {
                    ForEach(unoGame.players[2].cards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(x: 50))
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 1)) {
                                    unoGame.playCard2(card: card, player: unoGame.players[2])
                                }
                            }
                    }
                }
                .coordinateSpace(name: "player3")
                .position(x: reader.size.width * 1/2, y: 55)
                    
      
                VStack(spacing: -50) {
                    ForEach(unoGame.players[3].cards) { card in
                        CardView(card: card)
                            .rotationEffect(Angle.degrees(90))
                    }
                }
                .coordinateSpace(name: "player4")
                .position(x: 55, y: reader.size.height * 1/2)
                
                ZStack {
                    ForEach(unoGame.cards) { card in
                        CardView(card: card)
                    }
                }
                .coordinateSpace(name: "stack")
                .position(x: reader.size.width * 1/2 - 45, y: reader.size.height * 1/2)
                
                ZStack {
                    ForEach(unoGame.inPlayCards) { card in
                        CardView(card: card)
                    }
                }
                .coordinateSpace(name: "discard")
                .position(x: reader.size.width * 1/2 + 45, y: reader.size.height * 1/2)
            }
            .onRotate { newOrientation in
                orientation = newOrientation
                if orientation.isPortrait {
                    heightAdjust = 220
                    widthAdjust = 0
                } else if orientation.isLandscape {
                    heightAdjust = 0
                    widthAdjust = 220
                }
            }
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

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(unoGame: UnoGameViewModel())
    }
}

