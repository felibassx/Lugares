//
//  MapViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 8/7/17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var place = Place()
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ledecimos que la propia clase será el delegado
        self.mapView.delegate = self
        
        //configuracion del mapa
        self.mapView.showsTraffic = true
        self.mapView.showsScale = true
        self.mapView.showsCompass = true

        print(place.name)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(place.location) {[unowned self] (placemarks, error) in
            if error == nil{
                //procesar lugares
                for placemark in placemarks!{
                    let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.subtitle = self.place.type
                    annotation.coordinate = (placemark.location?.coordinate)!
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
            }else{
            
                print("Ha habido un error: \(String(describing: error?.localizedDescription))")
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//extension para personalizar el pincho del mapa
extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //definir identificador para cada pincho
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        //creo el imageview
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        imageView.image = UIImage(data: self.place.image! as Data)
        
        //añado la imagen a la izquierda
        annotationView?.leftCalloutAccessoryView = imageView
        
        //cambiamos el color del pin
        annotationView?.pinTintColor = UIColor.green
        
        return annotationView
        
    }
}




