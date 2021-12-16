//
//  SerieCollectionViewCell.swift
//  Series
//
//  Created by Isrrael Torres Alvarado on 13/12/21.
//

import UIKit

class SerieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    func configure(item: String) {
        itemImage.image = UIImage(named: item)
        itemTitle.text = item
    }
    
}
