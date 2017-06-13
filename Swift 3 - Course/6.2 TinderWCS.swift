/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signupOrLoginButton: UIButton!
    @IBOutlet var changeSignupModeButton: UIButton!
    
    
    
    
    /*                              SIGN UP OR LOG IN                           */
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        //SIGN UP
        if signupMode {
            
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            
            //allows to write a user
            let ACL = PFACL()
            ACL.getPublicReadAccess = true
            user.acl = ACL
            
            
            user.signUpInBackground { (success, error) in
                
                if error != nil {
                    
                    var errorMessage = "Signup failed - please try again"
                    let error = error as! NSError
                    
                    if let parseError = error.userInfo["error"] as? String {
                        errorMessage = parseError
                    }
                    self.errorLabel.text = errorMessage
                    
                } else {
                    print("Signed up")
                }
                
                
            }
            
        } else {
            
            //LOG IN
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                
                
                if error != nil {
                    var errorMessage = "Signup failed - please try again"
                    let error = error as NSError?
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        errorMessage = parseError
                    }
                    
                    self.errorLabel.text = errorMessage
                    
                } else {
                    
                    print("Logged In")
                    self.performSegue(withIdentifier: "toUserInfo", sender: self)
                }
                
            })
            
        }
        
    }
    
    
    /*                                             CHANGE SIGN UP MODE                             */
    @IBAction func changeSignupMode(_ sender: AnyObject) {
        
        if signupMode {
            signupMode = false
            signupOrLoginButton.setTitle("Log In", for: [])
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
        } else {
            
            signupMode = true
            signupOrLoginButton.setTitle("Sign Up", for: [])
            changeSignupModeButton.setTitle("Log In", for: [])
        }
        
        
        
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil{
        performSegue(withIdentifier: "toUserInfo", sender: self)
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

















///
//  UserDetailsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 27.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserDetailsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var userImage: UIImageView!
    
    /*                                          UPDATE PROFILE IMAGE                                */
    
    @IBAction func updateProfileImage(_ sender: Any) {
        
        let IP = UIImagePickerController()
        IP.delegate = self
        IP.sourceType = UIImagePickerControllerSourceType.photoLibrary
        IP.allowsEditing = false
        
        self.present(IP, animated: true, completion: nil)
        
    }
    
    
    
    /*                                                  IMPC                              */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            userImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBOutlet var genderSwicth: UISwitch!
    @IBOutlet var interestedInSwitch: UISwitch!
    @IBOutlet var errorLabel: UILabel!
    
    
    
    
    
    
    
    /*                                             UPDATE   + SAVE USER                                */
    
    @IBAction func update(_ sender: Any) {
        
        PFUser.current()?["isFemale"] = genderSwicth.isOn
        PFUser.current()?["isInterestedInWomen"] = interestedInSwitch.isOn
        let imageData = UIImagePNGRepresentation(userImage.image!)
        
        PFUser.current()?["photo"] = PFFile(name: "profile.png", data: imageData!)
        
        PFUser.current()?.saveInBackground(block: { (success, error) in
            
            if error != nil {
                var errorMessage = "Update failed - please try again"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                
                self.errorLabel.text = errorMessage
                
            } else {
                
                print("Updated")
                self.performSegue(withIdentifier: "showSwipeWC", sender: nil)
            }
            
        })
        
    }
    
    
    
    
    
    /*                                                  SWITCHES + GET PHOTO DATA   +  GET USERNAMES FROM URLs                            */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let isFemale = PFUser.current()?["isFemale"] as? Bool{
            genderSwicth.setOn(isFemale, animated: false)
        }
        
        if let isInterestedInWomen = PFUser.current()?["isInterestedInWomen"] as? Bool{
            interestedInSwitch.setOn(isInterestedInWomen, animated: false)
        }
        
        if let photo = PFUser.current()?["photo"] as? PFFile{
            
            photo.getDataInBackground(block: { (data, error) in
                
                if let imageData = data {
                    if let downloadedImage = UIImage(data: imageData){
                        self.userImage.image = downloadedImage
                        
                    }
                    
                }
            })
        }
        
        
        
        
        let URLs = ["http://www.bart-simpsons.estranky.cz/img/mid/12/300.simpson.marge.lc.100809.jpg", "http://www.smosh.com/sites/default/files/ftpuploads/bloguploads/0713/weird-cartoon-character-gilrs-fb.jpg", "http://file1.answcdn.com/answ-cld/image/upload/f_jpg,w_672,c_fill,g_faces:center,q_70/v1/tk/view/cew/e8eccfc7/e367e6b52c18acd08104627205bbaa4ae16ee2fd.jpeg", "http://images.yuku.com.s3.amazonaws.com/image/jpg/49a26e56fdf56fb80b8a4adffad0c6aea063581a_r.jpg"]
        
        
        var counter = 0
        
        for urlString in URLs{
            
            let url = URL(string: urlString)!
            
            
            do{
                let data = try Data(contentsOf: url)
                
                let imageFile = PFFile(name: "photo.png", data: data)
                let user = PFUser()
                user["photo"] = imageFile
                user.username = String(counter)
                user.password = "Password"
                
                
                
                user["isInterestedInWomen"] = false
                user["isFemale"] = true
                
                //allows to write a user
                let ACL = PFACL()
                ACL.getPublicReadAccess = true
                user.acl = ACL
                
                user.signUpInBackground(block: { (success, error) in
                    if success{
                        
                        print("User signed up")
                    }
                })
            }
                
            catch{
                print("We couldnt get data")
                
            }
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
}










//
//  SwipeViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 27.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipeViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var displayedUserID = ""
    
    
    /*                                                      WASDRAGGED()                                */
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        let label = gestureRecognizer.view!
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(abs(100 / xFromCenter), 1)
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        label.transform = stretchAndRotation
        
        
        
        
        if gestureRecognizer.state == UIGestureRecognizerState.ended{
            
            var acceptedOrRejected = ""
            
            if label.center.x > 100{
                acceptedOrRejected = "rejected"
                updateImage()
                
            } else if label.center.x > self.view.bounds.width - 100{
                acceptedOrRejected = "accepted"
                updateImage()
            }
            
            if acceptedOrRejected != "" && displayedUserID != "" {
                
                PFUser.current()?.addUniqueObject([displayedUserID], forKey: acceptedOrRejected)
                
                PFUser.current()?.saveInBackground(block: { (success, error) in
                    self.updateImage()
                })
                
                
            }
            
            
            
            rotation = CGAffineTransform(rotationAngle: 0)
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            
            
            
            
        }
    }
    
    
    
    /*                                                      UPDATEIMAGE() AND WORK WITH LOCATION                               */
    
    func updateImage(){
        
        let query = PFUser.query()
        query?.whereKey("isFemale", equalTo: (PFUser.current()?["isIntersetdInWomen"])!)
        query?.whereKey("isInterestedInWomen", equalTo: (PFUser.current()?["isFemale"])!)
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.current()?["accepted"]{
            ignoredUsers += acceptedUsers as! Array
        }
        
        if let rejectedUsers = PFUser.current()?["rejected"]{
            ignoredUsers += rejectedUsers as! Array
        }
        
        query?.whereKey("objectId", notContainedIn: ignoredUsers)
        
        
        if let latitude = (PFUser.current()?["location"] as AnyObject).latitude{
            if let longitude = (PFUser.current()?["location"] as AnyObject).longitude{
            
                query?.whereKey("location", withinGeoBoxFromSouthwest: PFGeoPoint(latitude: latitude - 1, longitude: longitude - 1), toNortheast: PFGeoPoint(latitude: latitude + 1, longitude: longitude + 1))
            }
        
        }
        
        
        query?.limit = 1
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects{
                
                for object in users{
                    if let user = object as? PFUser{
                        
                        self.displayedUserID = user.objectId!
                        let imageFile = user["photo"] as! PFFile
                        
                        
                        imageFile.getDataInBackground(block: { (data, error) in
                            if let imageData = data{
                                self.imageView.image = UIImage(data: imageData)
                            }
                        })
                        
                    }
                    
                }
                
            }
        })
    }
    
    
    /*                                                      GESTURE                               */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)
        
        PFGeoPoint.geoPointForCurrentLocation { (geopoint, error) in
            if let geopoint = geopoint{
            
            PFUser.current()?.saveInBackground()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*                                                     PREPARE FOR LOGOUT SEGUE                                */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoutSegue"{
            PFUser.logOut()
            
        }
    }
    
}








