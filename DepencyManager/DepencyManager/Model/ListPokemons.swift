//
//  ListPokemons.swift
//  DepencyManager
//
//  Created by Isrrael Torres Alvarado on 29/11/21.
//

struct ListPokemons: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}
