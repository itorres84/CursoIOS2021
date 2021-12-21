//
//  ProductCollectionViewCell.swift
//  Huerto Ixcatepec
//
//  Created by Isrrael Torres Alvarado on 20/12/21.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBAction func buy(_ sender: Any) {
    }
    
    func configure(product: Product) {
        
        itemName.text = product.name
        itemPrice.text = "$ \(product.price)"
    
        guard let url = URL(string: product.urlImage) else { return }
        downloadImage(from: url)
    
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.itemImage.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
