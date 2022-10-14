//
//  Records.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/14/22.
//

import SwiftUI

struct Records: View {
    @AppStorage("highScore") var highScore: Int = 0
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 0)
            .fill(
                LinearGradient(gradient: Gradient(colors: [.red, .red, .white]), startPoint: .top, endPoint: .bottom)
            )
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    Text("High Score:")
                        .bold()
                    Text(String(highScore))
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(.black)
                        .padding()
                    Spacer()
                    
                }
                .frame(width: UIScreen.main.bounds.width / 2, height: 200)
                .padding(.horizontal, 24)
                .background(.white)
                .cornerRadius(30)
                .transition(.move(edge: .bottom))
            )
    }
}

struct Records_Previews: PreviewProvider {
    static var previews: some View {
        Records()
    }
}
