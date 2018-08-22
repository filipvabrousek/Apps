

import Foundation
import MapKit

/*------------------------------------------------------RUN---------------------------------------------------------------*/
class Run: NSObject, NSCoding {
    
   
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
        static let latMarkers = "latMarkers"
        static let lonMarkers = "lonMarkers"
     
        
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
    private var _latMarkers = [Double]()
    private var _lonMarkers = [Double]()
    
    override init() {}
    
    
    /*---------------------------------------------------------------------------------------------------------*/
    init(date: String, distance: String, location:String, weather: String, lat:Double, lon:Double, duration: Int, laps:[Int], latPoints:[Double], lonPoints:[Double], latMarkers:[Double], lonMarkers:[Double]) {
        
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
        self._latMarkers = latMarkers
        self._lonMarkers = lonMarkers
        
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
        
        if let LATM = aDecoder.decodeObject(forKey: Keys.latMarkers) as? [Double]{
            _latMarkers = LATM
        }
        
        if let LONM = aDecoder.decodeObject(forKey: Keys.lonMarkers) as? [Double]{
            _lonMarkers = LONM
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
        aCoder.encode(_latMarkers, forKey: Keys.latMarkers)
        aCoder.encode(_lonMarkers, forKey: Keys.lonMarkers)
        
        
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
    
    
    var latMarkers:[Double]{
        get{
            return _latMarkers
            
        }
        
        set{
           _latMarkers = newValue
        }
    }
    
    
    var lonMarkers:[Double]{
        get{
            return _lonMarkers
            
        }
        
        set{
            _lonMarkers = newValue
        }
    }
    
    
  
}






class User: NSObject, NSCoding{
    struct Keys {
        static let name = "name"
        static let birth = "birth"
        static let gender = "gender"
        static let goal = "goal"
    }
    
    
    private var _name = ""
    private var _birth = ""
    private var _gender = ""
    private var _goal = 0.0
    
    override init() {}
    
    init(name: String, birth:String, gender: String, goal:Double){
        self._name = name
        self._birth = birth
        self._gender = gender
        self._goal = goal
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
        
        if let goalObject = aDecoder.decodeDouble(forKey: Keys.goal) as? Double{
            _goal = goalObject
        }
        
    }
    
    
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_name, forKey: Keys.name)
        aCoder.encode(_birth, forKey: Keys.birth)
        aCoder.encode(_gender, forKey: Keys.gender)
        aCoder.encode(_goal, forKey: Keys.goal)
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
    
    
    var goal:Double{
        get {
            return _goal
        }
        
        set {
            _goal = newValue
        }
    }
}



import Foundation
import CoreData
import MediaPlayer
import UIKit


/*------------------------------------------------ RFETCHER -----------------------------------------------*/
class Fetcher{
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    
    func fetchR() -> [Run] {
        
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
    
    
    func fetchU() -> [User] {
        
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
    
    func fetchM() -> [MPMediaItem] {
        var songs = [MPMediaItem]()
        songs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let song = res.value(forKey: key) as? MPMediaItem {
                        songs.append(song)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return songs
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
            
        }
    }
}







class MSaver{
    
    var ename: String
    var key: String
    var obj: MPMediaItem
    init(ename: String, key: String, obj: MPMediaItem){
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
            print("saved songs")
        }
        catch{
            
        }
    }
}



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
        var res = ""
        res += "\(pmins):"
        
        if (psec < 10){
            res += "0\(psec)"
        } else {
            res += "\(psec)"
        }
        
        return res
    }
    
    func getKPH() -> String {
        let paceinsec = self.sec / dist
        let minutes = paceinsec / 60
        let kmh = round(60 / minutes)
        return "\(kmh)"
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
    var img: String
  
    init(title: String, goal: Double, done: Float, img:String){
        self.title = title
        self.goal = goal
        self.done = done
        self.img = img
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
    
    func getMax() -> Double {
        var max = 0.01
        
        for (_, run) in self.runs.enumerated(){
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
    
    
    func get() -> (dists: [String], times: [Int], avg: Double){
      
        var sum = 0
        var avg = 0.0
        for (i, _) in runs[e].laps.enumerated(){
            if i == 0{
                distances.append("\(i + 1)")
                times.append(runs[e].laps[i])
            }
            
            if i != 0{
                distances.append("\(i + 1)")
                times.append(runs[e].laps[i] - runs[e].laps[i - 1])
            }
            
        }
        
     
        
        for val in times{
            sum += val
        }
        
        
        if (times.count > 0){ // not to crash at low dists
        avg = Double(sum / times.count) // get avg lap
        print("times.count is less than 0")
        }
     
        return (distances, times, avg)
    }
}



class Diff {
    var valA: Double
    var valB: Double
    
    init(valA: Double, valB:Double){
        self.valA = valA
        self.valB = valB
    }
    
    func getDiff() -> Double {
    var res = valA - valB
    res = (res * 100).rounded() / 100
    return res
    }
    
    func getAngle() -> Double {
        print("A \(valA) B \(valB)")
        return valB / valA * 6.28
    }
    
    func getPerc() -> Double {
        let x = valB / valA * 100
        return round(10 * x) / 10
    }
}



class Converter{
    
    var a:Double
    
    init(a:Double){
        self.a = a
    }
    
    
    func getRatio() -> Double{
        var ratio = 0.0
        
        
        if (self.a > 15.0){
            ratio = 0.2
        } else if (self.a > 13.0){
            ratio = 0.5
        } else if (self.a > 10.0){
            ratio = 0.7
        } else if (self.a > 8.0){
            ratio = 1.0
        } else if (self.a > 6.0){
            ratio = 1.4
        } else if (self.a > 3.0) {
            ratio = 1.9
        } else if (self.a > 2.0) {
            ratio = 2.3
        } else {
            ratio = 3.7
        }
        return ratio
    }
    
    func getVal() -> Double{
        let add = Double(a / 100) * 6.3 // 6.3 is 100%, a is 12 -> 0.12 * 6.3 = 0.8
        return add
    }
}



class Extractor {
    var text: String
    init(text:String){
        self.text = text
    }
    
    func getw() -> String{
        var res = ""
        if (text.range(of: "sunny", options: .caseInsensitive) != nil){
            res = "sun.png"
        } else {
            res = "no"
        }
        return res
    }
}

 
 
struct Platform {
    static let isSimulator: Bool = {
         #if arch(i386) || arch(x86_64)
        return true
        #endif
    return false
    }()
}
 
 
 
 
import Foundation

class Podcast {
    var name: String
    var desc: String
    var author: String
    var image: String
    var dur:String
    
    init(name: String, desc: String, author: String, image: String, dur:String){
        self.name = name
        self.desc = desc
        self.author = author
        self.image = image
        self.dur = dur
    }
}




import UIKit

struct Alert {
      func show(on: UIViewController, title:String, messsage:String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
       
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {on.present(alert, animated: true, completion: nil)}
    }
}


struct Sheet {
    func show(on: UIViewController, title:String, messsage:String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .actionSheet)
        
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {on.present(alert, animated: true, completion: nil)}
    }
}




import UIKit

class StartButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.layer.cornerRadius = 25
        self.layer.backgroundColor = UIColor.black.cgColor
    }
}

class StopButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.layer.cornerRadius = 25
        self.layer.backgroundColor = hex("#e74c3c").cgColor
    }
}


class ShareButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        self.layer.cornerRadius = 20
        self.frame.size = CGSize(width: 180, height: 50)
        self.layer.backgroundColor = UIColor.black.cgColor
    }
    
}





import UIKit

class Overlay: UIView {
    
    var avg = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.alpha = 0.7
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false // allow scrolling through it :)
    }
    
    
    override func draw(_ rect: CGRect) {
        let sl = CAShapeLayer()
        sl.strokeColor = UIColor.blue.cgColor
        sl.opacity = 0.6
        sl.lineWidth = 2
        sl.lineDashPattern = [7, 3]
        
        let path = CGMutablePath()
        
        let a = CGPoint(x: CGFloat(avg / 4), y: 0)
        let b = CGPoint(x: CGFloat(avg / 4), y: self.frame.height)
        path.addLines(between: [a, b])
        sl.path = path
        self.layer.addSublayer(sl)
    }
}



class Chart: UIView {
    
    
    var angle: CGFloat
    
    var text:String?
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, angle: 0)
        self.backgroundColor = .clear
        
    }
    
    init(frame: CGRect, angle: CGFloat) {
        self.angle = angle
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        angle = 0
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        let backgroundc = UIBezierPath(arcCenter: center, radius: 80, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let blayer = CAShapeLayer()
        blayer.path = backgroundc.cgPath
        blayer.fillColor = UIColor.clear.cgColor
        blayer.strokeColor = hex("#eaeaea").cgColor
        blayer.lineWidth = 19.0
        self.layer.addSublayer(blayer)
        
        let circle = UIBezierPath(arcCenter: center, radius: 80, startAngle: CGFloat(Double.pi * 2), endAngle: angle, clockwise: true)
        let slayer = CAShapeLayer()
        slayer.path = circle.cgPath
        slayer.fillColor = UIColor.clear.cgColor
        slayer.strokeColor = hex("#1abc9c").cgColor
        slayer.lineWidth = 19.0
        self.layer.addSublayer(slayer)
    }
}





import UIKit

extension UIView {
    
    func fillSuperview(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to: UIView){
    widthAnchor.constraint(equalTo: to.widthAnchor).isActive = true
    heightAnchor.constraint(equalTo: to.heightAnchor).isActive = true
    }
    

    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}


extension Double {
    func frounded(to: Int) -> Double {
        let divisor = pow(10.0, Double(to))
        return (self * divisor).rounded() / divisor
    }
}

func hex(_ hex:String) -> UIColor {
    var cs = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if cs.hasPrefix("#"){
        cs.remove(at: cs.startIndex)
    }
    
    if cs.count != 6 {
        return UIColor.black
    }
    
    var rgbv: UInt32 = 0
    Scanner(string: cs).scanHexInt32(&rgbv)
    
    return UIColor(red: CGFloat((rgbv & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((rgbv & 0x00FF00) >> 8) / 255.0,
                   blue: CGFloat((rgbv & 0x0000FF)) / 255.0,
                   alpha: CGFloat(1.0))
}








import UIKit

class MusicCell: UITableViewCell {

    var imgView = UIImageView()
    var title = UILabel()
    var view = UIView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        let lstack = UIStackView()
        
        title.font = UIFont.boldSystemFont(ofSize: 15)
        lstack.addArrangedSubview(title)
        lstack.addArrangedSubview(imgView)
        
        addSubview(lstack)
        
        let ins = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0)
        lstack.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: ins, size: .init(width: 170, height: 30))
    }
    }
    
    
    
    
import UIKit

class ActivityTableViewCell: UITableViewCell {
    var imgView = UIImageView()
    var distl = UILabel() // durlabel, datelabel
    var durLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
     
        distl.font = UIFont.boldSystemFont(ofSize: 19)
        
        let lstack = UIStackView()
        lstack.distribution = .fillEqually
        lstack.addArrangedSubview(distl)
        lstack.addArrangedSubview(durLabel)
        self.addSubview(lstack)
        
        let ins = UIEdgeInsets(top: 10, left: 60, bottom: 0, right: 110)
         lstack.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: ins, size: .init(width: 220, height: 30))
    }
    
    
    
    func updateUI(date:String, distance:String, duration:Int){
       
        distl.text = distance
 
        let sec = Int(duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        
        durLabel.text = String(String(time))
    }
    

    
}





import UIKit

class TTrainingCell: UITableViewCell {
    
    var progress = UIProgressView()
    var title = UILabel()
    var remainingl = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUI()
    }
    
    func addUI(){
        
        title.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(title)
        
        remainingl.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(remainingl)
        
        progress.tintColor = hex("#1abc9c")
        self.addSubview(progress)
        
        let rin = UIEdgeInsets(top: 3, left: 10, bottom: 0, right: 0)
        title.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: rin, size: .init(width: 300, height: 30))
        
        let win = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        progress.anchor(top: title.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: win, size: .init(width: self.frame.width, height: 12))
        
        let oun = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        remainingl.anchor(top: progress.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: oun, size: .init(width: self.frame.width, height: 20))
    }
    
    func updateUI(name: String, badge: String, goal: Double, sum: Double){
        title.text = name
        
        var remaining = (goal - sum)
        remaining = remaining.frounded(to: 2) 
        
        if remaining > 0 {
            remainingl.text = "remaining \(remaining)"
        } else {
            progress.isHidden = true
            title.text = "Mission accomplished"
        }
        
        
        
        let perc = (goal - (goal - sum)) / goal
        progress.setProgress(Float(perc), animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class SplitCell: UITableViewCell {

    var distanceLabel = UILabel()
    var timeLabel = UILabel()
    var imgView = UIImageView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   
    
    
    func mark(times: [Int]) -> Int {
        let min = times[0]
        var inx = 0
        for (i, _) in times.enumerated(){
            if (times[i] < min){
                inx = i
            }
        }
        print("MARKS \(inx)")
        return inx
    }
    
    
    func updateUI(distance:String, duration:Int, mark:Bool){
        self.distanceLabel.text = distance
        let sec  = Int(duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        self.timeLabel.text = time
        
        
        if (mark == true){
            self.imgView.image = UIImage(named: "fastest.png")
        } else {
            self.imgView.image = UIImage()
        }
        
        
        let bc = UIView()
        bc.backgroundColor = .white
       // bc.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height) // LAST !!!
        
       
        
        
        let pv = UIView()
        pv.backgroundColor = hex("#1abc9c") // 20 is 10% green
        pv.alpha = 0.3
        pv.frame = CGRect(x: 0, y: 0, width: CGFloat(sec / 4), height: self.bounds.height) // LAST !!!
        
        bc.addSubview(pv)
        self.backgroundView = bc
        
        let rin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bc.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: rin, size: .init(width: self.bounds.width, height: self.bounds.height))
        distanceLabel.textAlignment = .center
        addSubview(distanceLabel)
        addSubview(timeLabel)
        addSubview(imgView)
        
        
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        let lstack = UIStackView()
        lstack.distribution = .fillEqually
        lstack.addArrangedSubview(distanceLabel)
        lstack.addArrangedSubview(timeLabel)
        lstack.addArrangedSubview(imgView)
        self.addSubview(lstack)
        
        let ins = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 0)
        lstack.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: ins, size: .init(width: self.bounds.width, height: 30))
        imgView.contentMode = .scaleAspectFit
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}




class GSplitCell: UICollectionViewCell { // SplitViewController
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(val: Double){
        let sub = UIView()
        sub.backgroundColor = hex("#1abc9c")
        sub.layer.cornerRadius = 4
        self.addSubview(sub) // b 30
        let ensets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        sub.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: ensets, size: .init(width: self.frame.width / 2, height: CGFloat(val) * 20))
        
        
        let lbl = UILabel() // graph title
        var time = Time(seconds: Int(val * 100))
        print("val \(val) int \(Int(val * 100))")
        lbl.text = time.shortTime
        lbl.font = UIFont.boldSystemFont(ofSize: 10)
        lbl.textColor = .gray
        self.addSubview(lbl)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        lbl.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: insets, size: .init(width: self.frame.width, height: 30))
    }
    
    
    
}



