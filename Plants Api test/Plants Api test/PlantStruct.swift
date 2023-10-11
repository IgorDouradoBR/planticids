//
//  PlantStruct.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 11/10/23.
//

import Foundation

struct PlantResults: Decodable {
    var data: [PlantListStruct]
//    var to: Int
//    var perPage: Int
//    var currentPage: Int
//    var from: Int
//    var lastPage: Int
//    var total: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case data
//        case perPage = "per_Page"
//        case currentPage = "current_page"
//        case lastPage = "last_page"
//        case to
//        case from
//        case total
//    }
}

struct PlantListStruct: Decodable {
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
    var type: String
    var cycle: String
    var watering: String
    var sunlight: [String]
    
}







