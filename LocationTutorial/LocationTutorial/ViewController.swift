//
//  ViewController.swift
//  LocationTutorial
//
//  Created by Isrrael Torres Alvarado on 02/12/21.
//

import UIKit
import CoreLocation
import MapKit
import Speech

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
        mapView.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationViewController = segue.destination as? SearchViewController {
            
            destinationViewController.delegate = self
            
        }
        
    }
    
    @IBAction func navigate(_ sender: Any) {
        
        //1 obtener coordenas del punto origen y punto destino
        guard let sourceCordinate = locationManager.location?.coordinate,
              let destionationCoordinate = place?.location?.coordinate else { return }
       
        //2 crear un marck a partir de dos coordenadas
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCordinate)
        let destinationPlaceMark = MKPlacemark(coordinate: destionationCoordinate)
       
        //3 crear un menu item apartir de marks
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        
        let routeRequest = MKDirections.Request()
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .automobile
        
        let directions = MKDirections(request: routeRequest)
        
        directions.calculate { respnse, error in
        
            if let existError = error {
                print(existError.localizedDescription)
            }
            
            guard let response = respnse,  let route = response.routes.first else { return  }
            
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            self.getRouteSteps(route: route)
            
        }
    
    }
    
    func getRouteSteps(route: MKRoute) {
        
        //Quita cualquier monitor de navegacion
        for moniteredRegion in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: moniteredRegion)
        }
    
        //agrega monitor de navegacion
        for (index, element) in route.steps.enumerated() {
            let region = CLCircularRegion(center: element.polyline.coordinate, radius: 20, identifier: "\(index)")
            locationManager.startMonitoring(for: region)
        }
        
        //Comandos de voz
        let synthesizer = AVSpeechSynthesizer()
        let instructionOne = route.steps[2]
        let spetch = AVSpeechUtterance(string: instructionOne.instructions)
        spetch.voice = AVSpeechSynthesisVoice(language: "es-MX")
        synthesizer.speak(spetch)
        
        //hace zoom para iniciar navagacion
        let rangeInMeters: Double = 100
        guard let currentLocation = locationManager.location else { return }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: rangeInMeters, longitudinalMeters: rangeInMeters)
        mapView.setRegion(region, animated: true)
        
    }
    
    
}

//MARK: MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        return renderer
    }
    
}
//MARK: SearchViewControllerDelegate
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




