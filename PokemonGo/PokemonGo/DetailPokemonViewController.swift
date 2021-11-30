//
//  DetailPokemonViewController.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 25/11/21.
//

import UIKit

class DetailPokemonViewController: UIViewController {

    lazy var activitiIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var lblLoad: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cargando..."
        return label
    }()
    
    lazy var imagePokemon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = pokemon.name
        return label
    }()
    
    let pokemon: ResultPokemon
    
    init(pokemon: ResultPokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        getInfoPokemon(urlString: pokemon.url)
        
    }
    
    func getInfoPokemon(urlString: String) {
        
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
            
            let jsonPetition = try decoder.decode(PokemonDetailResponse.self, from: json)
            self.bind(pokemon: jsonPetition)
            
        } catch {
            print(error.localizedDescription)
            
        }
        
    }
    
    func configureUI() {
        
        view.addSubview(activitiIndicator)
        view.addSubview(lblLoad)
        view.addSubview(imagePokemon)
        view.addSubview(lblName)
        
        let margin = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            //Label load
            lblLoad.topAnchor.constraint(equalTo: activitiIndicator.bottomAnchor, constant: 10),
            lblLoad.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            //Image Pokemon
            imagePokemon.topAnchor.constraint(equalTo: margin.topAnchor, constant: 50),
            imagePokemon.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            imagePokemon.widthAnchor.constraint(equalToConstant: 300),
            imagePokemon.heightAnchor.constraint(equalToConstant: 300),
            
            lblName.topAnchor.constraint(equalTo: imagePokemon.bottomAnchor),
            lblName.centerXAnchor.constraint(equalTo: margin.centerXAnchor)
            
        ])
        
    }
    
    func bind(pokemon: PokemonDetailResponse) {
       let urlString = pokemon.sprites.other.home.front_default
       dowloadImage(stringUrl: urlString)
    }
    
    func dowloadImage(stringUrl: String) {
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _ , error in
            
            if let errorResponse = error {
                print(errorResponse.localizedDescription)
            }
            
            guard let dataResponse = data else { return }
            
            DispatchQueue.main.async {
                self.imagePokemon.image = UIImage(data: dataResponse)
                self.activitiIndicator.stopAnimating()
                self.lblLoad.isHidden = true
            }
            
        }
        
        task.resume()
        
    }
    
    
}
