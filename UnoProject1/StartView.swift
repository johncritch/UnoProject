//
//  StartView.swift
//  UnoProject1
//
//  Created by John Critchlow on 9/22/22.
//

import SwiftUI

struct StartView: View {
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Game")) {
                    NavigationLink("Uno") {
                        GameView(unoGame: UnoGameViewModel())
//                            .navigationTitle("Uno!")
                    }
                    NavigationLink("Record") {
                        Capsule().fill(.purple)
//                            .navigationTitle("Uno!")
                    }
//                    .navigationTitle("Uno!")
                }
                Section(header: Text("Settings")) {
                    TextField("Name", text: $name)
                }
            }
        }
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
