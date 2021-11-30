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
    
    var pokemons: [Pokemon] = [] {
        didSet {
            pokemonTableView.reloadData()
        }
    }
    
    let service: PokemonServiceClient = PokemonServiceClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getPokemons { [weak self] result, error in
            
            guard let self = self else { return }
            
            if let existError = error {
                print(existError.localizedDescription)
            }
            
            if let listPokemons = result {
                self.pokemons.append(contentsOf: listPokemons.results)
            }
            
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell
        cell.bind(pokemon: pokemons[indexPath.row])
        return cell
    }
    
}

