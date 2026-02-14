//
//  SettingsView.swift
//  flashcard
//
//  Created by Fai on 09/02/26.
//

import SwiftUI

struct SettingsView:View {
    @AppStorage("shuffleCards") private var shuffleCards:Bool = true
    @AppStorage("showBackFirst") private var showBackFirst:Bool = false
    @AppStorage("cardsPerSession") private var cardsPerSession:Int = 10
    
    @AppStorage("darkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        Form{
            
            
            Section("Study"){
                Toggle("Shuffle cards",isOn:$shuffleCards)
                Toggle("Show back first", isOn: $showBackFirst)
                Toggle("Toggle darkmode",isOn: $isDarkMode)
                
                Stepper("Cards per session: \(cardsPerSession)",
                        value: $cardsPerSession,
                        in: 1...50)
            }
            Section("About"){
                Text("These settings persist using UserDefaultys via @AppStorage")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
                
        }
        .navigationTitle("Settings")
        
    }
}


#Preview{
    SettingsView()
}
