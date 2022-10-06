//
//  ColorPicker.swift
//  UnoProject1
//
//  Created by John Critchlow on 10/5/22.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var chosenColor: Color
    var body: some View {
        VStack {
            Text("Choose the Color")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.red)
                    .frame(maxHeight: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 4)
                    )
                    .onTapGesture {
                        chosenColor = Color.red
                    }

                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue)
                    .frame(maxHeight: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 4)
                    )
                    .onTapGesture {
                        chosenColor = Color.blue
                    }
                RoundedRectangle(cornerRadius: 15)
                    .fill(.green)
                    .frame(maxHeight: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 4)
                    )
                    .onTapGesture {
                        chosenColor = Color.green
                    }
                RoundedRectangle(cornerRadius: 15)
                    .fill(.yellow)
                    .frame(maxHeight: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: 4)
                    )
                    .onTapGesture {
                        chosenColor = Color.yellow
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


//
//struct ColorPicker_Previews: PreviewProvider {
//    static var previews: some View {
////        ColorPicker(chosenColor: Binding<red>)
////            .background(.blue)
////            .padding()
//    }
//}
