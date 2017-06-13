/*
To AppDelegate.swift

.....
 let parseConfiguration = ParseClientConfiguration(block: { (ParseMutableClientConfiguration) -> Void in
            ParseMutableClientConfiguration.applicationId = "d1f30021912548bb071a0c355267c9c5e0cf0d38"
            ParseMutableClientConfiguration.clientKey = "1c8a2cf0734cdd1266c14db64641a0c3e17f29e4"
            ParseMutableClientConfiguration.server = "http://ec2-52-205-253-70.compute-1.amazonaws.com:80/parse"
        })


*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    
    /*                                          CREATE ALERT                                      */
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    
    /*                                         SIGN UP OR LOGIN                                   */
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            createAlert(title: "Error in form", message: "Please enter an email and password")
            
        } else {
            
                activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents() // UIApplication.shared() is now UIApplication.shared
            
            if signupMode {
                
                // -----Sign Up
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now  UIApplication.shared
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        let error = error as NSError?
                        if let errorMessage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        
                       self.performSegue(withIdentifier: "showUserTable", sender: self)
                        print("user signed up")
                    
                    }
                    
                    
                })
                
                
            } else {
                
                // -----Login mode
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now  UIApplication.shared
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        let error = error as NSError?
                        if let errorMessage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                    } else {
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        print("Logged in")
                        
                    }
                    
                    
                })
                
                
            }
            
            
            
        }
        
        
        
    }
    
    @IBOutlet var signupOrLogin: UIButton!
    
    
    
    /*                                         VIEWDIDAPPEAR                                     */
    
    override func viewDidAppear(_ animated: Bool){
        if PFUser.current() != nil{
            performSegue(withIdentifier: "toUserTable", sender: self)
            self.navigationController?.navigationBar.isHidden = true
        }
    }

    
    
    
    
    /*                                          CHANGE SIGNUP MODE                                      */
    
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        
        
        
        
        if signupMode {
            
            // Change to login mode
            
            signupOrLogin.setTitle("Log In", for: [])
            changeSignupModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
            signupMode = false
            
        } else {
            
            // Change to signup mode
            
            signupOrLogin.setTitle("Sign Up", for: [])
            changeSignupModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
            signupMode = true
            
        }
        
    }
    
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var changeSignupModeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}












