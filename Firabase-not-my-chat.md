# Chat

## User
```swift

import Foundation
import FirebaseAuth

struct User {
    let uid:String
    let email:String
    
    init(userData:FIRUser) {
        uid = userData.uid
        
        if let mail = userData.providerData.first?.email {
            email = mail
        }else{
            email = ""
        }
    }
    
    init (uid:String, email:String) {
        self.uid = uid
        self.email = email
    }
}

```


##  Sweet
```swift
//
//  Sweet.swift
//  Chaty
//
//  Created by Filip Vabroušek on 15.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import Foundation
import FirebaseDatabase



struct Sweet {
    
    let key:String!
    let content:String!
    let addedByUser:String!
    let itemRef:FIRDatabaseReference?
    
    init (content:String, addedByUser:String, key:String = "") {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    
    init (snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        
        let contentValue = snapshot.value as? NSDictionary
        if let eventContent = contentValue!["content"] as? String {
            content = eventContent
        } else {
            content = ""
        }
        let eventUserValue = snapshot.value as? NSDictionary
        if let eventUser = eventUserValue!["addedByUser"] as? String {
            addedByUser = eventUser
        } else {
            addedByUser = ""
        }
        
        
    }
    
    func toAnyObject() -> Any {
        return ["content":content, "addedByUser":addedByUser]
    }
    
}

```


## Sweet-VC

```swift
//
//  SweetTableViewController.swift
//  Chaty
//
//  Created by Filip Vabroušek on 15.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SweetTableViewController: UITableViewController {
    
    
    var dbRef:FIRDatabaseReference!
    var sweets = [Sweet]()
    
    
    
    //---------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("sweet-items")
        startObservingDB()
    }
    
    //---------------------------------------------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth:FIRAuth, user:FIRUser?) in
            if let user = user {
                print("Welcome \(user.email)")
                self.startObservingDB()
            }else{
                print("You need to sign up or login first")
            }
        })
        
    }
    
    
    
    //---------------------------------------------------------------------------------
    
    @IBAction func loginAndSignup(_ sender: Any) {
        
        let userAlert = UIAlertController(title: "Login/Sign up", message: "Enter email and password", preferredStyle: .alert)
        userAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "email"
        }
        userAlert.addTextField { (textfield:UITextField) in
            textfield.isSecureTextEntry = true
            textfield.placeholder = "password"
        }
        
        
        userAlert.addAction(UIAlertAction(title: "Log up", style: .default, handler: { (action) in
            let emailTextField = userAlert.textFields!.first!
            let passwordTextField = userAlert.textFields!.last
            
            
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: (passwordTextField?.text!)!, completion: nil)
        }))
        
        
        
        userAlert.addAction(UIAlertAction(title: "Sign up", style: .default, handler: { (action) in
            let emailTextField = userAlert.textFields!.first!
            let passwordTextField = userAlert.textFields!.last
            
            
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: (passwordTextField?.text!)!, completion: nil)
        }))
        
        
        
        
        
        
        self.present(userAlert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    //---------------------------------------------------------------------------------
    func startObservingDB () {
        dbRef.observe(.value, with: { (snapshot:FIRDataSnapshot) in
            var newSweets = [Sweet]()
            
            for sweet in snapshot.children {
                let sweetObject = Sweet(snapshot: sweet as! FIRDataSnapshot)
                newSweets.append(sweetObject)
            }
            
            self.sweets = newSweets
            self.tableView.reloadData()
            
        })
    }
    
    
    
    
    
    
    //---------------------------------------------------------------------------------
    
    @IBAction func send(_ sender: Any) {
        let sweetAlert = UIAlertController(title: "New Sweet", message: "Enter your Sweet", preferredStyle: .alert)
        sweetAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Your sweet"
        }
        
        sweetAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
            if let sweetContent = sweetAlert.textFields?.first?.text {
                let sweet = Sweet(content: sweetContent, addedByUser: "BrianAdvent")
                let sweetRef = self.dbRef.child(sweetContent.lowercased())
                sweetRef.setValue(sweet.toAnyObject())
            }
        }))
        
        self.present(sweetAlert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sweets.count
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        let sweet = sweets[indexPath.row]
        cell.textLabel?.text = sweet.content
        cell.detailTextLabel?.text = sweet.addedByUser
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            let sweet = sweets[indexPath.row]
            sweet.itemRef?.removeValue()
        }
    }
    
}

```

![https://www.youtube.com/watch?v=D0MuaFzoxng]
