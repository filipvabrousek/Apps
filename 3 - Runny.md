# Runny - v3

# View controller
```swift
import UIKit
import MapKit
import CoreLocation
import CoreData



// variable initializations
var LM = CLLocationManager()
var travelled:Double = 0
var AL = CLLocation(latitude: 0, longitude: 0)
var AL2  = CLLocationCoordinate2D(latitude: 0, longitude: 0)
let date = Date()
let formatter = DateFormatter()
let a = [Double: Double]()

// needed arrays
var activities: [Any] = []
var decodedRuns: [Run] = []




class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //outlets
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    //variables
    var timer = Timer()
    var sec = 0
    var minutes = 0
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    var distanceString = ""
    var secDuration = 0.0
    
    
    // arrays
    lazy var locations = [CLLocation]()
    var myLocations: [CLLocation] = []
    
    
    
    
    
    /*-----------------------------------------------------------VIEW DID LOAD---------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupManagerAndMap()
       // proccessCoreData()
    }
    
    func setupManagerAndMap(){
        
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        LM.startUpdatingLocation()
        
        travelled = 0
        secDuration = 0
    }
    
    
    /*-----------------------------------------------------------FINISH---------------------------------------------------------*/
    
    @IBAction func finishRun(_ sender: Any) {
        stopProccessing()
        getAndSaveData()
       
    }
    
    func stopProccessing(){
        LM.stopUpdatingLocation()
        timer.invalidate()
    }
    
    func getAndSaveData(){
        // data
        let dividedDistance = travelled / 1000
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        let distS = String(dividedDistance)
        let llat = AL.coordinate.latitude
        let llon = AL.coordinate.longitude
        let dur = Int(secDuration)
        
        // appending to activities - checking if we have some value
        
        if Double(dividedDistance) != 0.000000 && dur != 0{
            
            let run = Run(date: result, distance: distS, lat: llat, lon: llon, duration: dur)
            activities.append(run)
            
            
            
            
            //---------------------
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: activities)
            UserDefaults.standard.set(encodedData, forKey: "ACTIVITIES")
            UserDefaults.standard.synchronize()
            
            
            
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            let a = NSEntityDescription.insertNewObject(forEntityName: "Activities", into: context)
            
            //  let durr = Double(secDuration)
            
            a.setValue(result, forKey: "date")
            
            
            // CLLocationDegree to Double
            
            
            do {
                try context.save()
                print("Saved")
                
            }
                
            catch {
                print("There was an error")
            }
            
            
            
        }
    }
    
    
    /*-----------------------------------------------------------TIMER---------------------------------------------------------*/
    @objc func increaseTimer(){

        secDuration += 1
        updateTimerUI()
    }
    
    
    func updateTimerUI(){
        if sec < 60{
            sec += 1
            timerLabel.text = String(minutes) + ":" + String(sec)
            
            if sec < 10 && minutes < 10{
                timerLabel.text = String("0\(minutes):0\(sec)")
            }
            
        } else {
            sec = 0
            minutes += 1
            timerLabel.text = String(minutes) + ":" + String(sec)
            
        }
        
    }
    
    
  






```
    
    
 
## VC - UPDATE LOCATION
* 1 - Show location on the map
* 2 - add polyline
* 3 - update distance and save location to "locations" array

```swift
 
    /*-----------------------------------------------------------UPDATE LOCATION---------------------------------------------------------
     1 - Show location on the map
     2 - add polyline
     3 - update distance and save location to "locations" array
     */
    
    
    /*-----------------------------------------------------------UPDATE LOCATION---------------------------------------------------------
     1 - Show location on the map
     2 - add polyline
     3 - update distance and save location to "locations" array
     */
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //  1
        myLocations.append(locations[0])
        
        let location:CLLocation = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: span)
        self.map.setRegion(region, animated: true)
        
        
        //  2
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            self.map.add(polyline)
        }
        
        
        //3
        for location in locations {
            
            if location.horizontalAccuracy < 20 {
                //update distance
                if self.locations.count > 0 {
                    travelled += round(location.distance(from: AL))
                }
                
                distanceString = String(round(travelled) / 1000)
                self.distanceLabel.text = distanceString
                self.locations.append(location)
            }
        }
        
        AL = CLLocation(latitude: lat, longitude: lon)
        
    }
    
    
   


    

```
    
  ## VC - RENDERER 
 ```swift
   
     /*---------------------------------------------------------POLYLINE RENDERER-------------------------------------------------------*/
    
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
    
    
    
    
}
    
   
  
    
}
    
 ```
    
    
    




# History View Controller


