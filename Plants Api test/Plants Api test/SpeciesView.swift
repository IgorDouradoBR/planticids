//
//  SpeciesView.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 14/10/23.
//

import SwiftUI

struct SpeciesView: View {
    
    let plantId: Int
    
    @ObservedObject var network = NetworkPlantCharCall()
    
    var body: some View {
        Text("\(plantId)")
        Text(network.speciesResult.commonName)
        Text("cycle:" + network.speciesResult.cycle)
        Text("type:" + network.speciesResult.type)
        Text("watering:" + network.speciesResult.watering)
        Text("sunlight types:")
        ForEach(network.speciesResult.sunlight, id: \.self) { sunlight in
            Text(sunlight)
        }
        
        .onAppear(perform: {
            DispatchQueue.main.async {
                network.getCharacteristics(PlantId: plantId)
            }
        })
    }
    
}

#Preview {
    SpeciesView(plantId: 1)
}
