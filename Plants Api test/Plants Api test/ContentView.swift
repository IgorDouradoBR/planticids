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
        NavigationStack{
            VStack {
                if !network.resultsPlants.isEmpty {
                    List{
                        ForEach(network.resultsPlants) { plants in
                            NavigationLink {
                                SpeciesView(plantId: plants.id)
                            } label: {
                                Text(checkName(of: plants.commonName))
                            }
                        }
                    }
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
}

//#Preview {
//    ContentView()
//}
