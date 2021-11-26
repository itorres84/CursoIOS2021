//
//  ViewController.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 19/11/21.
//

import UIKit

class ViewController: UIViewController {

    lazy var tablePokemons: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cellPokemon")
        let bundleCell = Bundle(for: LoadTableViewCell.self)
        table.register(UINib(nibName: "LoadTableViewCell", bundle: bundleCell), forCellReuseIdentifier: "cellLoad")
        return table
    }()
    
    var results: PokemonResponse? = nil
    
    var pokemons: [ResultPokemon] = [] {
        didSet {
            tablePokemons.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tablePokemons)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            tablePokemons.topAnchor.constraint(equalTo: margins.topAnchor),
            tablePokemons.leftAnchor.constraint(equalTo: view.leftAnchor),
            tablePokemons.rightAnchor.constraint(equalTo: view.rightAnchor),
            tablePokemons.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        getPokemons()
        
    }
    
    func getPokemons(urlString: String = "https://pokeapi.co/api/v2/pokemon") {
        
        guard let url = URL(string: urlString) else {
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let errorResponse = error {
                print(errorResponse.localizedDescription)
            }
            
            if let dataResponse = data {
                print("Datos de respuesta: \(dataResponse)")
                self.parse(json: dataResponse)
            }
            
        }
        
        task.resume()
        
    }
    
    func parse(json: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let jsonPetition = try decoder.decode(PokemonResponse.self, from: json)
            self.results = jsonPetition
                        
            DispatchQueue.main.async {
                self.pokemons.append(contentsOf: jsonPetition.results)
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
        
    }

}
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < pokemons.count {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPokemon", for: indexPath) as! PokemonTableViewCell
                   cell.configure(pokemon: pokemons[indexPath.row])
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLoad", for: indexPath) as! LoadTableViewCell
            
            if let nextUrl = results?.next {
                getPokemons(urlString: nextUrl)
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Total de pokemones: \(results?.count ?? 0)"
    }
    
}
//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row < pokemons.count {
            return 50
        } else {
            return 80
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pokemon = pokemons[indexPath.row]
        
        let detailViewController = DetailPokemonViewController(pokemon: pokemon)
        //detailViewController.modalPresentationStyle = .fullScreen
        present(detailViewController, animated: true, completion: nil)
        
    }
    

}

