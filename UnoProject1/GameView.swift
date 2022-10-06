//
//  ContentView.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var unoGame: UnoGameViewModel
    @State var chosenColor = Color.black
    @State var won = false
    
    var body: some View {
//        VStack {
//            HStack {
//                ZStack {
//                    ForEach(0..<unoGame.cards.count, id: \.self) { index in
//                        CardView(card: unoGame.cards[index])
//                            .rotationEffect(Angle(degrees: unoGame.cards[index].tilt))
//                            .onTapGesture {
//                                unoGame.draw(player: unoGame.players[0])
//                            }
//                    }
//                }
//                .scaleEffect(0.75)
//
//                ZStack {
//                    ForEach(0..<unoGame.inPlayCards.count, id: \.self) { index in
//                        CardView(card: unoGame.inPlayCards[index])
//                            .rotationEffect(Angle(degrees: unoGame.inPlayCards[index].tilt))
//
//                    }
//                }
//                .scaleEffect(0.75)
//            }
//            ForEach (unoGame.players) { player in
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: -50, alignment: .center)]) {
//                    ForEach(0..<player.cards.count, id: \.self) { index in
//                        CardView(card: player.cards[index])
//                            .transition(AnyTransition.offset(x: -20, y: -100))
//                            .rotationEffect(Angle(degrees: player.cards[index].tilt))
//                            .onTapGesture {
//                                unoGame.whatTurn()
//                                if unoGame.playCard(card: player.cards[index], player: player) {
//                                    unoGame.compAI()
//                                }
//                            }
//                        }
//                    }
//                }
//                .frame(width: 400)
//                .scaleEffect(0.75)
//            }
//        .onAppear {
//            unoGame.dealCards()
//        }
//    }
    
        VStack {
            Group {
                HStack {
                    ZStack {
                        let hand3Offset: CGFloat = 175 - (CGFloat(unoGame.players[2].cards.count)*25)
                        ForEach(0..<unoGame.players[2].cards.count, id: \.self) { index in
                            CardView(card: unoGame.players[2].cards[index])
//                                .stacked(at: index, in: unoGame.p3Cards.count)
                                .rotationEffect(Angle(degrees: unoGame.players[2].cards[index].tilt))
//                                .transition(AnyTransition.asymmetric(insertion: .offset(y: 100), removal: .offset(y: 100)))
                                .onTapGesture {
                                    unoGame.whatTurn()
//                                    unoGame.playCard(card: unoGame.players[3].cards[index], player: 3)
                                }
                                .offset(x: (50 * CGFloat(index)) + hand3Offset)
                        }
                    }
                    Spacer()
                }
            }
            HStack {
                Group {
                    VStack {
                        ZStack {
                            let hand4Offset: CGFloat = 175 - (CGFloat(unoGame.players[3].cards.count)*25)
                            ForEach(0..<unoGame.players[3].cards.count, id: \.self) {
                                index in CardView(card: unoGame.players[3].cards[index])
                                    .rotationEffect(Angle(degrees: unoGame.players[3].cards[index].tilt + 90))
//                                    .transition(AnyTransition.offset(x: 50, y: 50))
                                    .onTapGesture {
                                        unoGame.whatTurn()
//                                        unoGame.playCard(card: unoGame.players[4].cards[index], player: 4)
                                    }
                                    .offset(x:10, y:(50 * CGFloat(index)) + hand4Offset)
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
                Group {
                    VStack {
                        Text(unoGame.displayMessage)
                        HStack {
                            ZStack {
                                ForEach(unoGame.cards) {
                                    card in CardView(card: card)
                                        .rotationEffect(Angle(degrees: card.tilt))
                                    //                                    .transition(AnyTransition.offset(x: 50, y: 50))
                                        .onTapGesture {
                                            unoGame.draw(player: unoGame.players[0])
                                            if unoGame.turn != 1 {
                                                //                                            unoGame.compAI()
                                            }
                                        }
                                }
                            }
                            ZStack {
                                ForEach(unoGame.inPlayCards) {
                                    card in CardView(card: card)
                                        .rotationEffect(Angle(degrees: card.tilt))
                                }
                            }
                        }
                    }
                }
                Spacer()
                Group {
                    VStack {
                        ZStack {
                            let hand2Offset: CGFloat = 175 - (CGFloat(unoGame.players[1].cards.count)*25)
                            ForEach(0..<unoGame.players[1].cards.count, id: \.self) {
                                index in CardView(card: unoGame.players[1].cards[index])
                                    .rotationEffect(Angle(degrees: unoGame.players[1].cards[index].tilt + 90))
//                                    .transition(AnyTransition.offset(x: 50, y: 50))
                                    .onTapGesture {
                                        unoGame.whatTurn()
//                                        unoGame.playCard(card: unoGame.players[2].cards[index], player: players[1])
                                    }
                                    .offset(x:-10, y:(50 * CGFloat(index)) + hand2Offset)
                            }
                        }
                        Spacer()
                    }
                }
            }
            Group {
                HStack {
                    ZStack {
                        let handOffset: CGFloat = 175 - (CGFloat(unoGame.players[0].cards.count)*25)
                        ForEach(0..<unoGame.players[0].cards.count, id: \.self) {
                            index in CardView(card: unoGame.players[0].cards[index])
                                .rotationEffect(Angle(degrees: unoGame.players[0].cards[index].tilt))
//                                .transition(AnyTransition.offset(x: 50, y: 50))
                                .onTapGesture {
                                unoGame.whatTurn()
                                    if unoGame.players[0].cards[index].number == 13 || unoGame.players[0].cards[index].number == 14 {
                                        unoGame.chooseColor(card: unoGame.players[0].cards[index], player: unoGame.players[0])
                                    } else if unoGame.playCard(card: unoGame.players[0].cards[index], player: unoGame.players[0], desiredColor: chosenColor) {
                                        unoGame.compAI()
                                    }
                                }
                                .offset(x: 50 * CGFloat(index) + handOffset)
                        }
                    }
                    Spacer()
                }
            }
            Group {
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 160.0, height: 75.0)
                        .foregroundColor(.red)
                        .overlay(Text("New Game").font(.title).foregroundColor(.white))
                        .onTapGesture {
                            unoGame.newGame()
                            unoGame.dealCards()
                        }
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100.0, height: 75.0)
                        .foregroundColor(.red)
                        .overlay(Text("Turn").font(.title).foregroundColor(.white))
                        .onTapGesture {
                            print(unoGame.canPlay)
                        }
                }.padding()
            }
            .onAppear {
                if !unoGame.alreadyDealt{
                    unoGame.dealCards()
                }
            }
        }
        .padding()
        .overlay(alignment: .bottom) {
            if unoGame.chooseColorPopUp {
                ColorPicker(chosenColor: self.$chosenColor)
            }
        }
        .overlay(alignment: .bottom) {
            if unoGame.winnerPopUp {
                WinningView(won: self.$won)
            }
        }
        .onChange(of: chosenColor) { newColor in
            unoGame.chooseColorPopUp.toggle()
            if unoGame.playCard(card: unoGame.wildCard, player: unoGame.wildPlayer, desiredColor: chosenColor) {
                unoGame.compAI()
            }
        }
        .onChange(of: won) { newColor in
            unoGame.winnerPopUp.toggle()
            won = false
        }
    }
    // MARK: - Helpers
//    private func columns(for size: CGSize) -> [GridItem] {
//        Array(repeating: GridItem(.flexible()), count: Int(size.width / Card.desiredWidth))
//    }
    
    // MARK: - Card
    
    private struct Card {
        static let desiredWidth: CGFloat = 50
    }
}
//
//extension View {
//    func stacked(at position: Int, in total: Int) -> some View {
//        let offset = Double(total - position)
//        return self.offset(x: CGFloat(position) * 40)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(unoGame: UnoGameViewModel())
    }
}