import UIKit

class GraphCell: UICollectionViewCell {
    
    func updateUI(index:Int, runs:[Run]){
        
        let getter = PBGetter(runs: runs)
        let ln = getter.getMax()
        
        let ratio = Converter(a: ln)
        let res = ratio.getRatio()
        let run = runs[index]
        print("Run \(index + 1) \(run.distance)")

        let val = Double(run.distance)! * res
        
        let sub = UIView() // green graph bar
        sub.backgroundColor = hex("#1abc9c")
        sub.alpha = 0.6
        self.addSubview(sub)
        
        let sinsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        sub.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: sinsets, size: .init(width: self.frame.width / 2, height: CGFloat(val) * 20))
        
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        
        let valo = Double(run.distance)
        label.text = String(format: "%.2f", valo!)
        self.addSubview(label)
        
        let insets = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        label.anchor(top: self.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: insets, size: .init(width: self.frame.width / 2, height: 30))
    }
 
}




import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let activity = ViewController()
        activity.tabBarItem = UITabBarItem(title: "Activity", image: UIImage(named: "act-x.png"), tag: 0)
        
        let history = HistoryViewController()
        history.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let totals = TrainingsViewController()
        totals.tabBarItem = UITabBarItem(title: "Totals", image: UIImage(named: "totals-fff.png"), tag: 2)
        
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-f.png"), tag: 3)
        
        let list = [activity, history, totals, profile]
        viewControllers = list
    }
}




