//
//  ContentView.swift
//  BarcodeBattle
//
//  Created by Matevos Ghazaryan on 4/30/22.
//

import SwiftUI

struct NameUIView: View {
    @State var name = ""
    @State var isLinkActive = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextFieldContainer.plain(label:
                                            "Type your name", placeholder: "your name", text: $name).padding(25)
                let gameBoardViewModel = GameBoardViewModel()
                NavigationLink(destination: GameBoardUIView(name: name, gameBoardViewModel: gameBoardViewModel),isActive: $isLinkActive) {
                    Button("Start", action: {
                        self.showingAlert = name.isEmpty
                        self.isLinkActive = !name.isEmpty
                    }).buttonStyle(BaseButtonStyle()).alert("Name is required",isPresented: $showingAlert) {
    
                    }
                }
            }.navigationBarTitle("Pick a name", displayMode: .inline)
        }
    }
}
