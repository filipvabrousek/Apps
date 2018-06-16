//
//  Run.swift
//  Runny
//
//  Created by Filip Vabroušek on 09.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import Foundation
import MapKit

/*------------------------------------------------------RUN---------------------------------------------------------------*/
class Run: NSObject, NSCoding {
    
    
    // HAS TO BE A STRING !!
    struct Keys {
        
        static let date = "date"
        static let distance = "distance"
        static let location = "location"
        static let weather = "weather"
        static let lat = "lat"
        static let lon = "lon"
        static let duration = "duration" // in seconds
        static let latPoints = "latPoints"
        static let lonPoints = "lonPoints"
        static let laps = "laps"
     
        
    }
    
    
    
    
    private var _date = ""
    private var _distance = ""
    private var _location = ""
    private var _weather = ""
    private var _lat = 0.0
    private var _lon = 0.0
    private var _duration = 0 // in seconds
    private var _latPoints = [Double]()
    private var _lonPoints = [Double]()
    private var _laps = [Int]()
    
    override init() {}
    
    
    /*---------------------------------------------------------------------------------------------------------*/
    init(date: String, distance: String, location:String, weather: String, lat:Double, lon:Double, duration: Int, laps:[Int], latPoints:[Double], lonPoints:[Double]) {
        
        self._date = date
        self._distance = distance
        self._location = location
        self._weather = weather
        self._lat = lat
        self._lon = lon
        self._duration = duration
        self._laps = laps
        self._lonPoints = lonPoints
        self._latPoints = latPoints
   
        
    }
    
    
    
    required init(coder aDecoder:NSCoder){
        
        if let DO = aDecoder.decodeObject(forKey: Keys.date) as? String{
            _date = DO
        }
        
        if let DO2 = aDecoder.decodeObject(forKey: Keys.distance) as? String {
            _distance = DO2
        }
        
        
        
        if let LOS = aDecoder.decodeObject(forKey: Keys.location) as? String {
            _location = LOS
        }
        
        
        if let WEA = aDecoder.decodeObject(forKey: Keys.weather) as? String {
            _weather = WEA
        }
        
        
        if let LAO = aDecoder.decodeDouble(forKey: Keys.lat) as? Double {
            _lat = LAO
        }
        
        if let LOO = aDecoder.decodeDouble(forKey: Keys.lon) as? Double {
            _lon = LOO
        }
        
        if let DO = aDecoder.decodeInteger(forKey: Keys.duration) as? Int  {
            _duration = DO
        }
        
        if let LAPS = aDecoder.decodeObject(forKey: Keys.laps) as? [Int] {
            _laps = LAPS
        }
        
        if let LATP = aDecoder.decodeObject(forKey: Keys.latPoints) as? [Double]{
            _latPoints = LATP
        }
        
        if let LONP = aDecoder.decodeObject(forKey: Keys.lonPoints) as? [Double]{
            _lonPoints = LONP
        }
        
     
    }
    
    
    
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(_date, forKey: Keys.date)
        aCoder.encode(_distance, forKey: Keys.distance)
        aCoder.encode(_location, forKey: Keys.location)
        aCoder.encode(_weather, forKey: Keys.weather)
        aCoder.encode(_lat, forKey: Keys.lat)
        aCoder.encode(_lon, forKey: Keys.lon)
        aCoder.encode(_duration, forKey: Keys.duration)
        aCoder.encode(_laps, forKey: Keys.laps)
        aCoder.encode(_latPoints, forKey: Keys.latPoints)
        aCoder.encode(_lonPoints, forKey: Keys.lonPoints)
        
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
    
    var location: String {
        get {
            return _location
        }
        
        set{
            _location = newValue
        }
    }
    
    
    var weather: String {
        get {
            return _weather
        }
        
        set{
            _weather = newValue
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
   
    
    var laps:[Int]{
        get{
            return _laps
            
        }
        
        set{
            _laps = newValue
        }
    }
    
    var latPoints:[Double]{
        get{
            return _latPoints
            
        }
        
        set{
           _latPoints = newValue
        }
    }
    
    
    var lonPoints:[Double]{
        get{
            return _lonPoints
            
        }
        
        set{
            _lonPoints = newValue
        }
    }
    
    
  
}






class User: NSObject, NSCoding{
    struct Keys {
        static let name = "name"
        static let birth = "birth"
        static let gender = "gender"
    }
    
    
    private var _name = ""
    private var _birth = ""
    private var _gender = ""
    
    override init() {}
    
    init(name: String, birth:String, gender: String){
        self._name = name
        self._birth = birth
        self._gender = gender
    }
    
    
    
    required init(coder aDecoder:NSCoder){
        
        if let nameObject = aDecoder.decodeObject(forKey: Keys.name) as? String{
            _name = nameObject
        }
        
        if let birthObject = aDecoder.decodeObject(forKey: Keys.birth) as? String{
            _birth = birthObject
        }
        
        if let genderObject = aDecoder.decodeObject(forKey: Keys.gender) as? String{
            _gender = genderObject
        }
        
    }
    
    
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: Keys.name)
        aCoder.encode(_birth, forKey: Keys.birth)
        aCoder.encode(_gender, forKey: Keys.gender)
    }
    
    
    var name: String {
        get {
            return _name
        }
        
        set{
            _name = newValue
        }
    }
    