```swift

import UIKit
import CoreData


var i = 0


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var progressLabel: UILabel!
    
    
    var total:Double = 0.0
    var progressVal = 0
    
    
    
    /*-----------------------------------------------------------TABLE VIEW---------------------------------------------------------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedRuns.count
       // print(decodedRuns.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        i = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActivityTableViewCell
        cell.updateUI()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        

        if editingStyle == UITableViewCellEditingStyle.delete{
            decodedRuns.remove(at: indexPath.row)
            activities.remove(at: indexPath.row)
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: activities)
            UserDefaults.standard.set(encodedData, forKey: "ACTIVITIES")
            UserDefaults.standard.synchronize()
        
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        performSegue(withIdentifier: "toActivityDetail", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel.alpha = 0
    }
    
    
    
    
    /*-----------------------------------------------------------VIEW DID APPEAR---------------------------------------------------------
     */
    override func viewDidAppear(_ animated: Bool) {
    
        proccessCoreData()
        updateProgress()
        
        let decoded = UserDefaults.standard.object(forKey: "ACTIVITIES") as! Data
        if let dec =  NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Run] {
            decodedRuns = dec
        }
        
        tableView.reloadData()
    }
    
    
    
    func proccessCoreData(){
        /*
        var e = [Run]()
        let r = Run(date: "2017", distance: "17", lat: 20, lon: 20, duration: 1200)
        e.append(r)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Activities")
        request.returnsObjectsAsFaults = false
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: e)
        
        do {
            let results = try context.fetch(request)
            
            if (results.count > 0){
                for result in results as! [NSManagedObject]{
                    if let dist = result.value(forKey: "activityArray") as? NSArray{
                        if let dec =  NSKeyedUnarchiver.unarchiveObject(with: encodedData) as? [Run] {
                            e = dec
                            print("F: \(dec[0].distance)")
                        }
                    }
                }
            }
        }
            
        catch {
            
        }
 */
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Activities")
        request.returnsObjectsAsFaults = false
        
        do {
        let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let date = res.value(forKey: "date"){
                        print(date)
                    }
                }
            }
        }
        
        catch {
            
        }
        
        
    }
    
    
    
    
    
    func updateProgress(){
        if let progress = UserDefaults.standard.value(forKey: "PROGRESS") as? Float{
            progressBar.setProgress(progress, animated: false) //between 0.0 (0) and 0.1 (100)
        }
        
        if let tempProgress = UserDefaults.standard.value(forKey: "PROGRESS") as? Int{
            progressVal = tempProgress
        }
        
        if (progressVal * 100) > 100{
            progressBar.progressTintColor = UIColor.green
            animateLabels()
        }
        
    }
    
    func animateLabels(){
        UIView.animate(withDuration: 1, animations: {
            self.goalLabel.alpha = 1
            self.goalLabel.isHighlighted = true
            self.progressLabel.alpha = 0
        })
    }
    
    
}



```




# Activity View Controller
* 1 - decode runs
* 2 - add date and distance
* 3 - display duration
* 4 - get pace
* 5 - dipsplay location on map
* 6 - get location title
* 7 - count total ran km's

```swift

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
    
    
    // variables - 3
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    
    
    @IBOutlet var paceLabel: UILabel!
    
    
    
    @IBOutlet var map: MKMapView!
    
    var total = 0.0
    
    
    
    
    
    
    /*-----------------------------------------------------------VIEW DID LOAD---------------------------------------------------------
     1 - decode runs
     2 - add date and distance
     3 - display duration
     4 - get pace
     5 - dipsplay location on map
     6 - get location title
     7 - count total ran km's
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  1
        let decoded = UserDefaults.standard.object(forKey: "ACTIVITIES") as! Data
        if let dec =  NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [Run] {
            decodedRuns = dec
        }
        
        updateUI()
        
    }
    
    
    
    
    func updateUI(){
        //  2
        dateLabel.text = String(decodedRuns[i].date)
        distanceLabel.text = decodedRuns[i].distance
        
        //  3
        let sec  = decodedRuns[i].duration
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        durationLabel.text = String(time)
        
        // 4
        let paceObj = Pace(seconds: sec, minutes: sec / 60, distance: Double(decodedRuns[i].distance)!)
        paceLabel.text = paceObj.createPace
        
        // 5
        updateMap()
        updateAndSaveProgress()
    }
    
    
    
    
    func updateAndSaveProgress(){
        total = total + Double(decodedRuns[i].distance)!
        
        let progressTotal = Float(total / 100) //1 km will be 0.01 :  10 will be 0.1
        var deserveReward = false
        
        
        if progressTotal == 1 {
            deserveReward = true
        }
        
        UserDefaults.standard.set(progressTotal, forKey: "PROGRESS")
        UserDefaults.standard.set(deserveReward, forKey: "REWARD")
    }
    
    
    
    
    func updateMap(){
        
        let deg1 = CLLocationDegrees(decodedRuns[i].lat)
        let deg2 = CLLocationDegrees(decodedRuns[i].lon)
        let loc = CLLocationCoordinate2D(latitude: deg1, longitude: deg2)
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: loc, span: span)
        self.map.setRegion(region, animated: true)
        
        let geoLoc = CLLocation(latitude: deg1, longitude: deg2)
        
        var title = ""
        
        CLGeocoder().reverseGeocodeLocation(geoLoc , completionHandler: { (placemarks, error) in
            
            if error != nil {
                // print(error ?? "Something went wrong")
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
            
            
            if title == "" {
                title = "Unknown adress"
            }
            
            
            self.locationLabel.text = title
        });
    }
    
    
    /*--------------------------------------SHARE--------------------------------------*/
    @IBAction func share(_ sender: Any) {
        
        let item = "I ran \(decodedRuns[i].distance) km with app Runny"
        let share = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
       
}

```

