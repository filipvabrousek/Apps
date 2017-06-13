//
//  ViewController.swift
//  FindingUserLocation
//
//  Created by Filip Vabroušek on 27.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    
    /*                                          Set up Location Manager                             */
    var LM = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyBest
        LM.requestWhenInUseAuthorization()
        LM.startUpdatingLocation()
    }
    
    /*                                          Get user Location()             */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