import UIKit
import MapKit
import CoreLocation
import CoreData
import HealthKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //outlets
    
    var map = MKMapView() // D
    var distanceLabel = UILabel() // D
    var timerLabel = UILabel() // D
    var paceLabel = UILabel() // D
    var songsBtn = UIButton() // FIX Subclasses
    var startBtn = StartButton()
    var finishBtn = StopButton()
    var labelsView = UIStackView() // D
   // var switcher = UIButton()
    
    
    // instances
    var LM = CLLocationManager()
    var timer: Timer?
    var btimer = Timer()
    //var paceTimer:Timer? // timer for pace
    let date = Date()
    let formatter = DateFormatter()
    
    // scalars
    var sec = 0
    var paceSec = 1.0
    var minutes = 0
    var secDuration = 0.0
    var travelled:Double = 0
    var distanceString = ""
    var fillinloc = "" // changed in functions
    var fillinweather = "" // changed in functions
    
    
    // variables used for splits
    var adding = 0 // info about how many km will be added
    var temp = 0.0
    var goal = 0.3 // starting distance for split (every 300m)
    var limit = 1.0
    
    
    // locations
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    var AL = CLLocation(latitude: 0, longitude: 0)
    var AL2  = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // arrays
    var latPoints = [Double]() // not used yet, to create polyline
    var lonPoints = [Double]()
    var latMarkers = [Double]()
    var lonMarkers = [Double]()
    lazy var locations = [CLLocation]()
    var locs: [CLLocation] = []
    var secs = [Int]()
    
    
    
    func addUI(){
        
        tabBarController?.tabBar.tintColor = .black
        
        map.showsUserLocation = true
        map.mapType = MKMapType.standard
        map.delegate = self
        map.isZoomEnabled = true
        
        timerLabel.text = "00:00"
        timerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        paceLabel.text = "00:00"
        paceLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        labelsView.distribution = .equalCentering
        labelsView.addArrangedSubview(timerLabel)
        labelsView.addArrangedSubview(paceLabel)
        
        // distLabel
        distanceLabel.text = "0.0"
        distanceLabel.textAlignment = .center
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 60)
        
        // buttons
        finishBtn = StopButton()
        finishBtn.setTitle("Stop", for: [])
        startBtn = StartButton()
        startBtn.setTitle("Start", for: [])
        songsBtn = ShareButton()
        songsBtn.setTitle("S", for: [])
  
        [distanceLabel, labelsView, map, finishBtn, startBtn, songsBtn].forEach {view.addSubview($0)}
    }
    
    /*-------1------------------------------------------------- LIFECYCLE ------------------------------------------------------*/
    override func viewDidLoad() { // called just when view is first loaded, set LM and map
        super.viewDidLoad()
        view.backgroundColor = .white
        UIDevice.current.isBatteryMonitoringEnabled = true
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        LM.requestWhenInUseAuthorization()
        LM.distanceFilter = 10.0
        LM.allowsBackgroundLocationUpdates = true
        LM.pausesLocationUpdatesAutomatically = false
        addUI()
        constrainUI()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) { // called everytime view is loaded
        self.resetUI()
        updateHR()
    }
    
    
    /*---------------2--------------------------------------------START---------------------------------------------------------*/
    @objc func start(sender: UIButton!){
        self.resetUI()
        startBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
        btimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.checkLevel), userInfo: nil, repeats: true)
        LM.startUpdatingLocation()
    }
    
    
    @objc func increaseTimer(){ // increase timer for duration and for pace + show to UI
        paceSec += 1.0
        secDuration += 1
        let time = Time(seconds: Int(secDuration))
        timerLabel.text = time.shortTime
        
        if secDuration > 1 && (travelled / 1000) > 0.01 {
            let pace = Pace(sec: secDuration, dist: travelled / 1000)
            paceLabel.text =  "\(pace.getPace())/km"
        }
    }
    
    @objc func checkLevel(){
       
        if !Platform.isSimulator {
        let level = UIDevice.current.batteryLevel  // String(format: "%.0f%%", level * 100)
        
        if (level * 100 < 4.0){
            save() // save run if baterry level is under 4%. Working JUST ON REAL DEVICE!!!
        }
        } else {
            print("WE ARE ON SIMULATOR")
        }
    }
    
    func resetUI(){ // reset UI labels, set variables to 0 and clear all arrays
        LM.stopUpdatingLocation()
        self.paceLabel.text = "00:00"
        self.timerLabel.text = "00:00"
        self.distanceLabel.text = "0.0"
        self.startBtn.isHidden = false
        paceSec = 0
        
        travelled = 0.0
        secDuration = 0
        temp = 0.0
        
        latPoints.removeAll()
        lonPoints.removeAll()
        locs.removeAll()
        secs.removeAll()
        
        map.removeOverlays(map.overlays)
        let lt = LM.location?.coordinate.latitude
        let lo = LM.location?.coordinate.longitude
        if lt != nil{ // set AL to current location to start counting distance from 0
            let nl = CLLocation(latitude: lt!, longitude: lo!)
            AL = nl
        }
    }
    
    
    
    
    /*---------------3-------------------------------------FINISH AND SAVE TO CORE DATA--------------------------------------------------*/
    @objc func finish(sender:UIButton!){
        createAlert()
    }
    
    func createAlert(){
        let ac = Alert()
        
        self.LM.stopUpdatingLocation()
        timer!.invalidate()
        // paceTimer!.invalidate()
        
        let finish = UIAlertAction(title: "OK", style: .default) { (action) in
            self.LM.stopUpdatingLocation()
            self.timer?.invalidate()
            // self.paceTimer?.invalidate()
            self.save()
            self.tabBarController?.selectedIndex = 1
        }
        
        let carryon = UIAlertAction(title: "Not yet", style: .default) { (action) in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
            self.LM.startUpdatingLocation()
            self.AL = self.LM.location! // magic happens here
            
        }
        
        ac.show(on: self, title: "Finish ?", messsage: "Are you sure", actions: [finish, carryon])
    }
    
    
    func save(){
        let distkm = travelled / 1000
        let dist = String(distkm)
        let dur = Int(secDuration)
        let coord = getCoord()
        let day = getDate()
        
        if Double(distkm) != 0.000000 && dur != 0 {
            let run = Run(date: day, distance: dist, location: fillinloc, weather: fillinweather, lat: coord.0, lon: coord.1, duration: dur, laps: secs, latPoints: latPoints, lonPoints: lonPoints, latMarkers: latMarkers, lonMarkers:lonMarkers)
            let s = Saver(ename: "Activities", key: "runs", obj: run)
            s.save()
        }
        
    }
    
    
    func getCoord() -> (CLLocationDegrees, CLLocationDegrees) {
        let llat = AL.coordinate.latitude
        let llon = AL.coordinate.longitude
        return (llat, llon)
    }
    
    func getDate() -> String{
        formatter.dateFormat = "dd.MM.yyyy"
        var result = formatter.string(from: date)
        let cal = Calendar.current
        let hour = cal.component(.hour, from: date)
        let min = cal.component(.minute, from: date)
        if (min < 10){
            result += " \(hour):0\(min)"
        } else {
            result += " \(hour):\(min)"
        }
        
        return result
    }
    
    
    
    
    
    
    /*-------------------4----------------------------------------UPDATE LOCATION DATA--------------------------------------------------------*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        locs.append(locations[0]) // append current location to locations array and show user position on the map
        
        let location:CLLocation = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: span)
        self.map.setRegion(region, animated: true)
        
        
        
        // get points for the polyline from 2 locations save it to arrays and draw it
        if (locs.count > 1){
            let sourceIndex = locs.count - 1
            let destinationIndex = locs.count - 2
            
            let c1 = locs[sourceIndex].coordinate
            let c2 = locs[destinationIndex].coordinate
            var a = [c1, c2]
            
            latPoints.append(Double(c1.latitude))
            lonPoints.append(Double(c1.longitude))
            
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            self.map.add(polyline)
        }
        
        
        
        for location in locations { // get total travelled distance and write pace
            
            if location.horizontalAccuracy < 20 {
                if self.locations.count > 0 {
                    
                    
                    travelled += round(location.distance(from: AL))
                    
                    temp = (travelled).rounded() / 1000 // 0.43
                    temp = (100 * temp).rounded() / 100 // 0.43
                    
                    if (temp > limit){
                        adding = adding + 1000
                        writePace(temp: temp, adding: adding)
                        let coord = getCoord()
                        latMarkers.append(Double(coord.0))
                        lonMarkers.append(Double(coord.1))
                        limit = limit + 1
                    }
                    
                }
                
                let inv = travelled / 1000
                let value = Double(round(100 * inv) / 100)
                distanceString = String(value)
                self.distanceLabel.text = distanceString
                self.locations.append(location)
            }
        }
        
        
        // get weather and update "AL" with currrent location
        let cities = ["Cupertino", "Sunville", "Los Altos", "Los Altos Hills", "Redwood city", "Portola Valley"]
        getGeodata(lat: lat, lon: lon, supported: cities) // get city name and if supported, JSON Weather
        AL = CLLocation(latitude: lat, longitude: lon)
        
    }
    
    func writePace(temp: Double, adding:Int){
        secs.append(Int(paceSec))
    }
    
    
  
 
    
    
   
    
    func updateHR(){
      /*  // https://stackoverflow.com/questions/32493375/how-to-read-heart-rate-from-ios-healthkit-app-using-swift
        var healh = HKHealthStore()
        let sample = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        let q = HKObserverQuery(sampleType: sample!, predicate: nil) { (query, completion, error) in
            if error != nil {
            //    abort()
            }
            print("q \(query)")
            
        }
        
        healh.execute(q) */
    }
    
    
    
 
   

}


/*-------------------5----------------------------------------DRAW POLYLINE--------------------------------------------------------*/
extension ViewController{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 4
            return renderer
        }
        return MKPolylineRenderer()
    }
}
    






/*----------------------6----------------------------------- GET CITY NAME AND WEATHER -------------------------------------------------------*/
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
                    self.getWeatherData(location: solocation, supported: supported)
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
                    
                    self.fillinloc = location.uppercased()
                }
                    
                catch{
                    print("Processing failed")
                }
            }
            
        }
        
        task.resume()
        
    }
    
    @objc func gets(sender:UIButton!){
        self.present(MusicViewController(), animated: true, completion: nil)
    }
    
    @objc func switcho(sender: UIButton!){
        let ac = Sheet()
       
        let standard = UIAlertAction(title: "Normal", style: .default) { (action) in
           self.map.mapType = .standard
        }
        
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { (action) in
           self.map.mapType = .hybrid
        }
        
        let flyover = UIAlertAction(title: "FlyOver", style: .default) { (action) in
            self.map.mapType = .hybridFlyover
        }
        
        
        
       ac.show(on: self, title: "Map type", messsage: "Switch map type", actions: [standard, hybrid, flyover])
    }
    
    
   
    
    /*
     let health: HKHealthStore = HKHealthStore()
     let heartRateUnit:HKUnit = HKUnit(fromString: "count/min")
     let heartRateType:HKQuantityType   = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
     var heartRateQuery:HKSampleQuery?

     */
    
    
  
    
}





extension ViewController {
    
    func constrainUI(){
        
        // buttons
        let wensets = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 0)
        
        startBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: wensets, size: .init(width: 150, height: 50))
        startBtn.addTarget(self, action: #selector(self.start(sender:)), for:.touchUpInside)
        
        finishBtn.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: wensets, size: .init(width: 150, height: 50))
        finishBtn.addTarget(self, action: #selector(self.finish(sender:)), for:.touchUpInside)
        
        
        let qensest = UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 30)
        songsBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: qensest, size: .init(width: 40, height: 40))
        songsBtn.addTarget(self, action: #selector(self.gets(sender:)), for: .touchUpInside)
        let rec = UILongPressGestureRecognizer(target: self, action: #selector(self.switcho(sender:)))
        songsBtn.addGestureRecognizer(rec)
        
        
    
        
        
        // labels
        let dlinsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        distanceLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: dlinsets, size: .init(width: view.frame.width, height: 50))
        
        paceLabel.textAlignment = .center
        timerLabel.textAlignment = .center
        
        let linsets = UIEdgeInsets(top: 80, left: 30, bottom: 0, right: 30)
        labelsView.distribution = .fillEqually
        labelsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: linsets, size: .init(width: view.frame.width - 60, height: 30))
        
        // map
        let insets = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        map.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.bounds.width, height: 250))
        
    }
    
}





import UIKit
import CoreData
import MapKit


class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableView = UITableView()
    
    var progressVal = 0
    var runs = [Run]()
    var label = UILabel()
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addUI()
        constrainUI()
    }
    
    func addUI(){
        tableView.register(ActivityTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        label.text = "History"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        [tableView, label].forEach {view.addSubview($0)}
        
    }
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidAppear(_ animated: Bool) {
        fetchArray()
        tableView.reloadData()
    }
    
    func fetchArray()  {
        let res = Fetcher(ename: "Activities", key: "runs")
        runs = res.fetchR()
    }
    
    
    
    /*---------------2--------------------------------------------TABLE VIEW---------------------------------------------------------*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ActivityTableViewCell
        let curr = runs[indexPath.row]
        cell.updateUI(date: curr.date, distance: curr.distance, duration: curr.duration)
        print("D \(curr.distance)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let alert = UIAlertController(title: "Are you sure", message: "Do you really want to delete this activity?", preferredStyle: .alert)
            let delete = UIAlertAction(title: "Yes", style: .destructive) { (action) in
                let e = RowEraser(ename: "Activities", index: indexPath.row)
                e.erase()
                
                self.runs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .none)
                tableView.reloadData()
            }
            
            let dont = UIAlertAction(title: "No", style: .default) { (action) in
            }
            
            
            alert.addAction(delete)
            alert.addAction(dont)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let r = ActivityViewController()
        r.e = indexPath.row
        r.runs = runs
        tabBarController?.present(r, animated: true, completion: nil)
    }
}



extension HistoryViewController{
    
    func constrainUI(){
        
        let insets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        label.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: insets, size: .init(width: view.bounds.width, height: 30))
        
        let tinsets = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: tinsets, size: .init(width: view.bounds.width, height: 250))
    }
}





import UIKit
import MapKit
import CoreLocation


class ActivityViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    // varibles - 12 CLEAR CONSTRAINTS IF STH NOT SHOWING
    var dateLabel = UILabel()
    var distanceLabel = UILabel()
    var locationLabel = UILabel()
    var weatherLabel = UILabel()
    var durationLabel = UILabel()
    var paceLabel = UILabel()
    var speedLabel = UILabel()
    var datasView = UIStackView()
    var labelsView = UIStackView()
    var splitsBtn = ShareButton()
    var map = MKMapView()
    var weatherImgview = UIImageView()
    var navBar = UINavigationBar()
    var e = 0
    var runs = [Run]()
    
    
    func addUI(){
        splitsBtn.addTarget(self, action: #selector(showa), for: .touchUpInside)
        let rec = UILongPressGestureRecognizer(target: self, action: #selector(self.switcho(sender:)))
        splitsBtn.addGestureRecognizer(rec)
        splitsBtn.setTitle("S", for: [])
        view.addSubview(splitsBtn)
        navBar.backgroundColor = .white
        
        
        let back = UIButton()
        back.setTitle("<", for: [])
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(toShare))
        
        doneItem.tintColor = .black
        shareItem.tintColor = .black
        
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = shareItem
        navBar.setItems([navItem], animated: false)
        
        locationLabel.font = UIFont.boldSystemFont(ofSize: 50)
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        durationLabel.font = UIFont.boldSystemFont(ofSize: 25)
        paceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        datasView.distribution = .equalCentering
        datasView.axis = .horizontal
        datasView.addArrangedSubview(distanceLabel)
        datasView.addArrangedSubview(durationLabel)
        datasView.addArrangedSubview(paceLabel)
        
        
        let arr = ["DISTANCE", "DURATION", "PACE"]
        
        for t in arr{
            let label = UILabel()
            label.text = t
            label.font = UIFont.boldSystemFont(ofSize: 13)
            label.textColor = .gray
            label.textAlignment = .center
            labelsView.addArrangedSubview(label)
        }
        
        [navBar, map, locationLabel, datasView, labelsView, weatherImgview, splitsBtn].forEach {view.addSubview($0)}
    }
    
    @objc func toShare(){
        let obj = ShareViewController()
        obj.runs = runs
        obj.e = e
        self.present(obj, animated: true, completion: nil)
    }
    
    @objc func showa(){
        let spl = SplitsViewController()
        spl.runs = runs
        spl.e = e
        self.present(spl, animated: true, completion: nil)
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    /*-------------------1----------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        map.delegate = self
        addUI()
        updateUI()
        addMarkers()
        constrainUI()
    }
    
    
    
    /*-------------2----------------------------------------------UPDATE UI---------------------------------------------------------
     */
    func updateUI(){
        
        // 1 - set stackView
        datasView.distribution = .fillEqually
        labelsView.distribution = .fillEqually
        
        //  2
        dateLabel.text = runs[e].date
        distanceLabel.text = "\(runs[e].distance)"
        
        //  3
        let sec  = Int(runs[e].duration)
        let timeObj = Time(seconds: sec)
        let time = timeObj.createTime
        durationLabel.text = String(time)
        
        let paceobj = Pace(sec: Double(sec), dist: Double(runs[e].distance)!)
        paceLabel.text = "\(paceobj.getPace())/km"
        speedLabel.text = "\(paceobj.getKPH()) kph"
        
        if runs[e].location == ""{
            locationLabel.text = "unknown"
        } else {
            locationLabel.text = runs[e].location
            locationLabel.text = locationLabel.text?.lowercased()
            if locationLabel.text!.count > 12 {
                locationLabel.font = UIFont.boldSystemFont(ofSize: 40)
            }
        }
        
        
        // 4
        let weather = runs[e].weather
        let w = Extractor(text: weather)
        let res =  w.getw()
        if res != "no" {
            weatherImgview.image = UIImage(named: res)
        }
        
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
        addMarkers()
    }
    
    
    
    fileprivate func addMarkers(){
        for (i, _) in runs[e].lonMarkers.enumerated(){
            let lat = runs[e].latMarkers[i]
            let lon = runs[e].lonMarkers[i]
            
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let an = MKPointAnnotation()
            an.coordinate = coord
            an.title = "\(i + 1)"
            map.addAnnotation(an)
        }
    }
    
    
    
    /*------------------3------------------------------------GET POLYLINE POINTS----------------------------------------------------
     */
    fileprivate func renderPolyline() {
        let latp = runs[e].latPoints
        var a = [CLLocationCoordinate2D]()
        for (index, _) in latp.enumerated(){
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
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuse = "img"
        var anview = mapView.dequeueReusableAnnotationView(withIdentifier: reuse)
        
        if anview == nil {
            anview = MKAnnotationView(annotation: annotation, reuseIdentifier: reuse)
            anview?.canShowCallout = true
            anview?.image = UIImage(named: "anview.png")
        } else {
            anview?.annotation = annotation
        }
        return anview
    }
    
}

/*------------------5-----------------------------------------RENDER POLYLINE---------------------------------------------------------
 */
extension ActivityViewController{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline{
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = hex("#1abc9c")
            renderer.lineWidth = 4
            return renderer
        }
        return MKPolylineRenderer()
    }
    
    
    
    @objc func switcho(sender: UIButton!){
        let ac = Sheet()
        
        let standard = UIAlertAction(title: "Normal", style: .default) { (action) in
            self.map.mapType = .standard
        }
        
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { (action) in
            self.map.mapType = .hybrid
        }
        
        let flyover = UIAlertAction(title: "FlyOver", style: .default) { (action) in
            self.map.mapType = .hybridFlyover
        }
        
        ac.show(on: self, title: "Map type", messsage: "Switch map type", actions: [standard, hybrid, flyover])
    }
    
    func constrainUI(){
        
        // navBar
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.bounds.width, height: 20))
        
        // datasView
        [distanceLabel, durationLabel, paceLabel].forEach { $0.textAlignment = .center }
        
        
        let dinsets = UIEdgeInsets(top: 100, left: 20, bottom: 0, right: 0)
       datasView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: dinsets, size: .init(width: view.bounds.width, height: 80))
        
        let labinsets = UIEdgeInsets(top: 125, left: 20, bottom: 0, right: 0)
        labelsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: labinsets, size: .init(width: view.bounds.width, height: 80))
        
        
        // map
        let insets = UIEdgeInsets(top: 210, left: 0, bottom: 0, right: 0)
        map.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.bounds.width, height: 250))
        
        // locationLabel
        let linsets = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 0)
        locationLabel.anchor(top: navBar.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: linsets, size: .init(width: view.bounds.width, height: 53))
        
        
        let qensest = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30)
        splitsBtn.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: qensest, size: .init(width: 40, height: 40))
    }
}





