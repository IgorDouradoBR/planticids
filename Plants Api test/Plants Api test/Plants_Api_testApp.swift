//
//  Plants_Api_testApp.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 11/10/23.
//

import SwiftUI

@main
struct Plants_Api_testApp: App {
    var network = NetworkPlantCall()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
