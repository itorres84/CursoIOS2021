//
//  PokemonServiceClient.swift
//  DepencyManager
//
//  Created by Invitado on 29/11/21.
//

import Foundation
import Alamofire

class PokemonServiceClient {
    
    func getPokemon(completionHandler: @escaping (ListPokemon?, Error?) -> Void){
        
    AF.request("https://pokeapi.co/api/v2/pokemon").responseDecodable(of: ListPokemon.self) { response in

        switch response.result {
        case .failure(let error):
        completionHandler(nil, error)
        case .success(let listPokemon):
            completionHandler(listPokemon, nil)
         }

      }
        
   }
    
}
