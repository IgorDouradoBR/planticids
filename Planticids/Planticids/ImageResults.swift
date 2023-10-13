//
//  ContentView.swift
//  Teste
//
//  Created by Igor Dourado  on 10/10/23.
//

import Foundation
// I will use here the simplest way for decoding
struct ImageResults:Codable{
   
    var results:[dataResults]
}
struct dataResults:Codable{
    var score:Double
    var species:Species
}
struct Species:Codable{
    var scientificNameWithoutAuthor,scientificNameAuthorship,scientificName:String
}
