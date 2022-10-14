//
//  WinningView.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/5/22.
//

import SwiftUI

struct WinningView: View {
    @Binding var won: Bool
//    @State var won = false
    @State var message: String
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.ultraThinMaterial)
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    Text(message)
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    HStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.ultraThinMaterial)
                            .frame(maxHeight: 50)
                            .overlay {
                                Text("New Game")
                            }
                            .onTapGesture {
                                won.toggle()
                            }
                    }.padding(.bottom, 30)
                    
                }
                .padding(.horizontal, 24)
                .background(.white)
                .cornerRadius(30)
                .frame(width: UIScreen.main.bounds.width - 20, height: 300)
                .transition(.move(edge: .bottom))
            )
    }
}
//
//struct WinningView_Previews: PreviewProvider {
//    static var previews: some View {
//        WinningView(won: true, message: "Winner")
//    }
//}