import UIKit

class SplitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var tableView = UITableView()
    var chartView: UICollectionView!
    var overlayView = Overlay()
    var avg = 0.0
    var runs = [Run]()
    var distances = [String]()
    var times = [Int]() // in seconds
    var e = 0
    var mini = 0 // index of the fastest km
    var min = 0
    var values = [Double]()
    var should = 0
    var shoulds = [Bool]()
    var navBar = UINavigationBar()
    
    
    /*-------------------1----------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0) // just placeholder !!!
        chartView = UICollectionView(frame: rect, collectionViewLayout: layout)
        chartView.delegate = self
        chartView.dataSource = self
        chartView.register(GSplitCell.self, forCellWithReuseIdentifier: "GECell")
         chartView.backgroundColor = .clear
        view.addSubview(chartView)
        
        
        let back = UIButton()
        back.setTitle("<", for: [])
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        doneItem.tintColor = .black
        
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = UIColor.white
        view.addSubview(navBar)
        
        tableView.register(SplitCell.self, forCellReuseIdentifier: "SCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let sp = Splits(runs: runs, times: times, distances: distances, e: e)
        let res = sp.get()
        distances = res.dists
        times = res.times
        values = res.times.map {Double($0) / 100.0}
        
        let avg = res.avg
        print("avg \(avg)")
        overlayView.avg = avg
        
        view.addSubview(overlayView)
        
        constrainUI()
        
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let index = mark(times: times)
        
        for (i, _) in times.enumerated() {
            i == index ? shoulds.append(true) : shoulds.append(false)
        }
        
        tableView.reloadData()
    }
    
    func mark(times: [Int]) -> Int {
        var inx = 0
        if (times.count > 0){
            let min = times[0]
            for (i, _) in times.enumerated(){
                if (times[i] < min){
                    inx = i
                }
            }
        }
        
        return inx
    }
    
    
    func getMax() -> Double {
        var max = 0
        for val in times{
            if (val > max){
                max = val
            }
        }
        return Double(max)
    }
    
    
    
    
    /*-------------------2----------------------------------------COLLECTIONVIEW---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GECell", for: indexPath) as! GSplitCell
        let val = values[indexPath.row]
        cell.updateUI(val: Double(val))
        return cell
    }
    
    
    
    /*-------------------3----------------------------------------TABLEVIEW---------------------------------------------------------
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SCell", for: indexPath) as! SplitCell
        cell.updateUI(distance: distances[indexPath.row], duration: times[indexPath.row], mark: shoulds[indexPath.row])
        return cell
    }
}



extension SplitsViewController {
    func constrainUI(){
        
        // navBar               20, top: view.topAnchor
        let ninsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: ninsets, size: .init(width: view.bounds.width, height: 20))
        
        
        let chinsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        chartView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: chinsets, size: .init(width: view.bounds.width, height: 150))
        
        let insets = UIEdgeInsets(top: 270, left: 0, bottom: 0, right: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.bounds.width, height: 250))
        
        let rinsets = UIEdgeInsets(top: 270, left: 0, bottom: 0, right: 0)
        overlayView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: rinsets, size: .init(width: view.bounds.width, height: 250))
    }
}




class TrainingsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // var cv:UICollectionView!
    var chartsView:UICollectionView!
    var tableView = UITableView()
    
    
    // variables
    var runs = [Run]()
    var sum = 0.0
    var values = [Double]()
    let trainings = [Training(title: "Orange", goal: 2, done: 0, img: "orange-level.png"),
                     Training(title: "Green", goal: 100, done: 0, img: "green-level.png")
    ]
    
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */

    override func viewDidLoad() { // called just once
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(TTrainingCell.self, forCellReuseIdentifier: "TCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let layouta = UICollectionViewFlowLayout()
        layouta.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layouta.itemSize = CGSize(width: 60, height: 120) // * 2 ?
        layouta.scrollDirection = .horizontal
        
        let recta = CGRect(x: 0, y: 350, width: self.view.bounds.width, height: 180) // EVIL !!!!!!!
        chartsView = UICollectionView(frame: recta, collectionViewLayout: layouta)
        chartsView.delegate = self
        chartsView.dataSource = self
        chartsView.register(GraphCell.self, forCellWithReuseIdentifier: "GCell")
        chartsView.backgroundColor = UIColor.white
        [tableView, chartsView].forEach {view.addSubview($0)}
        constrainUI()
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRuns()
        chartsView.reloadData()
        sum = getSum()
    }
    
    func longest() -> Double {
        let getter = PBGetter(runs: runs)
        let res = getter.getMax()
        return res
    }
    
    func getSum() -> Double{
        let getter = RCounter(runs: runs)
        return getter.getCount()
    }
    
    func fetchRuns(){
        let res = Fetcher(ename: "Activities", key: "runs")
        runs = res.fetchR()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell") as! TTrainingCell
        let t = trainings[indexPath.row]
        cell.updateUI(name: t.title, badge: t.img, goal: t.goal, sum: sum)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    /*---------------2--------------------------------------------COLLECTION VIEW---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return runs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GCell", for: indexPath) as! GraphCell
        
        for sub in cell.subviews{
            sub.removeFromSuperview()
        }
        
        cell.updateUI(index: indexPath.row, runs: runs)
        return cell
    }
}




extension TrainingsViewController{
    func constrainUI(){        
        let ins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: ins, size: .init(width: view.bounds.width, height: 320))
    }
}




import UIKit
import CoreData
import CoreImage


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var imgView = UIImageView()
    var nameLabel = UILabel()
    var remlabel = UILabel()
    var progressLabel = UILabel()
    var deleteBtn = UIButton()
    var passBtn = UIButton()
    var goalLabel = UILabel()
    
    var v:Chart = Chart(frame: .init(x:0, y:0, width: 0, height: 0), angle: 0)
    
    // variables
    var i = 0
    var s = 0
    var users = [User]()
    var runs = [Run]()
    var total = 0.0
    var timer = Timer()
  // var navBar = UINavigationBar()
    var editb = UIButton()
    
    /*-------1------------------------------------------------- LIFECYCLE ------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetch()
        updateProgress()
        addUI()
        constrainUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        fetch()
        updateProgress()
    }
    
    @objc func toEdit(){
    self.present(EditProfileViewController(), animated: true, completion: nil)
    
    }
    @objc func edit(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func addUI(){
        
        // labels
        nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        nameLabel.textColor = hex("#1abc9c")
        nameLabel.textAlignment = .center
        progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // delete
        deleteBtn.addTarget(self, action: #selector(eraseData(sender:)), for: .touchUpInside)
        deleteBtn.setTitleColor(.red, for: [])
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        deleteBtn.setTitle("DELETE", for: [])
        
        passBtn.addTarget(self, action: #selector(change(sender:)), for: .touchUpInside)
        passBtn.backgroundColor = .clear
        
        imgView.frame = CGRect(x: (view.frame.width - 180) / 2, y: (view.frame.height - 180) / 5, width: 180, height: 180) // EVIL !!!
        imgView.layer.cornerRadius = 0.5 * imgView.bounds.size.width
        imgView.clipsToBounds = true
        imgView.alpha = 1.0

        editb.setTitle("EDIT", for: [])
        editb.addTarget(self, action: #selector(go(sender:)), for: .touchUpInside)
        remlabel.font = UIFont.boldSystemFont(ofSize: 23)
        goalLabel.textAlignment = .center
        goalLabel.font = UIFont.boldSystemFont(ofSize: 18)
        editb.setTitleColor(hex("#1abc9c"), for: [])
        [imgView, nameLabel, progressLabel, deleteBtn, passBtn, editb, remlabel, goalLabel].forEach {view.addSubview($0)}
    }
    
    
    
    @objc func go(sender:UIButton!){
        present(EditProfileViewController(), animated: true, completion: nil)
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func change(sender: UIButton!){
        let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.allowsEditing = false
        IMPC.sourceType = .photoLibrary
        present(IMPC, animated: true, completion: nil)
    }
    
    
  
    
    var goal = 200.0 // 300 3, etc....
    // var divide = 2.0
    
    func fetch(){
        
        // fetch runs
        let resa = Fetcher(ename: "Activities", key: "runs")
        runs = resa.fetchR()
        
        // fetch users
        let res = Fetcher(ename: "Users", key: "users") // type has to be User
        users = res.fetchU()
        
        if users.count > 0 {
            nameLabel.text = users[users.count - 1].name
            goal = users[users.count - 1].goal
           // divide = goal / 100.0
        } else {
            nameLabel.text = "User"
        }
        
        
        
        // fetch image
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
    
    /*-------2------------------------------------------------- UPDATE PROGRESS ------------------------------------------------------*/
    
    

    func updateProgress(){
       let sum = RCounter(runs: runs)
        total = sum.getCount()
        let res = Diff(valA: goal, valB: total)
        let diff = res.getDiff()
        print("TOTAL \(total)  GOAL \(goal)  diff \(diff) angle \(s)")
        goalLabel.text = "Your goal is \(goal.rounded())"
        let perc = Diff(valA: goal, valB: total)
        let p = perc.getAngle()
        let pr = perc.getPerc()
        addCircle(perc: p)
        
        if diff > 0 {
            remlabel.text = "\(pr)%"
        } else {
            remlabel.text = "Mission accomplished"
        }
    }
    
   
    func addCircle(perc: Double){
        v.angle = CGFloat(perc)
        view.addSubview(v)
    }
    
    
    /*-------3------------------------------------------------- CHANGE IMAGE ------------------------------------------------------*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        var final = img
        let data:NSData = UIImagePNGRepresentation(final)! as NSData // this will be cleared by new API :)
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
    
    
    /*-------4------------------------------------------------- ERASE DATA ------------------------------------------------------*/
    @objc func eraseData(sender: UIButton!) {
        
        let ac = Alert()
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let er = Eraser(ename: "Activities")
            let uer = Eraser(ename: "Users")
            // er.erase()
            // uer.erase()
            print("DO NOT WORRY - SAFE LOCK ACTIVE :)")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        })
        
        ac.show(on: self, title: "Are you sure?", messsage: "There 's no going back", actions: [delete, cancel])
    }
    
    
    
    func constrainUI(){
        
        
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        deleteBtn.anchor(top: nil, leading: nil , bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: insets, size: .init(width: view.bounds.width, height: 30))
        
        let nameinsets = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        nameLabel.anchor(top: imgView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: nameinsets, size: .init(width: view.bounds.width, height: 40))
        nameLabel.isUserInteractionEnabled = false
        
        let ase = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        goalLabel.anchor(top: imgView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: ase, size: .init(width: view.frame.width, height: 30))
        
        
        let pinsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        passBtn.anchor(top: imgView.topAnchor, leading: imgView.leadingAnchor, bottom: imgView.bottomAnchor, trailing: imgView.trailingAnchor, padding: pinsets, size: .init(width: 180, height: 30))
        
        
        let ainsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        editb.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: ainsets, size: .init(width: 80, height: 30))
      
        
        let onsets = UIEdgeInsets(top: 75, left: 80, bottom: 0, right: 0)
        v.anchor(top: imgView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: onsets, size: .init(width: view.frame.width, height: 200))
      
    
        let q = UIEdgeInsets(top: 160, left: 0, bottom: 0, right: 0)
        remlabel.anchor(top: v.centerYAnchor, leading: nil, bottom: nil, trailing: nil, padding: q, size: .init(width: view.frame.width, height: 20))
        remlabel.textAlignment = .center
        
    }
    
}





