//
//  CardView.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/15/22.
//

import SwiftUI

struct CardView: View {
    var card: UnoGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.id == 0 {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(.white)
                } else if card.isDealt == false {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).opacity(0)
                }
            }
            .cardify(isFaceUp: card.isFaceUp, card: card)
            .foregroundColor(.black)
        }
        .frame(width: 70, height: 105)
    }
    // MARK: - Helpers
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * Card.fontScaleFactor)
    }
    
    //MARK: - Drawing constants
    
    private struct Card {
        static let aspectRatio: Double = 2/3
        static let cornerRadius: Double = 10
        static let fontScaleFactor: CGFloat = 0.75
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: UnoGame<String>.Card(isFaceUp: false, number: 5, color: .black, id: 1))
            .padding(100)
    }
}
