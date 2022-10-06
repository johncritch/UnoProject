//
//  WinningView.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/5/22.
//

import SwiftUI

struct WinningView: View {
    @Binding var won: Bool
    var body: some View {
        VStack {
            Text("Winner!")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(maxHeight: 50)
                    .overlay {
                        Text("New Game")
                    }
                    .onTapGesture {
                        won = true
                    }
            }.padding(.bottom, 30)
        }
        .padding(.horizontal, 24)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .frame(width: UIScreen.main.bounds.width - 20)
        .transition(.move(edge: .bottom))
    }
}

//struct WinningView_Previews: PreviewProvider {
//    static var previews: some View {
//        WinningView()
//    }
//}
