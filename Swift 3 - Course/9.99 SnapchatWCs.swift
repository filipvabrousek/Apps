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
    
    @IBOutlet var usernameField: UITextField!
    
    
    
    
    /*                                                      SIGN UP OR LOGIN                                                    */
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if usernameField.text == ""{
            errorLabel.text = "Username is required";
            
        } else {
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: "password", block: { (user, error) in
                
                if error != nil {
                    
                    let user = PFUser()
                    user.username = self.usernameField.text
                    user.password = "password"
                    
                    
                    user.signUpInBackground(block: { (success, error) in
                        
                        if let error = error as? NSError {
                            var errorMessage = "Signup failed, please try again later."
                            
                            if let errorString = error.userInfo["error"] as? String{
                                
                                errorMessage = errorString
                            }
                            self.errorLabel.text = errorMessage;
                        } else {
                            self.performSegue(withIdentifier: "showUserTable", sender: nil)
                        }
                    })
                    
                } else {
                    print("Logged in");
                    self.performSegue(withIdentifier: "showUserTable", sender: nil)
                }
                
                
            })
        }
        
    }
    
    
    /*                                                      PERFORM SEGUE                                                    */
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil{
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
    }
    
    
    
    @IBOutlet var errorLabel: UILabel!
    
    
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
//  Created by Rob Percival on 13/07/2016.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    var usernames = [String]()
    
    var recipientUsername = ""
    
    
    
    
    /*                                                      CHECK FOR MESSAGES (get data)                                                    */
    func checkForMessages(){
        
        
        let query = PFQuery(className: "Image")
        query.whereKey("recepient", equalTo: PFUser.current()?.username)
        
        do {
            let images = try query.findObjects()
            
            if images.count > 0 {
                
                
                var senderUsername = "Unknown user"
                
                if let username = images[0]["senderUsername"] as? String{
                    senderUsername = username
                    
                }
                
                
                if let pfFile = images[0]["photo"] as? PFFile{
                    
                    pfFile.getDataInBackground(block: { (data, error) in
                        
                        
                        if let imageData = data{
                            
                            images[0].deleteInBackground()
                            
                            self.timer.invalidate()
                            
                            if let imageToDisplay = UIImage(data: imageData){
                                
                                let alert = UIAlertController(title: "You have a message", message: "Message from " + senderUsername, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                    
                                    
                                    let bacgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                    bacgroundImageView.backgroundColor = UIColor.black
                                    bacgroundImageView.alpha = 0.8
                                    bacgroundImageView.tag = 10
                                    self.view.addSubview(bacgroundImageView)
                                    
                                    
                                    let displayedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                                    
                                    displayedImageView.image = imageToDisplay
                                    displayedImageView.tag = 10
                                    displayedImageView.contentMode = UIViewContentMode.scaleAspectFit
                                    self.view.addSubview(displayedImageView)
                                    
                                    _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                                        
                                        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(UserTableViewController.checkForMessages), userInfo: nil, repeats: true)
                                        
                                        for subview in self.view.subviews{
                                            
                                            if subview.tag == 10{
                                                
                                                subview.removeFromSuperview()
                                                
                                            }
                                        }
                                    })
                                    
                                }))
                                
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        }
                    })
                    
                    
                }
            }
            
        }catch{
            
            print("Could not get images")
        }
        
        
        
        
    }
    
    var timer = Timer()
    
    
    /*                                                    VIEWDIDLOAD                                                    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        
        
        
        
        var queryB = PFUser.query()
        queryB?.whereKey("username", notEqualTo: (PFUser.current()?.username))
        
        
        do{
            let users = try queryB?.findObjects()
            
            if let users = users as? [PFUser]{
                for user in users {
                    self.usernames.append(user.username!)
                    
                }
                tableView.reloadData()
            }
        }
            
        catch {
            print("Could not get users")
        }
        
    }
    
    //count em all
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }
    
    
    //fill - in cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell");
        cell.textLabel?.text = usernames[indexPath.row]
        return cell
    }
    
    
    /*                                                     SEGUE                                                  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logout"{
            PFUser.logOut()
            timer.invalidate()
            self.navigationController?.navigationBar.isHidden = true;
        }
    }
    
    
    /*                                                      IMPC                                                   */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipientUsername = usernames[indexPath.row]
        
        let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.sourceType = .photoLibrary
        IMPC.allowsEditing = false
        
        self.present(IMPC, animated: true, completion: nil)
    }
    
    
    
    /*                                                      DID FINISH ACKING MEDIA                                                   */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            let imageToSend = PFObject(className: "Image")
            imageToSend["photo"] = PFFile(name: "photo.pn", data: UIImagePNGRepresentation(image)!)
            imageToSend["senderUsername"] = PFUser.current()?.username
            imageToSend["recipientUsername"] = recipientUsername
            imageToSend.saveInBackground(block: { (success, error) in
                
                var title = "Sending failed"
                var description = "Please try again later"
                
                if success {
                    
                    title = "Message sent"
                    description = "Your message has been sent"
                }
                
                let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            })
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}




