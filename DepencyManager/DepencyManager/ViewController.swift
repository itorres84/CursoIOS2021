//
//  ViewController.swift
//  DepencyManager
//
//  Created by Isrrael Torres Alvarado on 26/11/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var pokemon: [Pokemon] = [] {
        didSet {
            pokemonTableView.reloadData()
        }
    }
    
    
    let service: PokemonServiceClient = PokemonServiceClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        service.getPokemon { [weak self] result, error in
            
            guard let self = self else { return }
            
            if let existError = error {
                print(existError.localizedDescription)
            }
            
            if let listPokemon = result {
                self.pokemon.append(contentsOf: listPokemon.results)
            }
            
        }

   }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
            cell.bind(pokemon: pokemon[indexPath.row])
        return cell
    }
}