    var birth: String {
        get {
            return _birth
        }
        
        set{
            _birth = newValue
        }
    }
    
    
    var gender: String {
        get {
            return _gender
        }
        
        set{
            _gender = newValue
        }
    }
}










//
//  Other.swift
//  Runny
//
//  Created by Filip Vabroušek on 01.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import Foundation



/*------------------------------------------------ TIME -----------------------------------------------*/
class Time {
    var seconds = 0
    init(seconds: Int) {
        self.seconds = seconds
    }
}

extension Time {
    var createTime:String{
        let time =  (seconds / 3600, (seconds % 3600) / 60, seconds % 60)
        let (h, m, s) = time
        
        var strHr = String(h)
        var strMin = String(m)
        var strSec = String(s)
        
        if h < 10 {
            strHr = "0\(h)"
        }
        
        if m < 10{
            strMin = "0\(m)"
        }
        
        if s < 10{
            strSec = "0\(s)"
        }
        
        return "\(strHr):\(strMin):\(strSec)"
    }
    
    
    var shortTime: String{
            let time =  (seconds / 3600, (seconds % 3600) / 60, seconds % 60)
            let (h, m, s) = time
            
            var strHr = String(h)
            var strMin = String(m)
            var strSec = String(s)
            
            if h < 10 {
                strHr = "0\(h)"
            }
            
            if m < 10{
                strMin = "0\(m)"
            }
            
            if s < 10{
                strSec = "0\(s)"
            }
            
            var res = "\(strHr):\(strMin):\(strSec)"
            
            return "\(strMin):\(strSec)"
    }
}





/*------------------------------------------------ PACE -----------------------------------------------*/
class Pace {
    var sec: Double
    var dist: Double
    init(sec: Double, dist:Double){
        self.sec = sec
        self.dist = dist
    }
}

extension Pace{
    func getPace() -> String {
        let paceinsec = self.sec / dist
        let minutes = paceinsec / 60
        let rminutes = Double(floor(minutes))
        let decimalsec = minutes - rminutes
        let pmins = Int(floor(rminutes))
        let psec = Int(floor(decimalsec * 60))
        return "\(pmins):\(psec)"
    }
}



/*------------------------------------------------ PROGRESS -----------------------------------------------*/
class Progress {
    var total:Double = 0
    init(total:Double) {
        self.total = total
    }
}

extension Progress{
    func get(d: Double) -> Float{
        total += d
        let progressTotal = Float(total / 100) // 1 km will be 0.01 :  10 will be 0.1
        return progressTotal
    }
}



/*------------------------------------------------ TRAINING -----------------------------------------------*/
class Training {
    var title: String
    var goal: Double
    var done: Float
  
    init(title: String, goal: Double, done: Float){
        self.title = title
        self.goal = goal
        self.done = done
    }
}


class RCounter{
    var runs: [Run]
    init(runs: [Run]){
        self.runs = runs
    }
    
    func getCount() -> Double {
    var total = 0.0
        for item in self.runs{
            total += Double(item.distance)!
        }
        return total
        
    }
}

class PBGetter{
    var runs: [Run]
    init(runs: [Run]){
        self.runs = runs
    }
    
    func getCount() -> Double {
        var max = 0.01
        
        for (index, run) in self.runs.enumerated(){
            if Double(run.distance)! > max{
                max = Double(run.distance)!
            }
        }
        
        return max 
    }
}



