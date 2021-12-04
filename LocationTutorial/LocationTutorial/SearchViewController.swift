//
//  SearchViewController.swift
//  LocationTutorial
//
//  Created by Isrrael Torres Alvarado on 03/12/21.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate {
    func navigate(place: CLPlacemark)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblPlaces: UILabel!
    
    var delegate: SearchViewControllerDelegate?
    
    var placeSearch: CLPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
    }
    
    @IBAction func navigate(_ sender: Any) {
        
        guard let place = placeSearch else { return }
        dismiss(animated: true) {
            self.delegate?.navigate(place: place)
        }
        
    }
    
}
//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(text) { places, error in
                
            if let existError = error {
                print(existError.localizedDescription)
            } else if let places = places, let place = places.first {
                
                print(place)
                self.lblPlaces.text = place.debugDescription
                self.placeSearch = place
            
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
}
