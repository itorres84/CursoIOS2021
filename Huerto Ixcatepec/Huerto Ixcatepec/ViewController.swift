//
//  ViewController.swift
//  Huerto Ixcatepec
//
//  Created by Isrrael Torres Alvarado on 20/12/21.
//

import UIKit
import FirebaseDatabase

struct Product {
    
    let id: String
    let description: String
    let name: String
    let price: Double
    let stock: Int
    let urlImage: String
    
    init(data: [String: Any]) {
        
        if let id = data["id"] as? String {
            self.id = id
        } else {
            self.id = ""
        }
        
        if let description = data["description"] as? String {
            self.description = description
        } else {
            self.description = ""
        }
        
        if let name = data["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let price = data["price"] as? Double {
            self.price = price
        } else {
            self.price = 0.0
        }
        
        if let stock = data["stock"] as? Int {
            self.stock = stock
        } else {
            self.stock = 0
        }
        
        if let urlImage = data["urlImage"] as? String {
            self.urlImage = urlImage
        } else {
            self.urlImage = ""
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var ref: DatabaseReference = Database.database().reference()
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("appEngine/Catalog/products").observe(.value) { dataSnapshot in
                
            guard let data = dataSnapshot.value as? [[String: Any]] else { return }
                
            var products: [Product] = []
            _ = data.map({ data in
                products.append(Product(data: data))
            })
            
            self.products = products
            self.collectionView.reloadData()
            
        }
        
    }

}

extension ViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        cell.configure(product: product)
        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 30) / 2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

}


