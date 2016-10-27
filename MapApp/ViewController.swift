//
//  ViewController.swift
//  MapApp
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var buttonStart: UIButton!
    @IBOutlet var buttonStop: UIButton!
    @IBOutlet var buttonClear: UIButton!
    @IBOutlet var mapView: MKMapView!

    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStop.enabled = false;
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    @IBAction func buttonStartClicked(sender: UIButton) {
        buttonStart.enabled = false
        buttonStop.enabled = true
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    @IBAction func buttonStopClicked(sender: UIButton) {
        buttonStart.enabled = true
        buttonStop.enabled = false
        locationManager.stopUpdatingLocation()
        mapView.showsUserLocation = false
    }
    
    @IBAction func buttonClearClicked(sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last?.coordinate
        
        let marker = MKPointAnnotation()
        
        marker.coordinate = currentLocation!
        mapView.addAnnotation(marker)
        
        var spanDelta = 0.0
        
        if let speed = locations.last?.speed where speed > 0 {
            spanDelta = (locations.last?.speed)! / 5000
        }
        
        let locationArea = MKCoordinateRegion(center: currentLocation!, span: MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
        mapView.setRegion(locationArea, animated: true)
    }
}

