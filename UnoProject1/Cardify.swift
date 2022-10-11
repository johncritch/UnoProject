//
//  Cardify.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/10/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    var thisCard: UnoGame<String>.Card
    
    init(isFaceUp: Bool, card: UnoGame<String>.Card) {
        rotation = isFaceUp ? 0 : 180
        thisCard = card
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                if thisCard.number < 10 {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(thisCard.color)
                        .bold()
                    Text(String(thisCard.number))
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                    Text(String(thisCard.number))
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else if thisCard.number == 10 {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(thisCard.color)
                        .bold()
                    Image(systemName: "nosign")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                    Image(systemName: "nosign")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else if thisCard.number == 11 {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(thisCard.color)
                        .bold()
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else if thisCard.number == 12 {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(thisCard.color)
                        .bold()
                    Text("+2")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                    Text("+2")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else if thisCard.number == 13{
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    ZStack {
                        Text("W")
                            .font(.title)
                            .foregroundColor(.red)
                            .bold()
                            .italic()
                            .offset(x:-16)
                        
                        Text("I")
                            .font(.title)
                            .foregroundColor(.blue)
                            .bold()
                            .italic()
                            .offset(x:-2)
                        Text("L")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .bold()
                            .italic()
                            .offset(x:7)
                        Text("D")
                            .font(.title)
                            .foregroundColor(.green)
                            .bold()
                            .italic()
                            .offset(x:20)

                    }.padding(8)
                    Image(systemName: "circle.hexagongrid.fill") .renderingMode(.original)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                    Image(systemName: "circle.hexagongrid.fill") .renderingMode(.original)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                } else {
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).fill(thisCard.color)
                    RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                    Ellipse().fill(.white).frame( width: 70, height: 50)
                        .rotationEffect(Angle(degrees: -40))
                    ZStack {
                        Text("W")
                            .font(.title)
                            .foregroundColor(.red)
                            .bold()
                            .italic()
                            .offset(x:-16)
                        
                        Text("I")
                            .font(.title)
                            .foregroundColor(.blue)
                            .bold()
                            .italic()
                            .offset(x:-2)
                        Text("L")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .bold()
                            .italic()
                            .offset(x:7)
                        Text("D")
                            .font(.title)
                            .foregroundColor(.green)
                            .bold()
                            .italic()
                            .offset(x:20)

                    }.padding(8)
                    Image(systemName: "circle.hexagongrid.fill") .renderingMode(.original)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                    Text("4")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                    Image(systemName: "circle.hexagongrid.fill") .renderingMode(.original)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                    Text("4")
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
                }
            } else {
                RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                RoundedRectangle(cornerRadius: Card.cornerRadius)
                RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                Ellipse().fill(.red).frame( width: 70, height: 50)
                    .rotationEffect(Angle(degrees: -40))
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                Text("UNO")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
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
            
            content.opacity(isFaceUp ? 1:0)
        }
        .transition(.scale)
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    //MARK: - Drawing constants
    
    private struct Card {
        static let cornerRadius: Double = 10
    }
}

extension View {
    func cardify(isFaceUp: Bool, card: UnoGame<String>.Card) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, card: card))
    }
}
