import UIKit
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet var userSignupSwitch: UISwitch!
    
    var signUpMode = true
    
    
    /*                                              DISPLAY ALERT                           */
    func displayAlert(title: String, message: String) {
        
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertcontroller, animated: true, completion: nil)
        
    }

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var signupOrLoginButton: UIButton!
    
    
       /*                                              SIGN UP OR LOGIN                           */
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Error in form", message: "Username and password are required")
            
        } else {
            
            if signUpMode {
                
                let user = PFUser()
                
                user.username = usernameTextField.text
                user.password = passwordTextField.text
                
                
                user["isDriver"] = userSignupSwitch.isOn
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if let error = error {
                        
                        var displayedErrorMessage = "Please try again later"
                        
                        let error = error as NSError
                        
                        if let parseError = error.userInfo["error"] as? String {
                            
                            displayedErrorMessage = parseError
                            
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Sign Up Successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            
                            if isDriver {
                                
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                                
                                
                            } else {
                                
                                
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    
                })
                
            } else {
                
                PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    if let error = error {
                        
                        var displayedErrorMessage = "Please try again later"
                        
                        let error = error as NSError
                        
                        if let parseError = error.userInfo["error"] as? String {
                            
                            displayedErrorMessage = parseError
                            
                            
                        }
                        
                        self.displayAlert(title: "Sign Up Failed", message: displayedErrorMessage)
                        
                    } else {
                        
                        print("Log In Successful")
                        
                        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
                            
                            if isDriver {
                                
                                self.performSegue(withIdentifier: "showDriverViewController", sender: self)
                                
                            } else {
                                
                                
                                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                                
                            }
                            
                            
                            
                        }

                        
                    }
                    
                    
                })
                
            }
            
        }
        

        
    }
    @IBOutlet var signupSwitchButton: UIButton!
    
    @IBOutlet var driverLabel: UILabel!
    @IBOutlet var riderLabel: UILabel!
    @IBAction func switchSignupMode(_ sender: AnyObject) {
        
        
        if signUpMode {
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            signupSwitchButton.setTitle("Switch To Sign Up", for: [])
            
            signUpMode = false
            
            userSignupSwitch.isHidden = true
            
            riderLabel.isHidden = true
            
            driverLabel.isHidden = true
            
            
        } else {
            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            signupSwitchButton.setTitle("Switch To Log In", for: [])
            
            signUpMode = true
            
            userSignupSwitch.isHidden = false
            
            riderLabel.isHidden = false
            
            driverLabel.isHidden = false
            
        }
        
    }
    
    
    

    override func viewDidAppear(_ animated: Bool) {
        
        if let isDriver = PFUser.current()?["isDriver"] as? Bool {
            
            if isDriver {
            performSegue(withIdentifier: "showDriverViewController", sender: self)
            } else {
         
                self.performSegue(withIdentifier: "showRiderViewController", sender: self)
                
            }
            
            
            
        }

        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}













//
//  RiderLocationViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 11/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderLocationViewController: UIViewController, MKMapViewDelegate {

    var requestLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var requestUsername = ""
    
    @IBOutlet var map: MKMapView!
    
    
       /*                                              ACCEPT REQUEST                       */
    @IBAction func acceptRequest(_ sender: AnyObject) {
        
        let query = PFQuery(className: "RiderRequest")
        
        query.whereKey("username", equalTo: requestUsername)
        
        query.findObjectsInBackground { (objects, error) in
            
            if let riderRequests = objects {
                
                for riderRequest in riderRequests {
                    
                    riderRequest["driverResponded"] = PFUser.current()?.username
                    
                    riderRequest.saveInBackground()
                    
                    let requestCLLocation = CLLocation(latitude: self.requestLocation.latitude, longitude: self.requestLocation.longitude)
                    
                    CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: { (placemarks, error) in
                        
                        if let placemarks = placemarks {
                            
                            if placemarks.count > 0 {
                                
                               let mKPlacemark = MKPlacemark(placemark: placemarks[0])
                                
                                let mapItem = MKMapItem(placemark: mKPlacemark)
                                
                                mapItem.name = self.requestUsername
                                
                                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                                
                                mapItem.openInMaps(launchOptions: launchOptions)
                                
                            }
                            
                        }
                        
                        
                    })
                    
                }
                
            }
            
            
        }
        
    }
    
    
    @IBOutlet var acceptRequestButton: UIButton!
    
    
    
       /*                                              SET MAP                          */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = requestLocation
        
        annotation.title = requestUsername
        
        map.addAnnotation(annotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}









