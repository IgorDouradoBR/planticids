//
//  CheckForTranslation.swift
//  Plants Api test
//
//  Created by Luciana Lemos on 14/10/23.
//

import Foundation

func checkName(of name: String) -> String {
    let listOfPlants: [String : String] = [
        "European Silver Fir": String(localized: "European Silver Fir"),
        "Pyramidalis Silver Fir": String(localized: "Pyramidalis Silver Fir"),
        "White Fir": String(localized: "White Fir"),
        "Candicans White Fir": String(localized: "Candicans White Fir"),
        "Fraser Fir": String(localized: "Fraser Fir"),
        "Golden Korean Fir": String(localized: "Golden Korean Fir"),
        "Alpine Fir": String(localized: "Alpine Fir"),
        "Blue Spanish Fir": String(localized: "Blue Spanish Fir"),
        "Noble Fir": String(localized: "Noble Fir"),
        "Johin Japanese Maple": String(localized: "Johin Japanese Maple")
    ]
        
    if listOfPlants.keys.contains(name) {
        if let unwrappedName = listOfPlants[name] {
            return unwrappedName
        }
    }

    return name
}
