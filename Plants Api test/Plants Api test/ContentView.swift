//
//  ContentView.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: NetworkPlantCall
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            if !network.resultsPlants.isEmpty {
                Text(network.resultsPlants.first?.commonName ?? "eh")
            }
            
        }
        .padding()
        .onAppear{
            DispatchQueue.main.async {
                network.getPlants()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
