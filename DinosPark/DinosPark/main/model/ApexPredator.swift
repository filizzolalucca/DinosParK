//
//  ApexPredator.swift
//  DinosPark
//
//  Created by Lucca Filizzola on 19/07/26.
//

import Foundation
import SwiftUI
struct ApexPredator: Codable, Identifiable {
    let id: Int
    let name: String
    let type: ApType
    let latitude, longitude: Double
    let movies: [Movie]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }

    enum CodingKeys: String, CodingKey {
        case id, name, type, latitude, longitude, movies
        case movieScenes = "movie_scenes"
        case link
    }
}

// MARK: - MovieScene
struct MovieScene: Codable, Identifiable {
    let id: Int
    let movie: Movie
    let sceneDescription: String

    enum CodingKeys: String, CodingKey {
        case id, movie
        case sceneDescription = "scene_description"
    }
}

enum Movie: String, Codable, Identifiable {
    
    var id: Movie {
        self
    }
    
    case jurassicPark = "Jurassic Park"
    case jurassicParkIII = "Jurassic Park III"
    case jurassicWorld = "Jurassic World"
    case jurassicWorldDominion = "Jurassic World: Dominion"
    case jurassicWorldFallenKingdom = "Jurassic World: Fallen Kingdom"
    case theLostWorldJurassicPark = "The Lost World: Jurassic Park"
}

enum ApType: String, Codable, CaseIterable, Identifiable {
    case all
    case air
    case land
    case sea
    
    /*
     Eu estou fazendo isso porque eu quero rodar todos os casos desse enum para fazer a liste de filtros, e por isso
     é obrigatorio eles serem interavel e identificavel
     
     */
    
    var id: ApType {
        self
    }
    
    var backgroundColor: Color {
        switch self {
        case .air:
            return .teal
        case .land:
            return .brown
        case .sea:
            return .blue
        case .all:
            return .black
        }
    }
    
    var icon: String {
        switch self {
        case .air:
            return "wind"
        case .land:
            return "leaf.fill"
        case .sea:
            return "drop.fill"
        case .all:
            return "square.stack.3d.up.fill"
        }
    }
    
    var backgroundImage: ImageResource {
        switch self {
        case .air:
            return .air
        case .land:
            return .land
        case .sea:
            return .air
        case .all:
            return .air
        }
    }
}