class Splits{
    var runs: [Run]
    var times:[Int]
    var distances: [String]
    var e:Int
    init(runs: [Run], times: [Int], distances:[String], e:Int){
        self.runs = runs
        self.times = times
        self.distances = distances
        self.e = e
    }
    
    
    func get() -> (dists: [String], times: [Int]){
        for (i, val) in runs[e].laps.enumerated(){
            if i == 0{
                distances.append("\(i + 1).km:")
                times.append(runs[e].laps[i])
            }
            
            if i != 0{
                distances.append("\(i + 1).km:")
                times.append(runs[e].laps[i] - runs[e].laps[i - 1])
            }
        }
        
        return (distances, times)
    }
}

/*
 var max = 0.01
 
 for (index, run) in runs.enumerated(){
 if Double(run.distance)! > max{
 max = Double(run.distance)!
 i = index
 }
 }
 
 longest.text = "Longest run: \(max) km >"
 
 
 
 
 
 */



//
//  Fetchers.swift
//  Runny
//
//  Created by Filip Vabroušek on 12.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import Foundation
import CoreData
import UIKit


/*------------------------------------------------ RFETCHER -----------------------------------------------*/
class RFetcher{
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetch() -> [Run] {
        
        var runs = [Run]()
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let run = res.value(forKey: key) as? Run {
                        runs.append(run)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return runs
    }
    
}




/*------------------------------------------------ UFETCHER -----------------------------------------------*/
class UFetcher{
    
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetch() -> [User] {
        
        var users = [User]()
        users.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let user = res.value(forKey: key) as? User {
                        users.append(user)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return users
    }
    
}






/*------------------------------------------------ ERASER -----------------------------------------------*/
class Eraser{
    var ename: String
    init(ename: String){
        self.ename = ename
    }
    
    
    func erase() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Deleted")
        }
            
        catch {
            print("Deletion failed")
        }
    }
}



/*------------------------------------------------ ROW ERASER -----------------------------------------------*/
class RowEraser{
    
    var ename: String
    var index: Int
    
    init(ename: String, index: Int){
        self.ename = ename
        self.index = index
    }
    
    func erase(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let res = try context.fetch(request)
            let run = res[index]
            context.delete(run as! NSManagedObject)
            try context.save()
        }
            
        catch{
            print("Somethin went wrong \(error)")
        }
    }
}







/*---------S--------------------------------------- SAVER -----------------------------------------------*/
class Saver{
    
    var ename: String
    var key: String
    var obj: Run
    init(ename: String, key: String, obj: Run){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
        }
        catch{
            // sth went wrong
        }
    }
}




/*---------S--------------------------------------- USAVER -----------------------------------------------*/
class USaver{
    
    var ename: String
    var key: String
    var obj: User
    init(ename: String, key: String, obj: User){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
        }
        catch{
            // sth went wrong
        }
    }
}


//
//  CLine.swift
//  Runny
//
//  Created by Filip Vabroušek on 13.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import MapKit



class S: MKPolylineRenderer{
    var poly: MKPolyline
    var color: UIColor
    
    init(poly: MKPolyline, color: UIColor){
        self.poly = poly
        self.color = color
        super.init(overlay: poly)
    }
    
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {

        // Quartz 2D framework (cgcontext is its drawing environment)
        context.setBlendMode(.exclusion) // CGBlendMode.exclusion
        context.setFillColor(UIColor.clear.cgColor)
        context.setStrokeColor(self.color.cgColor)
        context.setLineWidth(500.0)
        
       if self.polyline.pointCount > 1 {
        
           // begin at the first point
            context.beginPath()
            let point = self.point(for: self.polyline.points()[0])
            context.move(to: CGPoint(x: point.x, y: point.y))
        
            // connect all poylyline points by "context.addLine(..)"
            for i in 1 ..< self.polyline.pointCount{
                let point = self.point(for: polyline.points()[i])
                context.addLine(to: CGPoint(x: point.x, y: point.y))
            }
        
            // close path and draw it
            context.closePath()
            context.drawPath(using: .fillStroke)
        }
    
    }
    
}




//
//  ModernButton.swift
//  Runny
//
//  Created by Filip Vabroušek on 08.05.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class MusicButton: UIButton{

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame.size = CGSize(width: 40, height: 40)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.backgroundColor = UIColor.orange.cgColor
        self.setTitle("S", for: .normal)
        self.titleLabel?.textColor = UIColor.white
    }
    
}


class StartButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame.size = CGSize(width: 200, height: 60)
        self.layer.cornerRadius = 30
        self.layer.backgroundColor = UIColor(red: 10.2, green: 73.7, blue: 61.2, alpha: 1.0).cgColor
    }
}

class StopButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame.size = CGSize(width: 200, height: 60)
        self.layer.cornerRadius = 30
        self.layer.backgroundColor = UIColor(red: 100, green: 100, blue: 100, alpha: 1.0).cgColor
    }
}



import UIKit

class MusicCell: UICollectionViewCell {
   
    
    @IBOutlet var label: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 12.0
        imgView.clipsToBounds = true
    }
    
    
}

//
//  SplitCell.swift
//  Runny
//
//  Created by Filip Vabroušek on 27.05.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class SplitCell: UITableViewCell {

    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
       
    }

    
    func updateUI(distance:String, duration:Int, mark:Bool){
        self.distanceLabel.text = distance

        if (mark == true){
            let bv = UIView()
            bv.backgroundColor = UIColor(hue: 0.47, saturation: 0.76, brightness: 0.80, alpha: 0.7)
            self.backgroundView = bv
            self.timeLabel.textColor = UIColor.white
            self.distanceLabel.textColor = UIColor.white
            self.imgView.image = UIImage(named: "fastest.png")
        }
        
        let sec  = Int(duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        
        self.timeLabel.text = time
       // self.imgView.image = UIImage(named: "runner.jpg")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

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
    
  
    
    func updateUI(date:String, distance:String, duration:Int){
       
        self.dateLabel.text = date
        self.distanceLabel.text = distance
        
        let sec  = Int(duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        
        self.durationLabel.text = String(String(time))
        self.imgView.image = UIImage(named: "runner.jpg")
    }
    

    
}



//
//  TrainingCell.swift
//  Runny
//
//  Created by Filip Vabroušek on 11.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit

class TrainingCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var progress: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var distLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hue: 0.47, saturation: 0.76, brightness: 0.80, alpha: 0.7)
        self.layer.cornerRadius = 20
    }
    
    
    func updateUI(name: String, dist: Double, val:Float, finished: Bool){
        title.text = name
        distLabel.text = String(dist)
        
        progressBar.setProgress(val, animated: true)
        if (finished == true){
            print("Goal achieved remove this cell")
            self.backgroundColor = UIColor.orange
        }
        
        if (val * 100 <= 100){
            progress.text = "\(val * 100) % done"
        } else {
            progress.text = "level complete"
        }
        
        title.textColor = UIColor.white
        progress.textColor = UIColor.white
        distLabel.textColor = UIColor.white
        
    }
}



