import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var its = [String]()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "MCell")
        t.frame = CGRect(x: 100, y: 20, width: view.frame.width, height: 200)
        return t
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    var i = 0
    
    lazy var btn: UIButton = {
        let b = UIButton()
        b.setTitle("NIB", for: [])
        b.setTitleColor(UIColor.green, for: [])
        b.addTarget(self, action: #selector(add(sender:)), for: .touchUpInside)
        b.frame = CGRect(x: 0, y: 100, width: 30, height: 30)
        return b
    }()
    
    @objc func add(sender: UIButton!){
        
        i += 1
        let item = "item \(i)"
        its.append(item)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return its.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCell", for: indexPath)
        cell.textLabel?.text = its[indexPath.row]
        return cell
    }
    

}
