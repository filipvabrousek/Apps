//
//  SignUpController.swift
//  Sportify
//
//  Created by Filip Vabroušek on 28/08/2018.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase

class SignController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let supported = ["Zlin", "Otrokovice", "Prague"]
    var new = [Result]()
    var results = [Result]()
    var raceids = [String]() // because conceating
    var idx = -1
    var already = [Int]()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "RACell")
        // t.frame = CGRect(x: 0, y: 290, width: view.frame.width, height: 180)
        return t
    }()
    
    
    let lbl: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 38)
        l.text = "Sign up"
        return l
    }()
    
    let picklabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.textAlignment = .center
        l.text = "Pick any amount of races you would like to participate in"
        return l
    }()
    
    let nfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.font = UIFont.boldSystemFont(ofSize: 21)
        f.placeholder = "Enter your email"
        return f
    }()
    
    let pfield: UITextField = {
        let f = UITextField()
        f.autocapitalizationType = .none
        f.font = UIFont.boldSystemFont(ofSize: 21)
        f.placeholder = "Enter your password"
        return f
    }()
    
    
    
    
    let swimfield: UITextField = {
        let f = UITextField()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        f.placeholder = "Enter your current 1k swimming best time"
        return f
    }()
    
    let runfield: UITextField = {
        let f = UITextField()
        f.font = UIFont.boldSystemFont(ofSize: 21)
        f.placeholder = "Enter your current 10k running best time"
        return f
    }()
    
    lazy var sbtn: UIButton = {
        let b = UIButton()
        b.setTitle("SIGNUP", for: [])
        b.addTarget(self, action: #selector(signup(sender:)), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.frame = CGRect(x: 30, y: 30, width: 120, height: 30)
        return b
    }() //
    
    
    lazy var tologin: UIButton = {
        let b = UIButton()
        b.setTitle("LOG IN", for: [])
        b.addTarget(self, action: #selector(skip(sender:)), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.frame = CGRect(x: 30, y: 30, width: 120, height: 30)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = hex("#3498db")
        self.navigationController?.navigationBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismisso))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        tableView.reloadData() // xx
        [sbtn, tologin, nfield, pfield,  swimfield, runfield, lbl, picklabel, tableView].forEach {view.addSubview($0)}
        constrainUI()
    }
    
    
    @objc func dismisso(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func signup(sender: UIButton!){
        print("sgn")
        
        let email = nfield.text!
        let pswd = pfield.text!
        
        let stime = swimfield.text!
        let rtime = runfield.text!
        
        Auth.auth().createUser(withEmail: email, password: pswd) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                let uid = Auth.auth().currentUser?.uid
                let ref = Database.database().reference()
                
                var r = ""
                if self.new.count > 0 {
                    r = self.new[0].location
                } else {
                    r = "no"
                }
                
                var str = ""
                for val in self.raceids{
                   str.append(val + "x")
                }
                
                let data = ["email": email, "password": pswd, "rtime":rtime, "stime":stime, "race": r, "ids": str]
                ref.child("Users").child(uid!).setValue(data)
                
                sender.titleLabel?.text = "↓"
                sender.removeTarget(self, action: #selector(self.signup), for: .touchUpInside)
            }
        }
        
    }
    
    
    @objc func login(sender: UIButton!){ // CONSTRAIN
        present(LogController(), animated: true, completion: nil)
    }
    
    @objc func skip(sender: UIButton!){
        self.present(LogController(), animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        /* for r in results {
         print("\(r.location)")
         }*/
        
       // tableView.reloadData()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        for l in supported{
            fetchu(location: l)
        }
        
        
    }
    
    
    
    func getData(){
        new.removeAll()
        for i in already {
            new.append(results[i])
        }
        print(new.count)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RACell", for: indexPath)
        
        if idx == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = results[indexPath.row].location
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   
        if raceids.contains("\(indexPath.row)"){
              tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
            
            let id = raceids.index(of: "\(indexPath.row)")
            raceids.remove(at: id!)
        } else {
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
            raceids.append("\(indexPath.row)")
        }
        
        
        
        
        
        idx = indexPath.row
        
       // let item = results[indexPath.row]
       // print("TAP \(item.location)")
       
        let r = DetailController()
        r.rtitle.text = results[indexPath.row].location
        present(r, animated: true, completion: nil)
    }
    
    
    
}



extension SignController {
    func fetchu(location: String)  {
        
        /*
         
         {
         "Zlin":"Horska Vyzva",
         "Otrokovice":"Triatlon",
         "Prague":"Oravaman"
         }
         */
        
        
        var ret = ""
        
        // let urlc = URL(string: "https://cdn.rawgit.com/filipvabrousek/Swift-apps/9132fc55/races.json")
        
        let urlc = URL(string: "https://rawgit.com/filipvabrousek/Swift-apps/master/racesf.json")
        
        let task = URLSession.shared.dataTask(with: urlc!) { (data, response, error) in
            if error != nil {
                print(error)
            }
            
            if let content = data {
                do {
                    
                    let res = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
                    ret = res[location] as! String
                    let resa = Result(name: "DW", location: ret, time1: 0)
                    self.results.append(resa)
                    
                    print(" I HAVE A RACE FOR YOU IN \(ret)")
                    
                }
                    
                catch {
                    
                }
            }
        }
        
        //  print("OP \(self.results[0].location)")
        
        task.resume()
        
    }
}