//
//  DriverViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 11/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class DriverViewController: UITableViewController, CLLocationManagerDelegate {
    
    var LM = CLLocationManager()
    
    var requestUsernames = [String]()
    var requestLocations = [CLLocationCoordinate2D]()
    
    var userLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    
    
       /*                                            PREPARE FOR SEGUE                         */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "driverLogoutSegue" {
            LM.stopUpdatingLocation()
            PFUser.logOut()
            self.navigationController?.navigationBar.isHidden = true
            
        } else if segue.identifier == "showRiderLocationViewController" {
            
            if let destination = segue.destination as? RiderLocationViewController { // segue.destinationViewController  is now segue.destination
                
                if let row = tableView.indexPathForSelectedRow?.row {
                    destination.requestLocation = requestLocations[row]
                    destination.requestUsername = requestUsernames[row]
                }
                
                
            }
            
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyBest
        LM.requestWhenInUseAuthorization()
        LM.startUpdatingLocation()
        
    }
    
    
    /*                                              DID UPADTE LOCATIONS                        */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = manager.location?.coordinate {
            
            let driverLocationQuery = PFQuery(className: "Driver location")
            driverLocationQuery.whereKey("username", equalTo: PFUser.current()?.username)
            driverLocationQuery.findObjectsInBackground(block: { (objects, error) in
                
                if let driverLocations = objects{
                    for driverLocation in driverLocations {
                    driverLocation["location"] = PFGeoPoint(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                    driverLocation.deleteInBackground()
                      
                        }  
                }
                
                let driverLocation = PFObject(className: "DriverLocation")
                driverLocation["username"] = PFUser.current()?.username
                driverLocation["location"] = PFGeoPoint(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                driverLocation.saveInBackground()
                
            })
            
            
            let query = PFQuery(className: "RiderRequest")
            
            userLocation = location
            
            query.whereKey("location", nearGeoPoint: PFGeoPoint(latitude: location.latitude, longitude: location.longitude))
            
            query.limit = 10
            
            
            //--FIND OBJECTS IN BACKGROUND
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    self.requestUsernames.removeAll()
                    self.requestLocations.removeAll()
                    
                    for riderRequest in riderRequests {
                        
                        if let username = riderRequest["username"] as? String {
                            
                            if riderRequest["driverResponded"] == nil {
                        
                                self.requestUsernames.append(username)
                            
                                self.requestLocations.append(CLLocationCoordinate2D(latitude: (riderRequest["location"] as AnyObject).latitude, longitude: (riderRequest["location"] as AnyObject).longitude))
                            
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                
            })
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    

    //COUNT SECTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
               return 1
    }

      //COUNT EM ALL
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return requestUsernames.count
    }

    
    /*                                              FILL IN CELLS AND COUNT DISTANCES                                   */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Find distance between userLocation requestLocations[indexPath.row]
        let driverCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let riderCLLocation = CLLocation(latitude: requestLocations[indexPath.row].latitude, longitude: requestLocations[indexPath.row].longitude)
        
        let distance = driverCLLocation.distance(from: riderCLLocation) / 1000
        let roundedDistance = round(distance * 100) / 100

        cell.textLabel?.text = requestUsernames[indexPath.row] + " - \(roundedDistance)km away"

        return cell
    }
    

   
}