# ActivityTableViewCell

```swift
//
//  ActivityTableViewCell.swift
//  Runny
//
//  Created by Filip Vabroušek on 25.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateUI(){
        self.dateLabel.text = decodedRuns[i].date
        self.distanceLabel.text = decodedRuns[i].distance
        self.durationLabel.text = String(decodedRuns[i].duration)
        self.imgView.image = UIImage(named: "runner.jpg")
    }
    
    
}


```

# Run.swift

```swift

import Foundation

class Run: NSObject, NSCoding {
    
    
    // HAS TO BE A STRING !!
    struct Keys {
      
        static let date = "date"
        static let distance = "distance"
        static let lat = "lat"
        static let lon = "lon"
        static let duration = "duration" // in seconds

    }
    
    
   
    
    private var _date = ""
    private var _distance = ""
    private var _lat = 0.0
    private var _lon = 0.0
    private var _duration = 0 // in seconds

    
    
    override init() {}
    
   
    /*---------------------------------------------------------------------------------------------------------*/
    init(date: String, distance: String, lat:Double, lon:Double, duration: Int) {
        
        self._date = date
        self._distance = distance
        self._lat = lat
        self._lon = lon
        self._duration = duration
       
    }
    

    
    required init(coder aDecoder:NSCoder){
        
        if let dataObject = aDecoder.decodeObject(forKey: Keys.date) as? String{
            _date = dataObject
        }
        
        if let dataObject2 = aDecoder.decodeObject(forKey: Keys.distance) as? String {
            _distance = dataObject2
        }
        
        if let latObject = aDecoder.decodeDouble(forKey: Keys.lat) as? Double {
            _lat = latObject
        }
        
        if let lonObject = aDecoder.decodeDouble(forKey: Keys.lon) as? Double{
            _lon = lonObject
        }
        
        if let durationObject = aDecoder.decodeInteger(forKey: Keys.duration) as? Int{
        _duration = durationObject
        }
    }
    
    
    
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(_date, forKey: Keys.date)
        aCoder.encode(_distance, forKey: Keys.distance)
        aCoder.encode(_lat, forKey: Keys.lat)
        aCoder.encode(_lon, forKey: Keys.lon)
        aCoder.encode(_duration, forKey: Keys.duration)
    }
    
    
    var date: String {
        get {
        return _date
        }
        
        set{
        _date = newValue
        }
    }
    
    var distance: String {
        get {
            return _distance
        }
        
        set {
            _distance = newValue
        }
    }

   
    var lat: Double{
        get{
        return _lat
        }
        
        set{
        _lat = newValue
        }
    }
    
    
    var lon: Double{
        get{
            return _lon
        }
        
        set{
            _lon = newValue
        }
    }
    
    var duration: Int {
        get {
        return _duration
        }
        
        set{
        _duration = newValue
        }
    }

    
}




```



# colorline.swift
* 1 - create a gradient
* 2 - define path properties
* 3 - replace path with stroked version, so we can clip
* 4 - create bounding box
* 5 - draw gradient in the clipped context of the path

```swift
 
 import MapKit
 
 class ColorLine: MKOverlayPathRenderer {
    
    // variables - 5
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
        
        
        //  variables 
        let baseWidth: CGFloat = self.lineWidth / zoomScale
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let stopValues = calculateNumberOfStops()
        let locations:[CGFloat] = stopValues
        let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)
        
        
        if self.border{
            context.setLineWidth(baseWidth * 2)
            context.setLineJoin(CGLineJoin.round)
            context.setLineCap(CGLineCap.round)
            context.addPath(self.path)
            context.setStrokeColor(self.borderColor?.cgColor ?? UIColor.white.cgColor)
            context.strokePath()
        }
        
        
        //  2
        context.setLineWidth(baseWidth)
        context.setLineJoin(CGLineJoin.round)
        context.setLineCap(CGLineCap.round)
        context.addPath(self.path)
        
        
        //  3
        context.saveGState()
        context.replacePathWithStrokedPath()
        context.clip()
        
        //  4
        let boundingBox = self.path.boundingBoxOfPath
        let gradientStart = boundingBox.origin
        let gradientEnd = CGPoint(x: boundingBox.maxX, y: boundingBox.maxY)
        
        // 5
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
    
    
    
    /*-------------------------------------------------------CALCULATE NUMBER OF STOPS------------------------------------------------------*/
    fileprivate func calculateNumberOfStops() -> [CGFloat]{
        let stopDifference = (1 / Double(cgColors.count))
        
        return Array(stride(from: 0, to: 1+stopDifference, by: stopDifference))
            .map { (value) -> CGFloat in
                return CGFloat(value)
        }
        
    }
    
 }
 

```
