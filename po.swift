//
//  RaceController.swift
//
//
//  Created by Filip Vabroušek on 28/08/2018.
//


import UIKit
import Firebase


class RaceController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let supported = ["Horska Vyzva", "Moraviaman", "Oravaman"]
    
    var user:User?
    
    var results = [Result]()
    
    var ress = "" // rom JSON
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "MCell")
        return t
    }()
    
    
    
    
    
    var label:UILabel = {
        let l = UILabel()
        l.text = "Find your race"
        l.font = UIFont.boldSystemFont(ofSize: 19)
        return l
    }()
    
    var navBar: UINavigationBar = {
        var n = UINavigationBar()
        n.backgroundColor = .white
        
        let back = UIButton()
        back.setTitle("<", for: [])
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "<", style: .plain, target: nil, action: #selector(make))
        doneItem.tintColor = .black
        
        
        navItem.leftBarButtonItem = doneItem
        
        n.setItems([navItem], animated: false)
        n.backgroundColor = hex("#f7f8f8")
        return n
    }()
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // fetch the users prefernce
        let ur = Fetcher(ename: "Users", key: "users")
        let r = ur.fetchU()
        print(r.count)
        
        if r.count > 0 {
            user = r[r.count - 1]
            fetchu(location: user!.location)
        }
        
        
        if user != nil {
            print("I am \(user!.sport) from \(user!.location)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func cb(data:String){
        print("LCO \(results[0].location)")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [label, tableView, navBar].forEach {view.addSubview($0)}
        constrainUI()
    }
    
    
    // get results array from JSON
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NRC \(results.count)")
        return results.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCell", for: indexPath) // as! MatchCell
        let r = results[indexPath.row]
        print("RQ \(r)")
        // cell.updateUI(name: r.name, location: r.location, time1: r.time1, time2: nil)
        cell.textLabel?.text = r.location
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = results[indexPath.row].name
        let ac = Alert()
        
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) in
            print("Send confirmation email")
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel) { (action) in
            print("No")
        }
        
        ac.show(on: self, title: "Are you sure ?", messsage: "Do you really \(name) to contact you ? ", actions: [ok, cancel])
    }
    
    
    
    
}



extension RaceController{
    
    
    
    func fetchu(location: String)  {
        
        /*
         
         {
         "Zlin":"Horska Vyzva",
         "Otrokovice":"Triatlon",
         "Prague":"Oravaman"
         }
         */
        
        
        var ret = ""
        
        let urlc = URL(string: "https://cdn.rawgit.com/filipvabrousek/Swift-apps/9132fc55/races.json")
        
        
        
        let task = URLSession.shared.dataTask(with: urlc!) { (data, response, error) in
            if error != nil {
                print(error)
            }
            
            if let content = data {
                do {
                    
                    
                    let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
                    
                    
                    if self.supported.contains(location){
                        print("inide res \(location)")
                        ret = res[location] as! String
                        let res = Result(name: "DW", location: ret, time1: 0)
                        self.results.append(res)
                        
                        print(" I HAVE A RACE FOR YOU IN \(ret)")
                    } else {
                        ret = "N/A"
                    }
                }
                    
                catch {
                    
                }
            }
        }
        
        task.resume()
        
    }
    
    
}