//
//  RiderViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Rob Percival on 11/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class RiderViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    /*                                          DISPLAY ALERT                                   */
    func displayAlert(title: String, message: String) {
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertcontroller, animated: true, completion: nil)
    }
    
    var driverOnTheWay = false
    var locationManager = CLLocationManager()
    var riderRequestActive = true
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    @IBOutlet var map: MKMapView!
    
    
    
    
    /*                                              CALL AN UBER                          */
    
    @IBAction func callAnUber(_ sender: AnyObject) {
        
        if riderRequestActive {
            
            callAnUberButton.setTitle("Call An Uber", for: [])
            
            riderRequestActive = false
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    for riderRequest in riderRequests {
                        
                        riderRequest.deleteInBackground()
                        
                    }
                    
                }
                
                
            })
            
        } else {
            
            if userLocation.latitude != 0 && userLocation.longitude != 0 {
                
                riderRequestActive = true
                
                self.callAnUberButton.setTitle("Cancel Uber", for: [])
                
                let riderRequest = PFObject(className: "RiderRequest")
                
                riderRequest["username"] = PFUser.current()?.username
                
                riderRequest["location"] = PFGeoPoint(latitude: userLocation.latitude, longitude: userLocation.longitude)
                
                riderRequest.saveInBackground(block: { (success, error) in
                    
                    if success {
                        
                        print("Called an uber")
                        
                        
                    } else {
                        
                        self.callAnUberButton.setTitle("Call An Uber", for: [])
                        
                        self.riderRequestActive = false
                        
                        self.displayAlert(title: "Could not call Uber", message: "Please try again!")
                        
                    }
                    
                    
                })
                
            } else {
                
                displayAlert(title: "Could not call Uber", message: "Cannot detect your location.")
                
            }
            
        }
        
    }
    
    
    
    
    @IBOutlet var callAnUberButton: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logoutSegue" {
            
            locationManager.stopUpdatingLocation()
            
            PFUser.logOut()
            
        }
        
    }
    
    /*                                              SETUP LOCATION MANAGER                          */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        callAnUberButton.isHidden = true
        
        let query = PFQuery(className: "RiderRequest")
        
        query.whereKey("username", equalTo: (PFUser.current()?.username)!)
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let objects = objects {
                
                if objects.count > 0 {
                    
                    self.riderRequestActive = true
                    
                    self.callAnUberButton.setTitle("Cancel Uber", for: [])
                    
                }
                
            }
            
            self.callAnUberButton.isHidden = false
            
            
        })
        
        
    }
    
    
    /*                                            SETUP MAP                       */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = manager.location?.coordinate {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            
            if driverOnTheWay == false {
                
                let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                
                self.map.removeAnnotation(self.map.annotations as! MKAnnotation)
                
                self.map.setRegion(region, animated: true)
                
                self.map.removeAnnotations(self.map.annotations)
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = userLocation
                
                annotation.title = "Your Location"
                
                self.map.addAnnotation(annotation)
            }
            
            let query = PFQuery(className: "RiderRequest")
            
            query.whereKey("username", equalTo: (PFUser.current()?.username)!)
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects {
                    
                    for riderRequest in riderRequests {
                        
                        riderRequest["location"] = PFGeoPoint(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                        
                        riderRequest.saveInBackground()
                        
                    }
                    
                }
                
                
            })
            
            
            
        }
        
        
        // HANDLE REQUESTS
        if riderRequestActive == true {
            
            let query = PFQuery(className: "Rider request")
            query.whereKey("username", equalTo: PFUser.current()?.username!)
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let riderRequests = objects{
                    
                    for riderRequest in riderRequests{
                        if let driverUsername = riderRequest["driverResponded"]{
                            
                            let query = PFQuery(className: "DriverLocation")
                            query.whereKey("username", equalTo: driverUsername)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let driverLocations = objects{
                                    
                                    for DLO in driverLocations{
                                        if let driverLocation = DLO["location"] as? PFGeoPoint{
                                            
                                            self.driverOnTheWay = true
                                            let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                                            let riderCLLocation = CLLocation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
                                            let distance = riderCLLocation.distance(from: driverCLLocation) / 1000 //in km
                                            let roundedDistance = round(distance * 100) / 100
                                            
                                            self.callAnUberButton.setTitle("Your driver is \(roundedDistance)km away", for: [])
                                            
                                            let latDelta = abs(driverLocation.latitude - self.userLocation.latitude) * 2 + 0.05
                                            let lonDelta = abs(driverLocation.latitude - self.userLocation.latitude) * 2 + 0.05
                                            
                                            let region = MKCoordinateRegion(center: self.userLocation, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
                                            self.map.setRegion(region, animated: true)
                                            //User Location Annotation
                                            let ULA = MKPointAnnotation()
                                            ULA.coordinate = self.userLocation
                                            ULA.title = "Your location"
                                            self.map.addAnnotation(ULA)
                                            
                                            //driver location annotation
                                            let DLA = MKPointAnnotation()
                                            DLA.coordinate = CLLocationCoordinate2D(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                                            DLA.title = "Your driver"
                                            self.map.addAnnotation(DLA)
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                            })
                        }
                        
                        
                    }
                    
                }
                
            })
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
