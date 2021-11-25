//
//  LoadTableViewCell.swift
//  PokemonGo
//
//  Created by Isrrael Torres Alvarado on 24/11/21.
//

import UIKit

class LoadTableViewCell: UITableViewCell {

    @IBOutlet weak var load: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        load.startAnimating()
    }
    
}
