//
//  StartView.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/22/22.
//

import SwiftUI

struct StartView: View {
    @AppStorage("highScore") var highScore: Int = 0
    
    var body: some View {
        VStack {
            NavigationStack {
//                Form {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [.red, .red, .red, .white]), startPoint: .top, endPoint: .bottom)
                        )
                        .frame(height: 700)
                        .overlay(
                            Ellipse().fill(.white).frame( width: 420, height: 320)
                                .rotationEffect(Angle(degrees: -40))
                        )
                        .overlay(
                            Ellipse().fill(.black).frame( width: 400, height: 300)
                                .rotationEffect(Angle(degrees: -40))
                        )
                        .overlay(
                            Text("UNO")
                                .foregroundColor(.white)
                                .font(.system(size: 161))
                        )
                        .ignoresSafeArea()
                    NavigationLink("Play Uno!") {
                        ContentView(unoGame: UnoGameViewModel())
                    }
                    .frame(width: 300, height: 50)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 30))
                    .bold()
                    
                    NavigationLink("Records") {
                        Records()
                    }
                    .frame(width: 300, height: 50)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 30))
                    .bold()
                    Spacer(minLength: 40)
                }
//            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
