//
//  PokemonServiceClient.swift
//  DepencyManager
//
//  Created by Isrrael Torres Alvarado on 29/11/21.
//

import Foundation
import Alamofire

class PokemonServiceClient {

    func getPokemons(completionHandler: @escaping (ListPokemons?, Error?) -> Void) {
    
        AF.request("https://pokeapi.co/api/v2/pokemon").responseDecodable(of: ListPokemons.self) { response in
            switch response.result {
            case .failure(let error):
                completionHandler(nil, error)
            case .success(let listPokemons):
                completionHandler(listPokemons, nil)
            }
        }
        
    }
        
}
