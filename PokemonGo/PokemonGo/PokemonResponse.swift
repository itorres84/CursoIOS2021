//
//  PokemonResponse.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 22/11/21.
//

import Foundation

struct PokemonResponse: Decodable {
    
    let count: Int
    let next: String
    let previous: String?
    let results: [ResultPokemon]
    
}

struct ResultPokemon: Decodable {
    
    let name: String
    let url: String
    
}
