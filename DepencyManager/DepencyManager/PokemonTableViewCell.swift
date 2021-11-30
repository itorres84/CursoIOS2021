//
//  PokemonTableViewCell.swift
//  DepencyManager
//
//  Created by Invitado on 29/11/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
   
    @IBOutlet weak var lblName: UILabel!
    
    func bind(pokemon: Pokemon) {
        lblName.text = pokemon.name
    }
}
