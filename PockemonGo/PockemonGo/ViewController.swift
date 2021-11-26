//
//  ViewController.swift
//  PockemonGo
//
//  Created by Rom Vargas on 22/11/21.
//

import UIKit
			
class ViewController: UIViewController {
    
    lazy var tablePokemons: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.yellow
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(PokemonTableViewCell.self	, forCellReuseIdentifier: "cellPokemon")
        return table
    }()
    
    var results: PokemonResponse?	 = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tablePokemons)
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            tablePokemons.topAnchor.constraint(equalTo: margins.topAnchor),
            tablePokemons.leftAnchor.constraint(equalTo: margins.leftAnchor),
            tablePokemons.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tablePokemons.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
        
        getPockemons()
    }

    func getPockemons(){
        //Se crea URL a aprtir de un string
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        //Se crea la tare para obtener los pockemones
        let task = session.dataTask(with: request) { data, response, error in
            // se validan daton no nulos
            if let errorResponse = error {
                print(errorResponse.localizedDescription)
            }
            
            if let dataResponse = data {
                print("Datos de respuesta: \(dataResponse)")
                self.parse(json: dataResponse)
            }
        }
        //Se ejecuta la peticion
        task.resume()
    }
    
    func parse(json: Data) {
        let  decoder = JSONDecoder()
        
        do {
            let jsonPetititon = try decoder.decode(PokemonResponse.self, from: json)
            print("Datos deserializados: \(jsonPetititon)")
            self.results = jsonPetititon
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
