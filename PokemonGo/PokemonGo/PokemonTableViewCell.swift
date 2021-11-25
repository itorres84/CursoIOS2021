//
//  PokemonTableViewCell.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 24/11/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(lblName)
        
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: topAnchor),
            lblName.rightAnchor.constraint(equalTo: rightAnchor),
            lblName.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            lblName.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokemon: ResultPokemon) {
        lblName.text = pokemon.name
    }
    
}
