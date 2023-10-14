//
//  PlantStruct.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 11/10/23.
//

import Foundation

struct PlantResults: Decodable {
    var data: [PlantListStruct]
}

struct PlantListStruct: Decodable, Identifiable {
    var id: Int
    var commonName: String
    var scientificName: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case id
        
    }
}

struct SpeciesCharacterists: Decodable {
    var commonName: String
    var type: String
    var cycle: String
    var watering: String
    var sunlight: [String]
    
    enum CodingKeys: String, CodingKey {
        case commonName = "common_name"
        case type
        case cycle
        case watering
        case sunlight
    }
}







