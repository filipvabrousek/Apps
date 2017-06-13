//
//  ViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 13.01.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

var LM = CLLocationManager()
var traveledDistance:Double = 0
var distancesArray: [String] = []

//locationArrays
var locationArray:[String] = []
var locationArray2:[Double] = [] //lat
var locationArray3:[Double] = [] //lon
//AL, A
var AL = CLLocation(latitude: 0, longitude: 0)

let date = Date()
let formatter = DateFormatter()
var dateArray:[String] = []


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //outlets - 4
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    //variables - 5
    var timer = Timer()
    var sec = 0
    var minutes = 0
    lazy var locations = [CLLocation]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyBest
        LM.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        map.mapType = MKMapType.standard
        map.delegate = self
    }
    
    
    
    
    /*-----------------------------------------------------------START---------------------------------------------------------*/
    @IBAction func startRun(_ sender: Any) {
        startBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.increaseTimer), userInfo: nil, repeats: true)
        LM.startUpdatingLocation()
        //reset distance
        traveledDistance = 0
    }
    
    
    /*-----------------------------------------------------------FINISH---------------------------------------------------------*/
    @IBAction func finishRun(_ sender: Any) {
        LM.stopUpdatingLocation()
        timer.invalidate()
        
        let dividedDistance = traveledDistance / 1000
        
        if dividedDistance > 0 {
            distancesArray.append(String(dividedDistance))
        }
        print("Finish")
        UserDefaults.standard.set(distancesArray, forKey: "DISTANCE")
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        dateArray.append(result)
        UserDefaults.standard.set(dateArray, forKey: "DATE")
        
    }
    
    
    /*-----------------------------------------------------------TIMER---------------------------------------------------------*/
    func increaseTimer(){
        
        if sec < 60{
            sec += 1
            timerLabel.text = String(minutes) + ":" + String(sec)
            
        } else {
            sec = 0
            
            minutes += 1
            timerLabel.text = String(minutes) + ":" + String(sec)
            
        }
        
    }
    
    
    
    
    /*-----------------------------------------------------------UPDATE LOCATION---------------------------------------------------------*/
    
    
    //variables - 4
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    var distanceString = ""
    var locationCoord = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var myLocations: [CLLocation] = []
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myLocations.append(locations[0])
        
        let location:CLLocation = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        locationCoord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: span)
        self.map.setRegion(region, animated: true)
        
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            self.map.add(polyline)
        }
        
        //   MEASURE DISTANCE
        
        for location in locations {
            if location.horizontalAccuracy < 20 {
                
                //update distance
                if self.locations.count > 0 {
                    traveledDistance += round(location.distance(from: AL))
                }
                distanceString = String(round(traveledDistance) / 1000)
                self.distanceLabel.text = distanceString
                //save location
                self.locations.append(location)
            }
        }
        
        AL = CLLocation(latitude: lat, longitude: lon)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            let gradientColors = [UIColor.green, UIColor.blue, UIColor.yellow, UIColor.red]
            let polylineRenderer = ColorLine(polyline: overlay as! MKPolyline, colors: gradientColors)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}










//
//  HistoryViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 15.01.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//
import UIKit
import CoreData


var i = 0


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    var total:Double = 0.0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distancesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String(describing: distancesArray[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            distancesArray.remove(at: indexPath.row)
            tableView.reloadData()
            UserDefaults.standard.set(distancesArray, forKey: "DISTANCE")
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        
        performSegue(withIdentifier: "toActivityDetail", sender: nil)
    }
    
    /*                                                                           COUNT TOTAL                                                      */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "DISTANCE")
        
        
        if let tempItems = itemsObject as? [String] {
            distancesArray = tempItems
        }
        
        
        tableView.reloadData()
        
        for dist in distancesArray{
            total += Double(dist)!
        }
        
        totalLabel.text = String(total)
        //print("Total \(total)")
        
        var progressTotal = Float(total / 100) //1 km will be 0.01 :  10 will be 0.1
        UserDefaults.standard.set(progressTotal, forKey: "PROGRESS")
        
        let progress = UserDefaults.standard.value(forKey: "PROGRESS")
        progressBar.setProgress(progress as! Float, animated: true) //between 0.0 (0) and 0.1 (100)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}