import UIKit
import MapKit
import CoreLocation
import CoreData


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //outlets
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var startBtn: UIButton!
    @IBOutlet var finishBtn: UIButton!
    
    // instances
    var LM = CLLocationManager()
    var timer = Timer()
    var paceTimer = Timer() // timer for pace
    let date = Date()
    let formatter = DateFormatter()
    
    // scalars
    var sec = 0
    var paceSec = 1.0
    var minutes = 0
    var secDuration = 0.0
    var travelled:Double = 0
    var distanceString = ""
    var fillinloc = "" // chnged in functions
    var fillinweather = "" // changed in functions
    
    
    // variables used for splits
    var adding = 0 // info about how many km will be added
    var temp = 0.0
    var goal = 0.3 // starting distance for split (every 300m)
    var limit = 1.0
    
    
    // locations
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    
    // location instances
    var AL = CLLocation(latitude: 0, longitude: 0)
    var AL2  = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // arrays
    var latPoints = [Double]() // not used yet, to create polyline
    var lonPoints = [Double]()
    lazy var locations = [CLLocation]()
    var locs: [CLLocation] = []
    var secs = [Int]()
    
    
    
    /*-----------------------------------------------------------VIEW DID LOAD---------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    func setup(){
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        LM.requestWhenInUseAuthorization()
        LM.distanceFilter = 10.0
        map.showsUserLocation = true
        map.mapType = MKMapType.standard
        map.delegate = self
        map.isZoomEnabled = true
    }
    
    /*-----------------------------------------------------------START---------------------------------------------------------*/
    
    @IBAction func start(_ sender: Any) {
        startBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        LM.startUpdatingLocation()
        paceTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.paceInc), userInfo: nil, repeats: true)
        paceSec = 0
        secs.removeAll()
        travelled = 0
        secDuration = 0
        temp = 0.0
    }
    
    
    /*-----------------------------------------------------------FINISH---------------------------------------------------------*/
    
    @IBAction func finish(_ sender: Any) {
        createAlert()
    }
    
    func createAlert(){
        let AC = UIAlertController(title: "Finish activity", message: "Are you sure you want to stop?", preferredStyle: .alert)
     
        let finish = UIAlertAction(title: "OK", style: .default) { (action) in
            self.stopProccessing()
            self.save()
            self.performSegue(withIdentifier: "toHistFrom", sender: self)
        }
        
        let carryon = UIAlertAction(title: "Not yet", style: .default) { (action) in
            print("User has decided to continue")
        }
        
        AC.addAction(finish)
        AC.addAction(carryon)
        
        
        self.present(AC, animated: true, completion: nil)
    }
    
    func stopProccessing(){
        LM.stopUpdatingLocation()
        timer.invalidate()
        paceTimer.invalidate()
    }
    
    
    // save activity to core data
    func save(){
        
        let distkm = travelled / 1000
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        let distS = String(distkm)
        let llat = AL.coordinate.latitude
        let llon = AL.coordinate.longitude
        let dur = Int(secDuration)
        
        
        if Double(distkm) != 0.000000 && dur != 0{
            
          
            
            let run = Run(date: result, distance: distS, location: fillinloc, weather: fillinweather, lat: llat, lon: llon, duration: dur, laps: secs, latPoints: latPoints, lonPoints: lonPoints)
            
            let s = Saver(ename: "Activities", key: "runs", obj: run)
            s.save()
        }
        
        
    }
    
    
    
    
    /*-----------------------------------------------------------TIMER---------------------------------------------------------*/
    @objc func increaseTimer(){
        secDuration += 1
        let time = Time(seconds: Int(secDuration))
        timerLabel.text = time.shortTime
    }
    
    
 
    
    
    /*-----------------------------------------------------------UPDATE LOCATION---------------------------------------------------------*/
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //  1
        locs.append(locations[0])
        
        let location:CLLocation = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: span)
        self.map.setRegion(region, animated: true)
        
        
        //  2
        if (locs.count > 1){
            let sourceIndex = locs.count - 1
            let destinationIndex = locs.count - 2
            
            let c1 = locs[sourceIndex].coordinate
            let c2 = locs[destinationIndex].coordinate
            var a = [c1, c2]
            latPoints.append(Double(c1.latitude)) // save for later use
            lonPoints.append(Double(c1.longitude))
            
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            self.map.add(polyline)
        }
        
        
        
        
        //3
        
        for location in locations {
            
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    // get total travelled distance to show it an display
                    travelled += round(location.distance(from: AL))
                    
                    // ---------------- COUNT PACE
                    temp = (travelled).rounded() / 1000 // 0.43
                    temp = (100 * temp).rounded() / 100 // 0.43
                    
                    // make generic way
                    if (temp > limit){
                        adding = adding + 1000
                        writePace(temp: temp, adding: adding)
                        limit = limit + 1
                        print("Just wrote \(adding)m")
                    }
                    print(temp, limit)
                    
                }
                
                distanceString = String(round(travelled) / 1000)
                self.distanceLabel.text = distanceString
                self.locations.append(location)
            }
        }
        
        
        
         let cities = ["Cupertino", "Sunville", "Los Altos", "Los Altos Hills", "Redwood city", "Portola Valley"]
        getGeodata(lat: lat, lon: lon, supported: cities) // get city name and if supported, JSON Weather
 
        AL = CLLocation(latitude: lat, longitude: lon)
        
        
    }
    
    func writePace(temp: Double, adding:Int){
        secs.append(Int(paceSec))
    }
    
    @objc func paceInc(){
        paceSec += 1.0
    }
    
    /*---------------------------------------------------------POLYLINE RENDERER-------------------------------------------------------*/
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            
         /*
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 4
            return renderer
         */
            

            let rend = S(poly: overlay as! MKPolyline, color: UIColor.orange)
            return rend
        }
        return MKPolylineRenderer()
    }
    
    
    
    
    
    
    
}

/*--------------------------------------------------------- GET CITY NAME AND WEATHER -------------------------------------------------------*/

