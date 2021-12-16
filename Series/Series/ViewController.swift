//
//  ViewController.swift
//  Series
//
//  Created by Isrrael Torres Alvarado on 13/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let tvSeries = ["Perdidos", "Friends", "Breaking Bad", "Dexter", "Futurama", "Los Soprano", "Mad Men", "House", "Anatomia de Grey", "24", "CSI", "Deadwood", "Expediente X", "Fringe", "Heroes", "Juego de Tronos", "Los Simpsons", "Doctor Who", "Modern Family", "Padre de Familia", "Prison Break", "South Park", "The Big Bang Theory", "The Walking Dead"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
//MARK: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SerieCollectionViewCell
        cell.configure(item: tvSeries[indexPath.row])
        
        return cell
    }
    
}
//MARK: UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    
    //Controla el tamaño de la celda
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 30) / 2 , height: 250 )
    }
    
    //Controla el espacio de forma forma vertical entre celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //Controla el espacio de forma forma horiontal entre celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //Controla el espacio que existe al rededor de las celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

