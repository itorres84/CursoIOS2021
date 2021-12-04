//
//  ViewController.swift
//  LocationTutorial
//
//  Created by Isrrael Torres Alvarado on 02/12/21.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnNavigate: UIButton!
    
    let locationManager = CLLocationManager()
    var place: CLPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //obtiene la localizacion
        locationManager.startUpdatingLocation()
        guard let currentLocation = locationManager.location else { return }
        
        print("Ubicación actual: \(currentLocation)")
        print("latitud: \(currentLocation.coordinate.latitude)")
        print("longitud: \(currentLocation.coordinate.longitude)")
            
        //Crea la region para mostrar la localizacion
        let rangeInMeters: Double = 1000
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: rangeInMeters, longitudinalMeters: rangeInMeters)
             
        //mapa
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? SearchViewController {
            
            destinationViewController.delegate = self
            
        }
        
    }
    
    
    @IBAction func navigate(_ sender: Any) {
        
        guard let searchPlace = place else { return }
        print("iniciar proceso de navegacion...")
        
    }
    
}

extension ViewController: SearchViewControllerDelegate {
    
    func navigate(place: CLPlacemark) {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let annotation = MKPointAnnotation()
        
        if let coordinate = place.location?.coordinate {
            annotation.coordinate = coordinate
        }
        
        annotation.title = place.name
        
        if let city = place.locality, let state = place.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        self.mapView.addAnnotation(annotation)
        
        guard let coordinate = place.location?.coordinate else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        btnNavigate.isHidden = false
        self.place = place
        
    }

}