import UIKit
import Foundation
import CoreData

class EditProfileViewController: UIViewController {
    
    var nField = UITextField()
    var goalSlider = UISlider()
    var navBar = UINavigationBar()
    var saveb = UIButton()
    var goalLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addUI()
        constrainUI()
    }
    
    func addUI(){
        
        nField.placeholder = "Enter you name"
        nField.font = UIFont.boldSystemFont(ofSize: 30)
        navBar.backgroundColor = .white
        
        let back = UIButton()
        back.setTitle("<", for: [])
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
        // save
        saveb.setTitle("SAVE", for: [])
        saveb.setTitleColor(hex("#1abc9c"), for: [])
        saveb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        saveb.addTarget(self, action: #selector(self.save(sender:)), for: .touchUpInside)
        
        goalLabel.text = "What's your goal ?"
        goalLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        goalSlider.addTarget(self, action: #selector(self.inc(sender:)), for: .valueChanged)
        goalSlider.minimumValue = 1
        goalSlider.maximumValue = 1000
        goalSlider.tintColor = hex("#1abc9c")
        goalSlider.thumbTintColor = hex("#1abc9c")
        
        [navBar, nField, saveb, goalSlider, goalLabel].forEach{view.addSubview($0)}
    }
    
    
    @objc func inc(sender: UISlider!){
        print("val \(sender.value)")
        goalLabel.text = "\(Int(sender.value)) km"
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("No")
    }
    
    var gender = "male" // hardcoded
    var users = [User]()
    
    @objc func save(sender:UIButton!) {
        
        let name = (nField.text!).uppercased()
        let user = User(name: name, birth: "0", gender: gender, goal: Double(goalSlider.value))
        
        let us = USaver(ename: "Users", key: "users", obj: user)
        us.save()
        
        
        self.dismiss(animated: true, completion: nil)
    }
}


extension EditProfileViewController {
    func constrainUI(){
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.bounds.width, height: 20))
        
        // fields
        let insets = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        nField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.frame.width, height: 40))
        
        let oi = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        goalSlider.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: oi, size: .init(width: view.frame.width, height: 20))
        
        let sinsets = UIEdgeInsets(top: 280, left: 0, bottom: 0, right: 0)
        saveb.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: sinsets)
        
        let ginsets = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        goalLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: ginsets, size: .init(width: view.frame.width, height: 30))
        goalLabel.textAlignment = .center
        // top: view.topAnchor
    }
}





