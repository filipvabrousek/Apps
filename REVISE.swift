import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    @IBOutlet var label: UILabel!
    @IBOutlet var stopBtn: UIButton!
    @IBOutlet var startBtn: UIButton!
    var AL: CLLocation = CLLocation(latitude: 0, longitude: 0)
    var locations = [CLLocation]()
    var activities = [Activity]()
    let LM = CLLocationManager()
    var travelled = 0.0
    let formatter = DateFormatter()
 
    

    
    @IBAction func start(_ sender: Any) {
        // without timer, as simple as possible running app with permanent data storage
        LM.startUpdatingLocation()
        startBtn.isHidden = true
    }
    
   
    @IBAction func finish(_ sender: Any) {
    // create activity
    formatter.dateFormat = "dd.MM.yyyy"
    let date = formatter.string(from: Date())
    let distance = String(travelled)
    let obj = Activity(date: date, distance: distance)
    activities.append(obj)
    LM.stopUpdatingLocation()
   
    // save activity array to core data
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = delegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Activities", in: context)
    let device = NSManagedObject(entity: entity!, insertInto: context)
   // let data = NSKeyedArchiver.archivedData(withRootObject: activities)
    device.setValue(obj, forKey: "activityArray")
        
        do{
        try context.save()
        print("Saved successfully")
        }
        
        catch{
           print("Sth went wrong \(error)")
        }
        
    }
    
 
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[0]
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: map.userLocation.coordinate, span: span)
        
        self.map.setRegion(region, animated: true)
        
        
        
        for location in locations{
            if location.horizontalAccuracy < 20{
                
                if self.locations.count > 0{
                    travelled += round(location.distance(from: AL))
                }
                self.label.text = String(travelled / 1000)
                self.locations.append(location)
                print(travelled / 1000)
            }
        }
        
        AL = CLLocation(latitude: lat, longitude: lon)
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up location manager
        LM.delegate = self
        LM.desiredAccuracy = kCLLocationAccuracyBest
        LM.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        map.mapType = MKMapType.standard
        map.delegate = self
    }

}








import Foundation

class Activity: NSObject, NSCoding{
   
    
    struct Keys {
        static let date = "date"
        static let distance = "distance"
    }
    
    private var _date = ""
    private var _distance = ""
    
    
    override init(){}
    
    init(date: String, distance: String){
    self._date = date
    self._distance = distance
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        if let dateObject = aDecoder.decodeObject(forKey: Keys.date) as? String{
            _date = dateObject
        }
        
        if let distObject = aDecoder.decodeObject(forKey: Keys.distance) as? String{
        _distance = distObject
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_date, forKey: Keys.date)
        aCoder.encode(_distance, forKey: Keys.distance)
    }
    
    var date:String{
        get{
            return _date
        }
        
        set{
            _date = newValue
        }
    }
    
    var distance: String{
        get{
            return _distance
        }
        
        set{
            _distance = newValue
        }
    }
    
}





import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fetched = [Activity]()
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchData()
        return fetched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = fetched[indexPath.row].distance
        return cell
    }
    

    
   
    func fetchData(){
        fetched.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activities")
        request.returnsObjectsAsFaults = false
        
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0{
                for res in results as! [NSManagedObject] {
                    if let run = res.value(forKey: "activityArray") as? Activity{
                        fetched.append(run)
                    }
                }
            }
        }
            
        catch{
            print("\(error) err")
        }
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