//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 18.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    var usernames = [""]
    var userIDs = [""]
    var isFollowing = ["": false]
    
    var refresher: UIRefreshControl!
    
    /*                                          LOGOUT                                     */
    
    @IBAction func logout(_ sender: Any) {
        
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    /*                                          REFRESH    (get usernames)                                */
    func refresh(){
        
        let query = PFUser.query()
        query?.findObjectsInBackground(block: { (objects, error) in
            
            
            if error != nil{
                print("Error")
                
                
                
            } else if let users = objects {
                
                self.usernames.removeAll()
                self.userIDs.removeAll()
                self.isFollowing.removeAll()
                
                for object in users{
                    
                    if let user = object as? PFUser{
                        
                        if user.objectId != PFUser.current()?.objectId{
                            
                            
                            
                            
                            let userNameArray = user.username?.components(separatedBy: "@")
                            self.usernames.append(userNameArray![0])
                            self.userIDs.append(user.objectId!)
                            
                            let query = PFQuery(className:"Followers")
                            
                            
                            query.whereKey("followers", equalTo: (PFUser.current()?.objectId)!)
                            query.whereKey("follow", equalTo: user.objectId!)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                
                                if let objects = objects{
                                    
                                    if objects.count > 0{
                                        
                                        self.isFollowing[user.objectId!] = true
                                        
                                    } else {
                                        
                                        self.isFollowing[user.objectId!] = false
                                    }
                                    
                                    //---Reload data and end refreshing
                                    if self.isFollowing.count == self.usernames.count{
                                        self.tableView.reloadData()
                                        self.refresher.endRefreshing()
                                    }
                                }
                            })
                        }
                    }
                }
                
            }
            
            
        })
        
        
    }
    
    /*                                          call REFRESH                                     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector (UserTableViewController.refresh), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    
    
    
    
    
    
    
    /*                                          COUNT EM ALL!                                      */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }
    
    
    
    /*                                          FILL-IN CELLS                                     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = usernames[indexPath.row]
        
        
        if isFollowing[userIDs[indexPath.row]]!{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
        }
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*                                          DID SELECT ROW (react on row tap (follow / unfollow))                                    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        
        if isFollowing[userIDs[indexPath.row]]!{
            
            isFollowing[userIDs[indexPath.row]]! = false
            
            
            cell?.accessoryType = UITableViewCellAccessoryType.none
            let query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)
            query.whereKey("following", equalTo: userIDs[indexPath.row])
            
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let objects = objects{
                    
                    for object in objects{
                        object.deleteInBackground()
                    }
                    
                }
            })
            
        } else {
            
            isFollowing[userIDs[indexPath.row]]! = true
            
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            
            let following = PFObject(className: "followers")
            
            following["followers"] = PFUser.current()?.objectId
            following["following"] = userIDs[indexPath.row]
            following.saveInBackground()
        }
        
    }
    
    
}












//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Petr on 19.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var AI = UIActivityIndicatorView()
    
    @IBOutlet var imageToPost: UIImageView!
    
    
    /*                                          CHOOSE AN IMAGE                                     */
    
    @IBAction func chooseImage(_ sender: Any) {
        let IP = UIImagePickerController()
        IP.delegate = self
        IP.sourceType = UIImagePickerControllerSourceType.photoLibrary
        IP.allowsEditing = false
        
        self.present(IP, animated:true, completion: nil)
        
        
    }
    
    /*                                          IMPC - didFinishPacking.....                                   */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*                                              CREATE ALERT                                     */
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var messageField: UITextField!
    
    
    
    
    /*                                                  POST AN IMAGE                                     */
    
    @IBAction func postImage(_ sender: Any) {
        
        
        AI = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        AI.center = self.view.center
        AI.hidesWhenStopped = true
        AI.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(AI)
        AI.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //---define post
        let post = PFObject(className: "Posts")
        post["message"] = messageField.text
        post["userId"] = PFUser.current()?.objectId!
        
        
        //---define image data
        let imageData =  UIImagePNGRepresentation(imageToPost.image!)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        post["imageFile"] = imageFile
        
        
        
        
        //---Save
        post.saveInBackground{ (success, error) in
            
            self.AI.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil{
                self.createAlert(title: "Could not post an image", message: "Please try again later")
            } else {
                
                self.createAlert(title: "Image posted", message: "Image has been posted successfully")
                self.messageField.text = ""
                self.imageToPost.image = UIImage(named: "eset_user.png")
            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}














// 2 ERRORS!!!!!!
//  FeedTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 19.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    
    var users = [String: String]()
    var messages = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    
    
    /*                                              FILL IN FEED                            */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---get user query
        var query = PFUser.query()
        query?.findObjectsInBackground(block: { (objects, error) in
            if error != nil{
                print(error)
            }
            
            if let users = objects{
                self.users.removeAll()
                
                for object in users{
                    
                    if let user = object as? PFUser{
                        self.users[user.objectId!] = user.username!
                        
                    }
                }
                
            }
            
            
            
            //---get followed user query
            let getFollowedUserQuery = PFQuery(className: "Followers")
            getFollowedUserQuery.whereKey("followers", equalTo: (PFUser.current()?.objectId)!)
            
            getFollowedUserQuery.findObjectsInBackground(block: { (objects, error) in
                if let followers = objects{
                    
                    for object in followers {
                        
                        if let follower = objects {
                            
                            let followedUser = follower["following"] as! String
                            
                            let query = PFQuery(className: "Posts")
                            query.whereKey("userId", equalTo: followedUser)
                            query.findObjectsInBackground(block: { (objects, errror) in
                                
                                if let posts = objects{
                                    
                                    for object in posts{
                                        
                                        if let post = object as? PFObject{
                                            
                                            self.messages.append(post["message"] as! String)
                                            self.imageFiles.append(object["imageFile"] as! PFFile)
                                            self.usernames.append(self.users[posts["userId"] as! String]!)
                                            
                                            self.tableView.reloadData()
                                        }
                                    }
                                    
                                    
                                }
                            })
                            
                        }
                        
                        
                    }
                    
                }
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    /*                                  COUNT EM ALL                        */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    /*                                  FILL-IN FEED CELLS              */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let downloadedImage = UIImage(data: imageData){
                    
                    cell.postedImage.image = downloadedImage

                }
            }
            
        }
        
        cell.postedImage.image = UIImage(named: "a.png")
        cell.usernameL.text = usernames[indexPath.row]
        cell.messageL.text = messages[indexPath.row]
        
        return cell
    }
    
    
}

