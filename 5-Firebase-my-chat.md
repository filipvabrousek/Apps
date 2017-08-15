# Chat
1) Add bundleID to Firebase
2) add ```plist``` Google file
1) ```pod init```
2) ```add "Firebase/Database"```, etc to the new PodFile
3) ```pod install```
4) open the ```.xcworkspace``` project



```swift
import Foundation
import UIKit


class Helper {

static let helper = Helper()
    

func switchToNavVC() {

let storyboard = UIStoryboard(name: "Main", bundle: nil)
let vc = storyboard.instantiateViewController(withIdentifier: "profileVC") as! UINavigationController
let appDelegate = UIApplication.shared.delegate as! AppDelegate
appDelegate.window?.rootViewController = vc


}

}
```

# VC
```swift

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseAnalytics

class ViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        login()
    }
    
    
    
    @IBAction func signupPressed(_ sender: Any) {
        signup()
    }
    
    
    
    
    
    
    func login(){
        if usernameField.text != "" && emailField.text != "" && passwordField.text != ""{
            FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { user, error in
                
                if error != nil{
                    print(error?.localizedDescription)
                } else {
                    Helper.helper.switchToNavVC()
                    
                    
                }
            })
            
        } else {
            // do something later
            
        }
        
    }
    
    
    func signup(){
        if usernameField.text != "" && emailField.text != "" && passwordField.text != ""{
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
                
                user, error in
                
                
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    
                    let uid = FIRAuth.auth()?.currentUser?.uid
                    let databaseRef = FIRDatabase.database().reference()
                    
                    
                    let userData: [String: Any] = ["email" : self.emailField.text!, "uid": uid, "username": self.usernameField.text!]
                    
                    databaseRef.child("Users").child(uid!).setValue(userData)
                    Helper.helper.switchToNavVC()
                }
                
                
                
            })
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        FIRAuth.auth()?.addStateDidChangeListener( {
            auth, user in
            
            
            
            if user != nil {
                
                Helper.helper.switchToNavVC()
            } else {
                // Do whatewer you want
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



```

# Chat VC
```swift
//
//  ChatViewController.swift
//  Chat
//
//  Created by Filip Vabroušek on 14.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



struct Post{
    
    let bodyText:String
}


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var messageText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var posts = [Post]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        let database = FIRDatabase.database().reference()
        database.child("Posts").child(currentUserChatID).queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            
            let bodyText = (snapshot.value as? NSDictionary)?["bodyText"] as? String ?? ""
            self.posts.insert(Post(bodyText: bodyText), at: 0)
            self.tableView.reloadData()
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func send(_ sender: Any) {
        if messageText.text != ""{
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            let database = FIRDatabase.database().reference()
            let bodyData : [String : Any] = ["uid": uid!, "bodyText": messageText.text!]
            database.child("Posts").child(currentUserChatID).childByAutoId().setValue(bodyData)
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let bodyText = cell.viewWithTag(1) as! UITextView
        bodyText.text = posts[indexPath.row].bodyText
        return cell
    }
}



```


# Table VC
```swift
//
//  TableViewController.swift
//  Chat
//
//  Created by Filip Vabroušek on 14.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase


var currentUserChatID = String()

struct User {
    let username: String!
    let uid:String!
    
    
}


class TableViewController: UITableViewController {
    
    
    
    var  users = [User]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let database = FIRDatabase.database().reference()
        database.child("Users").queryOrderedByKey().observe(.childAdded, with:{
            
            snapshot in
            let username = (snapshot.value as? NSDictionary)?["username"] as? String ?? ""
            let uid = (snapshot.value as? NSDictionary)?["username"] as? String ?? ""
            self.users.append(User(username: username, uid: uid))
            self.tableView.reloadData()
        })
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentUserChatID = users[indexPath.row].uid
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let usernameField = cell.viewWithTag(1) as! UILabel
        usernameField.text = users[indexPath.row].username
        
        return cell
    }
    
    
    
}


```