//
//  ActivityViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 21.01.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation



class ActivityViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemsObject = UserDefaults.standard.object(forKey: "DISTANCE")
        
        if let tempItems = itemsObject as? [String] {
            distancesArray = tempItems
        }
        
        let itemsObject1 = UserDefaults.standard.object(forKey: "DATE")
        
        if let tempItems = itemsObject1 as? [String] {
            dateArray = tempItems
        }
        
        distanceLabel.text = distancesArray[i]
        getAdress()
        
        dateLabel.text = dateArray[i]
        
        
    }
    
    
    func getAdress(){
        CLGeocoder().reverseGeocodeLocation(AL, completionHandler: { (placemarks, error) in
            
            var title = ""
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
            
            locationArray.append(title)
            self.locationLabel.text = locationArray[i]
        });
        
    }
    
}










 //  Created by Joel Trew on 24/04/2016.
 
 import MapKit
 
 class ColorLine: MKOverlayPathRenderer {
    
    var polyline : MKPolyline
    var colors:[UIColor]
    
    var border: Bool = false
    var borderColor: UIColor?
    
    
    fileprivate var cgColors:[CGColor]{
        return colors.map({(color) -> CGColor in
            return color.cgColor
        })
        
    }
    
    init(polyline:MKPolyline, colors: [UIColor]){
        self.polyline = polyline
        self.colors = colors
        super.init(overlay:polyline)
    }
    
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        
        //      set relative path width
        
        let baseWidth: CGFloat = self.lineWidth / zoomScale
        
        if self.border{
            context.setLineWidth(baseWidth * 2)
            context.setLineJoin(CGLineJoin.round)
            context.setLineCap(CGLineCap.round)
            context.addPath(self.path)
            context.setStrokeColor(self.borderColor?.cgColor ?? UIColor.white.cgColor)
            context.strokePath()
        }
        
        //      create a gradient
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //Call "calculateNumberOfStops"
        let stopValues = calculateNumberOfStops()
        let locations:[CGFloat] = stopValues
        let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)
        
        //     define path properties
        context.setLineWidth(baseWidth)
        context.setLineJoin(CGLineJoin.round)
        context.setLineCap(CGLineCap.round)
        context.addPath(self.path)
        
        
        //      Replace path with stroked version so we can clip
        context.saveGState()
        context.replacePathWithStrokedPath()
        context.clip()
        
        
        //      create boundind box
        let boundingBox = self.path.boundingBoxOfPath
        let gradientStart = boundingBox.origin
        let gradientEnd = CGPoint(x: boundingBox.maxX, y: boundingBox.maxY)
        
        // draw gradient in the clipped context of the path
        if let gradient = gradient {
            context.drawLinearGradient(gradient, start: gradientStart, end: gradientEnd, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        }
        
        context.restoreGState()
        super.draw(mapRect, zoomScale: zoomScale, in: context)
    }
    
    /*-------------------------------------------------------CREATE PATH FROM POLYLINE------------------------------------------------------*/
    
    override func createPath() {
        let path: CGMutablePath = CGMutablePath()
        var pathIsEmpty:Bool = true
        
        for i in 0...self.polyline.pointCount - 1{
            
            let point:CGPoint = self.point(for: self.polyline.points()[i])
            if pathIsEmpty{
                path.move(to: point)
                pathIsEmpty = false
            } else {
                path.addLine(to: point)
            }
        }
        self.path = path
    }
    
    fileprivate func calculateNumberOfStops() -> [CGFloat]{
        let stopDifference = (1 / Double(cgColors.count))
        
        return Array(stride(from: 0, to: 1+stopDifference, by: stopDifference))
            .map { (value) -> CGFloat in
                return CGFloat(value)
        }
        
    }
    
 }
 
