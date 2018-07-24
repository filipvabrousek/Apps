
## CollectionView
```swift
import UIKit
import CoreGraphics
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var cv:UICollectionView! // NO var vc = UICollectionView() -> would be ERROR  !!!!
    
    let arr = ["Filip", "Sara", "Kaja", "Maja", "Paja", "Aja"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        
        let rect = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 90)
        cv = UICollectionView(frame: rect, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        cv.backgroundColor = UIColor.gray
        
        view.addSubview(cv)
        
 
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
```
    
    
## NavigationController
```swift
    
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        return true
    }
    ......
    
```
    
    
```swift
import UIKit

class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addBtn()
    }
    
    func addBtn(){
        let btn = UIButton()
        btn.frame = CGRect(x: 10, y: 80, width: 100, height: 20)
        btn.backgroundColor = UIColor.green
        btn.setTitle("to Another", for: [])
        btn.addTarget(self, action: #selector(toAnother(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func toAnother(sender: UIButton!){
       navigationController?.pushViewController(AnotherViewController(), animated: true)
    }
}


class AnotherViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
} 
    
```
