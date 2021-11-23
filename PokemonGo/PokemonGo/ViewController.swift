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
        return table
    }()
    
    var results: PokemonResponse? = nil
    
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
    
    func getPokemons() {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
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
            print("Datos deserializados: \(jsonPetition)")
            self.results = jsonPetition
            
            DispatchQueue.main.async {
                self.tablePokemons.reloadData()
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
        
    }


}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = results?.results[indexPath.row].name
        
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
        return "Total de pokemones: \(results?.count ?? 0)"
        
    }
    
}

