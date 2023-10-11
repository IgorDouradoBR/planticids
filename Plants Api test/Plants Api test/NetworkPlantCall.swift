//
//  NetworkPlantCall.swift
//  Plants Api test
//
//  Created by Raquel Ramos on 11/10/23.
//

import Foundation

class NetworkPlantCall: ObservableObject {
    @Published var resultsPlants: [PlantListStruct] = []
    
    let urlPlantList: String = "https://perenual.com/api/species-list?key=sk-6bgY6526d674187892423"
    
    func getPlants(){
        guard let url = URL(string: urlPlantList) else { fatalError("url não encontrada")}
        let urlRequest = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error { print("deu erro"); return }
            
            guard let response = response as? HTTPURLResponse else { print("deu ruim no response"); return }
            
            if response.statusCode == 200 {
                guard let data = data else { print("deu ruim no data"); return }
                DispatchQueue.main.async {
                    do {
                        let decodedPlants = try JSONDecoder().decode(PlantResults.self, from: data)
                        self.resultsPlants = decodedPlants.data
                        print(self.resultsPlants)
                    } catch let error { print(error); return }
                }
            }
        }
        dataTask.resume()
    }
}
