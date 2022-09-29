//
//  ContentView.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var unoGame: UnoGameViewModel
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    ZStack {
                        let hand3Offset: CGFloat = 175 - (CGFloat(unoGame.p3Cards.count)*25)
                        ForEach(0..<unoGame.p3Cards.count, id: \.self) {
                            index in CardView(card: unoGame.p3Cards[index])
                                .rotationEffect(Angle(degrees: Double.random(in: -3...3)))
                                .onTapGesture {
//                                    unoGame.playCard(card: unoGame.p3Cards[index], player: 3)
//                                    unoGame.runGame()
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
                            let hand4Offset: CGFloat = 175 - (CGFloat(unoGame.p4Cards.count)*25)
                            ForEach(0..<unoGame.p4Cards.count, id: \.self) {
                                index in CardView(card: unoGame.p4Cards[index])
                                    .rotationEffect(Angle(degrees: Double.random(in: -3...3) + 90))
                                    .onTapGesture {
//                                        unoGame.playCard(card: unoGame.p4Cards[index], player: 4)
//                                        unoGame.runGame()
                                    }
                                    .offset(x:10, y:(50 * CGFloat(index)) + hand4Offset)
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
                Group {
                    HStack {
                        ZStack {
                            ForEach(unoGame.cards) {
                                card in CardView(card: card)
                                    .rotationEffect(Angle(degrees: Double.random(in: -5...5)))
                                    .onTapGesture {
                                        unoGame.draw()
                                        if unoGame.turn != 1 {
                                            unoGame.compAI()
                                        }
                                    }
                            }
                        }
                        ZStack {
                            ForEach(unoGame.inPlayCards) {
                                card in CardView(card: card)
                                    .rotationEffect(Angle(degrees: Double.random(in: -5...5)))
                            }
                        }
                    }
                }
                Spacer()
                Group {
                    VStack {
                        ZStack {
                            let hand2Offset: CGFloat = 175 - (CGFloat(unoGame.p2Cards.count)*25)
                            ForEach(0..<unoGame.p2Cards.count, id: \.self) {
                                index in CardView(card: unoGame.p2Cards[index])
                                    .rotationEffect(Angle(degrees: Double.random(in: -3...3) + 90))
                                    .onTapGesture {
//                                        unoGame.playCard(card: unoGame.p2Cards[index], player: 2)
//                                        unoGame.runGame()
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
                        let handOffset: CGFloat = 175 - (CGFloat(unoGame.p1Cards.count)*25)
                        ForEach(0..<unoGame.p1Cards.count, id: \.self) {
                            index in CardView(card: unoGame.p1Cards[index])
                                .rotationEffect(Angle(degrees: Double.random(in: -3...3)))
                                .onTapGesture {
                                    unoGame.whatTurn()
                                    if unoGame.playCard(card: unoGame.p1Cards[index], player: 1) {
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
                        }
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(width: 100.0, height: 75.0)
//                        .foregroundColor(.red)
//                        .overlay(Text("Draw").font(.title).foregroundColor(.white))
//                        .onTapGesture {
//                            unoGame.draw()
//                            if unoGame.turn != 1 {
//                                unoGame.compAI()
//                            }
//                        }
                }.padding()
            }
        }.padding()
    }
    // MARK: - Helpers
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / Card.desiredWidth))
    }
    
    // MARK: - Card
    
    private struct Card {
        static let desiredWidth: CGFloat = 50
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(unoGame: UnoGameViewModel())
    }
}