//
//  MatchesTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 28.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesTableViewCell: UITableViewCell {

    @IBOutlet var userImgView: UIImageView!
    
    @IBOutlet var userIDLabel: UILabel!

    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageField: UITextField!
    
    
    /*                              SEND                            */
    @IBAction func send(_ sender: Any) {
        
        let M = PFObject(className: "message")
        M["sender"] = PFUser.current()?.objectId!
        M["recipient"] = userIDLabel.text
        M["content"] = messageField.text
        M.saveInBackground()
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}








//
//  MatchesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Filip Vabroušek on 28.11.16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var images = [UIImage]()
   var userIDs = [String]()
    var messages = [String]()
    
    /*                                  Count 'em all!!                     */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
    /*                                    Let in images                   */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MatchesTableViewCell
        cell.userImgView.image = images[indexPath.row]
        cell.messageLabel.text = "You haven't received a message yet."
        cell.userIDLabel.text = userIDs[indexPath.row]
        cell.messageLabel.text = messages[indexPath.row]
        return cell
    }
    
    

    
     /*                                    GET IMAGE DATA WHEN ACCEPTED                 */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        query?.whereKey("accepted", contains: PFUser.current()?.objectId)
        query?.whereKey("objectId", containedIn: PFUser.current()?["accepted"] as! [String])
    
        query?.findObjectsInBackground(block: { (objects, error) in
          
            if let users = objects{
                for object in users{
                
                    if let user = object as? PFUser{
                    let imageFile = user["photo"] as! PFFile
                    
                        imageFile.getDataInBackground(block: { (data, error) in
                           
                            if let imageData = data {
                            
                                
                                let messageQuery = PFQuery(className: "Message")
                            messageQuery.whereKey("recipient", equalTo: PFUser.current()?.objectId!)
                                messageQuery.whereKey("sender", equalTo: user.objectId!)
                                
                                messageQuery.findObjectsInBackground(block: { (objects, error) in
                                    
                                    var messageText = "No messageFor the user"
                                    
                                    if let objects = objects {
                                    for message in objects{

                                            if let messageContent = message["content"] as? String{
                                            messageText = messageContent
                                            }

                                    }
                                    }
                                    self.messages.append(messageText)
                                    
                                    self.images.append(UIImage(data: imageData)!)
                                    self.userIDs.append(user.objectId!)
                                    self.tableView.reloadData()

                                })
                            }

                            
                        })
                    }
                
                
                }
            
            }
            
            
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