extension ViewController{
    
    
    fileprivate func getGeodata(lat: CLLocationDegrees, lon: CLLocationDegrees, supported: [String]) {
        
        var solocation = ""
        let loc = CLLocation(latitude: lat, longitude: lon)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loc , completionHandler: { (placemarks, error) in
            
            if error != nil {
                print("Something went wrong \(error)")
            }
            
            if let placemark = placemarks?[0]{
                if placemark.locality != nil{
                    solocation = placemark.locality!
                    print("LOC \(solocation)")
                    // self.fillinloc = solocation
                    self.getWeatherData(location: solocation, supported: supported)
                    
                } else {
                    print("We do not have data")
                }
            }
            
            
        });
    }
    
    
    
    fileprivate func getWeatherData(location:String, supported: [String]) {
        let url = URL(string: "https://cdn.rawgit.com/filipvabrousek/Swift-apps/bb4f0aae/weather.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("URL processing failed: \(error)")
            }
            
            if let content = data{
                do{
                    let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
                   
                    // we have cities in our JSON file
                    if supported.contains(location){
                        self.fillinweather = res[location] as! String
                    } else {
                        self.fillinweather = "No data available"
                    }
                    
                    self.fillinloc = location
                    print("Inside " + location)
                }
                    
                catch{
                    print("Processing failed")
                }
            }
            
        }
        
        task.resume()
        
    }
    
}



import UIKit
import AVFoundation

class MusicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var name: UILabel!
    
    
    let arr = ["angeleyes", "womansoon","angeleyes", "womansoon", "womansoon"]
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func shuffle(_ sender: Any) {
        let rand = Int(arc4random_uniform(UInt32(arr.count - 1)))
        play(index: rand)
        name.text = arr[rand]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! MusicCell
        cell.label.text = arr[indexPath.row]
        cell.imgView.image = UIImage(named: "music.png")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        play(index: indexPath.row)
        name.text = arr[indexPath.row]
        
    }
    
 
    func play(index:Int){
        
        // player cannot be declared here, because it could go out of scope (must be on the top)
        let location = Bundle.main.path(forResource: arr[index], ofType: ".mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: location!))
            player.stop()
            player.play()
        }
            
        catch{
            print("Something went wrong \(error)")
        }
        
        name.text = arr[index]
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}




import UIKit
import CoreData
import MapKit


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var progressVal = 0
    var runs = [Run]()
    var i  = 0
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    
    /*-----------------------------------------------------------TABLE VIEW---------------------------------------------------------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActivityTableViewCell
        let curr = runs[indexPath.row]
        cell.updateUI(date: curr.date, distance: curr.distance, duration: curr.duration)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
      
            let e = RowEraser(ename: "Activities", index: indexPath.row)
            e.erase()
         
            runs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        performSegue(withIdentifier: "toActivityDetail", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = tableView.indexPathForSelectedRow?.row{
            let activ = segue.destination as! ActivityViewController
            activ.e = index
            activ.runs = runs
        }
        
    }
    
    
    
    
    /*-----------------------------------------------------------VIEW DID APPEAR---------------------------------------------------------
     */
    override func viewDidAppear(_ animated: Bool) {
        fetchArray()
        tableView.reloadData()
    }
    
    func fetchArray()  {
        let res = RFetcher(ename: "Activities", key: "runs")
        runs = res.fetch()
    }
    
    
    func updateAndSaveProgress(){
        let deserveReward = false
        UserDefaults.standard.set(deserveReward, forKey: "REWARD")
    }
    
    
  
    
    
}





class ActivityViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    // Outlets - 9
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var failureLabel: UILabel!
    @IBOutlet var paceLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var weatherImgview: UIImageView!
 
    // variables - 2
    var e = 0
    var runs = [Run]()
    
   
    
    
    
    /*---------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Weather: \(runs[e].weather)")
        map.delegate = self
        
        for (i, val) in runs[e].laps.enumerated(){
         
                var time = Time(seconds: 0)
                if i == 0{
                    time = Time(seconds: runs[e].laps[i]) // secs[i] - secs[i - 1]
                    print( "\(i + 1).km: \(time.createTime)")
                }
            
                if i != 0{
                    time = Time(seconds: runs[e].laps[i] - runs[e].laps[i - 1]) // secs[i] - secs[i - 1]
                    print( "\(i + 1).km: \(time.createTime)")
                }
        }
        
        updateUI()
        
    }
    
    
    
    
    func updateUI(){
        
        //  2
        dateLabel.text = runs[e].date
        distanceLabel.text = runs[e].distance
        
        
        //  3
        let sec  = Int(runs[e].duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        durationLabel.text = String(time)
        
        // 4
        let paceobj = Pace(sec: Double(sec), dist: Double(runs[e].distance)!)
        paceLabel.text = "\(paceobj.getPace())/km"
        
        locationLabel.text = runs[e].location
      
        
        let weather = runs[e].weather
        weatherLabel.text = weather
        failureLabel.text = ""
     
        // get keywords from "light rain" string
        if (weather.range(of: "rain", options: .caseInsensitive) != nil){
            weatherImgview.image = UIImage(named: "rain.png")
        } else if (weather.range(of: "sunny", options: .caseInsensitive) != nil){
            weatherImgview.image = UIImage(named: "sun.png")
        } else if (weather.range(of: "clouds", options: .caseInsensitive) != nil){
            print("There are some clouds") // Cupertino
            weatherImgview.image = UIImage(named: "cloud.png")
        }
        
        // we have no weather
        if weather == "" {
            failureLabel.text = "NO DATA AVAILABLE"
            print("No weather data")
        }
        
        
        // 5
        updateMap()
    }
    
    
    func updateMap(){
        // center the map on coordinates
        let deg1 = CLLocationDegrees(runs[e].lat)
        let deg2 = CLLocationDegrees(runs[e].lon)
        let loc = CLLocationCoordinate2D(latitude: deg1, longitude: deg2)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) //0.05
        let region = MKCoordinateRegion(center: loc, span: span)
        self.map.setRegion(region, animated: true)
       
        renderPolyline()
    }
    
    
    
    
    
    fileprivate func renderPolyline() {
        // render polyline in the activity detail
        let latp = runs[e].latPoints
        var a = [CLLocationCoordinate2D]()
        for (index, point) in latp.enumerated(){
            let lat = runs[e].latPoints[index]
            let lon = runs[e].lonPoints[index]
            let el = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            a.append(el)
        }
        
        let polyline = MKPolyline(coordinates: &a, count: a.count)
        map.add(polyline)
        
        
        // add start and finish points
        let aa = MKPointAnnotation()
        aa.coordinate = a[0]
        aa.title = "START"
        
        let ab = MKPointAnnotation()
        ab.coordinate = a[a.count - 1]
        ab.title = "FINISH"
        
        self.map.addAnnotation(aa)
        self.map.addAnnotation(ab)
      
    }
    
    
    
    
    
    
  
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 4
            return renderer
        }
        return MKPolylineRenderer()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // set value of "e" in SplitsVC, to acces each split for calculatiosn
            let activ = segue.destination as! SplitsViewController
            activ.e = e
            activ.runs = runs
    }
    
    
    
    /*--------------------------------------SHARE--------------------------------------*/
    @IBAction func share(_ sender: Any) {
        let item = "I ran \(runs[e].distance) km with app Runny"
        let share = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated:true, completion: nil)
    }
    
    
}



import UIKit

class SplitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // variables - 6
    var runs = [Run]()
    var distances = [String]()
    var times = [Int]() // in seconds
    var e = 0
    var mini = 0 // index of the fastest km
    var min = 0
    
    // outlets - 1
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let should = shouldColor(passed: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SplitCell
        cell.updateUI(distance: distances[indexPath.row], duration: times[indexPath.row], mark: should)
        return cell
    }
    
    
    // Get the index of the cell with fastest km
    func shouldColor(passed: Int) -> Bool {
        var min = times[0]
        mini = 0
        
        for (i, val) in times.enumerated(){
           
            if (times[i] < min){
                min = times[i]
                mini = i
            }
            // print("Index of the cell with fastest km is \(mini)")
        }
        
        if (passed == mini){
            return true
        } else {
            return false
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sp = Splits(runs: runs, times: times, distances: distances, e: e)
        let res = sp.get()
        distances = res.dists
        times = res.times
        
    }

   

}



import UIKit
import CoreData


class TrainingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet var collectionView: UICollectionView!
    

     var runs = [Run]()
     var sum = 0.0
    
    let trainings = [Training(title: "Beginner", goal: 1, done: 0),
                    Training(title: "Pro", goal: 2, done: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRuns()
        sum = getTotal()
        print("C \(runs.count)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    func fetchRuns(){
    let res = RFetcher(ename: "Activities", key: "runs")
    runs = res.fetch()
    }
    
    
    func getTotal() -> Double {
        var total = 0.0
        let sum = RCounter(runs: runs)
        total = sum.getCount()
        let rounded = (total * 100).rounded() / 100
        return rounded
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainings.count
    }
    
    
    // for each cell update UI to reflect curent progress
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TCell", for: indexPath) as! TrainingCell
       
        var done = false
        let t = trainings[indexPath.row]
       
        var val = 0.0

        for item in trainings{
            if (sum > t.goal){
                t.title = "DONE" // Write this to UI
                done = true
            }
            
             val = sum / t.goal
             cell.updateUI(name: t.title, dist: t.goal, val: Float(val), finished:done)
        }
        return cell
    }
}



