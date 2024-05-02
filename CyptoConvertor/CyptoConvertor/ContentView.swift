//
//  ContentView.swift
//  CyptoConvertor
//
//  Created by Malick Moro-Samah on 30/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainView(rate: "", usdAmount: "", cediAmount: "", quantity: "")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
