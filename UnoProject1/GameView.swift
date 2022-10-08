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
    @State var playedCard: Bool = false
    
    private var xOffset: CGFloat {
        return playedCard ? 100 : 50
    }
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Group {
                    HStack {
                        ZStack {
                            let hand3Offset: CGFloat = 175 - (CGFloat(unoGame.players[2].cards.count)*25)
                            ForEach(0..<unoGame.players[2].cards.count, id: \.self) { index in
                                CardView(card: unoGame.players[2].cards[index])
                                    .rotationEffect(Angle(degrees: unoGame.players[2].cards[index].tilt))
                                    .transition(AnyTransition.offset(y: reader.size.height * 1/2))
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 1)) {
                                            unoGame.playCard2(card: unoGame.players[2].cards[index], player: unoGame.players[2])
                                        }
                                    }
                                    .offset(x: (50 * CGFloat(index)) + hand3Offset)
                                    .transition(.scale)
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
                                    .offset(x: xOffset * CGFloat(index) + handOffset)
                                    .onTapGesture {
                                        unoGame.whatTurn()
                                        self.playedCard.toggle()
                                        if unoGame.canPlay {
                                            if unoGame.players[0].cards[index].number == 13 || unoGame.players[0].cards[index].number == 14 {
                                                unoGame.canPlay = false
                                                unoGame.chooseColor(card: unoGame.players[0].cards[index], player: unoGame.players[0])
                                            } else if unoGame.playCard(card: unoGame.players[0].cards[index], player: unoGame.players[0], desiredColor: chosenColor) {
                                                unoGame.canPlay = false
                                                if !unoGame.isWin() {
                                                    unoGame.compAI()
                                                }
                                            }
                                        }
                                    }
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
                    WinningView(won: self.$won, message: unoGame.winnerMessage)
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(unoGame: UnoGameViewModel())
    }
}
