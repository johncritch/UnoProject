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
                }
                else if card.isFaceUp {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke()
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(card.color)
                        .bold()
                    Text(String(card.number))
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                    Text(String(card.number))
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else {
                    RoundedRectangle(cornerRadius: Card.cornerRadius)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white)
                    Ellipse().fill(.red).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
//                    Text(String(card.number))
//                        .font(.title)
//                        .foregroundColor(card.color)
//                        .bold()
//                        .position(x:15,y:15)
//                    Text(String(card.number))
//                        .font(.title)
//                        .foregroundColor(card.color)
//                        .bold()
//                        .position(x:15,y:15)
//                        .rotationEffect(Angle(degrees: 180))
                }
            }
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
        CardView(card: UnoGame<String>.Card(isFaceUp: true, number: 5, color: .red, id: 1))
            .padding(100)
    }
}