import UIKit

class ShareViewController: UIViewController, UITextViewDelegate {
    
    var textArea = UITextView()
    var navBar = UINavigationBar()
    var shareBtn = UIButton()
    var runs = [Run]()
    var obj:Run? = nil
    var e = 0
    
    /*-------1------------------------------------------------- LIFECYCLE ------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        obj = runs[e]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKB (_:)))
        self.view.addGestureRecognizer(tap)
        addUI()
        constrainUI()
    }
    
    func addUI(){
        textArea.layer.borderWidth = 2.0
        navBar.backgroundColor = UIColor.white
        
        let back = UIButton()
        back.setTitle("<", for: [])
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: nil, action: #selector(share))
        doneItem.tintColor = .black
        shareItem.tintColor = .black
        
        
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItem = shareItem
        navBar.setItems([navItem], animated: false)
        
        [navBar, textArea].forEach {view.addSubview($0)}
    }
    
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKB(_ sender: UITapGestureRecognizer){
        textArea.resignFirstResponder() // hide keyboard on outside tap
    }
    
    
    
    /*-------2------------------------------------------------- SHARE ------------------------------------------------------*/
    
    @objc func share(sender: UIButton!){
        let text = "\(runs[e].distance): \(textArea.text!) "
        let share = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
    
    
    func constrainUI(){
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.bounds.width, height: 30))
        
        let insets = UIEdgeInsets(top: 43, left: 0, bottom: 0, right: 0)
        textArea.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.frame.width, height: 200))
    }
    
}





import UIKit
import MediaPlayer
import AVFoundation

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate {
    
    var navBar = UINavigationBar()
    var tableView = UITableView()
    var player = AVAudioPlayer()
    var label = UILabel()
    var musicData = [MPMediaItem]()
    var times = [Int]()
    var timer = Timer()
    var sec = 0
    var e = 0 // index
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addUI()
        constrainUI()
    }
    
    func addUI(){
        navBar.backgroundColor = UIColor.white
        
        let back = UIButton()
        back.setTitle("<", for: [])
        
        let add = UIButton()
        add.setTitle("+", for: [])
        
        
        let navItem = UINavigationItem(title: "")
        let backItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        let addItem = UIBarButtonItem(title: "+", style: .plain, target: nil, action: #selector(pick))
        
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = addItem
        backItem.tintColor = .black
        addItem.tintColor = .black
        navBar.setItems([navItem], animated: false)
        
        tableView.register(MusicCell.self, forCellReuseIdentifier: "MCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        
        label.text = "Music"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        [label, navBar, tableView].forEach { view.addSubview($0) }
    }
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pick(){
        var picker: MPMediaPickerController?
        picker = MPMediaPickerController(mediaTypes: .music) // music
        picker?.delegate = self
        picker?.allowsPickingMultipleItems = true
        picker?.showsCloudItems = false
        present(picker!, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let fetcher = Fetcher(ename: "Songs", key: "songs")
        musicData = fetcher.fetchM()
        tableView.reloadData()
    }
    
    
    
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        musicData.removeAll()
        let er = Eraser(ename: "Songs")
        er.erase()
        
        for item in mediaItemCollection.items {
            let s = MSaver(ename: "Songs", key: "songs", obj: item)
            s.save()
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCell") as! MusicCell
        cell.imgView.image = UIImage(named: "music-icon.jpg")
        cell.textLabel?.text = musicData[indexPath.row].title!
        return cell
    }
    
    func getTimes(){
        for s in musicData{
            times.append(Int(s.playbackDuration))
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increase), userInfo: times[0], repeats: true)
        print("times \(times)")
    }
    
    
    
    @objc func increase() {
        // let info = timer.userInfo as! Int
        sec += 1
        print("C \(musicData.count)")
        print(sec)
        if sec == times[e]{
            sec = 0
            e += 1
            if e < musicData.count {
                play(index: e) // we must play from the first, else crash
            }
            
        }
    }
    // set the timer to first time, and when it ends, play the next song
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        play(index: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.0
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if musicData.count > 1{
            if event?.subtype == UIEventSubtype.motionShake {
                let rand = Int(arc4random_uniform(UInt32(musicData.count - 1)))
                play(index: rand) // when shaken not stired, play the song 007
            }
        }
    }
    
    
    
    func play(index: Int){
        do {
            try player = AVAudioPlayer(contentsOf: musicData[index].assetURL!)
            player.play()
            getTimes()
        }
        catch {
            
        }
    }
}




extension MusicViewController{
    func constrainUI(){
        
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: view.bounds.width, height: 20))

        // tableView
        let insets = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: insets, size: .init(width: view.bounds.width, height: 250))
        
        let lin = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        label.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: lin, size: .init(width: view.bounds.width, height: 30))
    }
}



