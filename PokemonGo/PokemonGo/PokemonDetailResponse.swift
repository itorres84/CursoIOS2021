//
//  PokemonDetailResponse.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 25/11/21.
//

struct PokemonDetailResponse: Decodable {
    let base_experience: Int
    let height: Int
    let id: Int
    let is_default: Bool
    let location_area_encounters: String
    let name: String
    let order: Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let home: Home
}

struct Home: Codable {
    let front_default: String
}
