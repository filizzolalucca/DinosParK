//
//  Predators.swift
//  DinosPark
//
//  Created by Lucca Filizzola on 19/07/26.
//

import Foundation


class Predators {
    var AllApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                AllApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = AllApexPredators
            } catch {
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
            
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: ApType) {
        apexPredators = AllApexPredators
        if type != .all {
            apexPredators = AllApexPredators.filter { predator in
                predator.type == type
            }
        }
        
    }
}