import UIKit
import CoreData
import CoreImage


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var longest: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var badgeView: UIImageView!
    @IBOutlet var progressLabel: UILabel!
    
    // variables
    var i = 0
    var users = [User]()
    var runs = [Run]()
    var total = 0.0
    var timer = Timer()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
        restore()
        fetchRuns()
        fetchUsers()
        getPB()
        updateProgress()
    }
    
    
    func updateProgress(){
        let sum = RCounter(runs: runs)
        total = sum.getCount()
        
        let progressVal = total / 10.0
        addCircle(angle: CGFloat(progressVal))
        
        let rounded = (total * 100).rounded() / 100
        progressLabel.text = String("\(rounded) % done")
    }
    
    
    
    func addCircle(angle: CGFloat){
        let center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 1.5)

        let backgroundc = UIBezierPath(arcCenter: center, radius: 90, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let blayer = CAShapeLayer()
        blayer.path = backgroundc.cgPath
        blayer.fillColor = UIColor.clear.cgColor
        blayer.strokeColor = UIColor.gray.cgColor
        blayer.lineWidth = 9.0
        view.layer.addSublayer(blayer)
        
        let circle = UIBezierPath(arcCenter: center, radius: 90, startAngle: CGFloat(Double.pi * 2), endAngle: angle, clockwise: true)
        let slayer = CAShapeLayer()
        slayer.path = circle.cgPath
        slayer.fillColor = UIColor.clear.cgColor
        slayer.strokeColor = UIColor.green.cgColor
        slayer.lineWidth = 9.0
        view.layer.addSublayer(slayer)
    }
    
    
    
    @IBAction func changeImage(_ sender: Any) {
        let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.allowsEditing = false
        IMPC.sourceType = .photoLibrary
        present(IMPC, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        var final =  img
        let data:NSData = UIImagePNGRepresentation(final)! as NSData
        UserDefaults.standard.set(data, forKey: "profile")
        final = apply(image: final)
        imgView.image = final
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func apply(image: UIImage) -> UIImage{
        let ci = CIImage(cgImage: image.cgImage!)
        let filter = CIFilter(name: "CIPhotoEffectMono") // CISepiaTone
        filter?.setValue(ci, forKey: kCIInputImageKey) // kCIInputIntensityKey
        let output = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let filtered = UIImage(ciImage: output)
        return filtered
    }
    
    
   
    @IBAction func eraseData(_ sender: Any) {
        let alert = UIAlertController(title: "Delete all runs", message: "Are you sure you want to delete all your runs?", preferredStyle: .alert)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let er = Eraser(ename: "Activities")
            er.erase()
            
            let uer = Eraser(ename: "Users")
            uer.erase()
        }
        
         let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
         alert.dismiss(animated: true, completion: nil)
         })
         
         alert.addAction(delete)
         alert.addAction(cancel)
         present(alert, animated: true, completion: nil)
    }
    
    
    
    func restore(){
        
        let data = UserDefaults.standard.object(forKey: "profile")
        
        if (data != nil){
        let img = data as! Data
        var res = UIImage(data: img)
        res = apply(image: res!) // apply b & w effect
        imgView.image = res
        } else {
            imgView.image = UIImage(named: "forestmist.jpg")
        }
   
    }
    
    
    
    func getPB(){
        let getter = PBGetter(runs: runs)
        longest.text = "Longest run \(getter.getCount())"
    }
    
    func addTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        longest.isUserInteractionEnabled = true
        longest.addGestureRecognizer(tap)
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer){
        print("Tap")
    }
    
    
    func fetchUsers(){ // type has to be User
        let res = UFetcher(ename: "Users", key: "users")
        users = res.fetch()
        if users.count > 0{
            nameLabel.text = users[users.count - 1].name
            print("users.length \(users.count)")
        } else {
            nameLabel.text = "User"
        }
        
    }
    
    
    func fetchRuns() { // type has to be Run
    let res = RFetcher(ename: "Activities", key: "runs")
    runs = res.fetch()
    }
    
}



import UIKit
import Foundation
import CoreData


class EditProfileViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var ageField: UITextField!
    
    
    var gender = ""
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setMale(_ sender: Any) {
        gender = "male"
    }
    
    @IBAction func setFemale(_ sender: Any) {
        gender = "female"
    }
    
    @IBAction func save(_ sender: Any) {
      
        let name = nameField.text!
        let born = ageField.text!
        let user = User(name: name, birth: born, gender: gender)
        
        let us = USaver(ename: "Users", key: "users", obj: user)
        us.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

