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
                else if card.isFaceUp {
                    if card.number < 10 {
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
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
                    } else if card.number == 10 {
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                        Ellipse().fill(.white).frame( width: 70, height: 50)
                            .rotationEffect(Angle(degrees: -40))
                        Text("UNO")
                            .font(.title)
                            .foregroundColor(card.color)
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
                    } else if card.number == 11 {
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                        Ellipse().fill(.white).frame( width: 70, height: 50)
                            .rotationEffect(Angle(degrees: -40))
                        Text("UNO")
                            .font(.title)
                            .foregroundColor(card.color)
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
                    } else if card.number == 12 {
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.white, lineWidth: 3)
                        Ellipse().fill(.white).frame( width: 70, height: 50)
                            .rotationEffect(Angle(degrees: -40))
                        Text("UNO")
                            .font(.title)
                            .foregroundColor(card.color)
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
                    } else if card.number == 13{
                        RoundedRectangle(cornerRadius: Card.cornerRadius).stroke(.black, lineWidth: 4)
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
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
                        RoundedRectangle(cornerRadius: Card.cornerRadius).fill(card.color)
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
                    Text("UNO")
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                    Text(String(card.number))
                        .font(.title)
                        .foregroundColor(card.color)
                        .bold()
                        .position(x:15,y:15)
                    Text(String(card.number))
                        .font(.title)
                        .foregroundColor(card.color)
                        .bold()
                        .position(x:15,y:15)
                        .rotationEffect(Angle(degrees: 180))
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
        CardView(card: UnoGame<String>.Card(isFaceUp: true, number: 5, color: .black, id: 1))
            .padding(100)
    }
}
