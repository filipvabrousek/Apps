//
//  PlacesViewController.swift
//  Memorable Places
//
//  Created by Rob Percival on 21/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1

class PlacesViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    /*                                          SHOW DEFAULT LOCATION (using CoreData)                          */
    
    override func viewDidAppear(_ animated: Bool){
        if let tempPlaces =  UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>]{
            places = tempPlaces
            
        }
        
        if places.count == 1 && places[0].count == 0 {
            places.remove(at: 0)
            places.append(["name":"Taj Mahal", "lat":"27.175277", "lon":"78.042128"])
            UserDefaults.standard.set(places, forKey: "places")
        }
        activePlace = -1
        table.reloadData()
    }
    
    
    /*                                              CAN EDIT FUNCTION                           */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    /*                                              DELETE A ROW                                        */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            places.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*                                              NUMBER OF SECTIONS AND ROWS                                 */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    /*                                                      FILL - IN CELLS                                         */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        if places[indexPath.row]["name"] != nil{
            cell.textLabel?.text = places[indexPath.row]["name"]
        }
        
        return cell
    }
    
    /*                                                  PERFORM SEGUE                                */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        performSegue(withIdentifier: "toMap", sender: nil)
    }
    
    
    
}










//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by Filip Vabroušek on 28.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var map: MKMapView!
    
    var LM = CLLocationManager()
    
    
    /*                             GET THE DETAILS OF THE PLACE             */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        if activePlace == -1 {
            LM.delegate = self
            LM.desiredAccuracy = kCLLocationAccuracyBest
            LM.requestWhenInUseAuthorization()
            LM.startUpdatingLocation()
            
        } else {
            
            //get the details
            if places.count > activePlace {
                
                if let name = places[activePlace]["name"]{
                    if let lat = places[activePlace]["lat"]{
                        if let lon = places[activePlace]["lon"]{
                            if let latitude = Double(lat){
                                if let longitude = Double(lon){
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
        }
        
        
        print(activePlace)
    }
    
    
    
    /*                                             LONG PRESS()                             */
    func longpress(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                if error != nil {
                    print(error)
                } else {
                    
                    if let placemark = placemarks?[0]{
                        if placemark.subThoroughfare != nil{
                            title += placemark.subThoroughfare! + " "
                            
                        }
                        
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare!
                        }
                    }
                }
                
                if title == ""{
                    title = "Added \(NSDate())"
                }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinate
                annotation.title = title
                self.map.addAnnotation(annotation)
                
                places.append(["name":title, "lat": String(newCoordinate.latitude), "lon": String(newCoordinate.longitude)])
            });
            
            
        }
    }
    
    
    /*                                             LM() - SET THE MAP                             */

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: locations, span: span)
        
        self.map.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


