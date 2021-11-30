//
//  ListPokemon.swift
//  DepencyManager
//
//  Created by Invitado on 29/11/21.
//

struct ListPokemon: Decodable {

    let count: Int
    let next: String
    let previous: String?
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    
    let name: String
    let url: String
}
