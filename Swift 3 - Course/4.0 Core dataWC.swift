//
//  ViewController.swift
//  Log In Demo
//
//  Created by Rob Percival on 04/07/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var logInButton: UIButton!
    
    
    @IBOutlet var logOutButton: UIButton!
    
    var isLoggedIn = false
    
    
    
    /*                                                          LOGOUT                                          */
    @IBAction func logOut(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    context.delete(result)
                    
                    do {
                        try context.save()
                    }
                        
                    catch {
                        print("Delete failed")
                    }
                }
                
                
                
                label.alpha = 0
                logOutButton.alpha = 0
                
                logInButton.setTitle("update username", for: [])
                
                isLoggedIn = false
                
            }
        }
            
        catch{
            
            print("Unable to do this")
        }
    }
    
    
    
    
    /*                                              LOG IN FUNC (add new user)                                      */
    @IBAction func logIn(_ sender: AnyObject) {
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        if isLoggedIn {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            do {
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        result.setValue(textField.text, forKey: "name")
                        
                        do{
                            try context.save()
                            logInButton.setTitle("Update username", for: [])
                        }
                            
                        catch{
                            
                            print("Update username failed")
                        }
                        
                    }
                    
                    label.text = "Hi there" + textField.text! + "!"
                    
                }
            }
                
            catch {
                print("Username failed")
                
            }
            
        } else {
            
            
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newValue.setValue(textField.text, forKey: "name")
            
            let predicate = NSPredicate(format: "username = %@", "Filip")
            
            do {
                
                try context.save()
                
                
                label.alpha = 1
                label.text = "Hi there " + textField.text! + "!"
                isLoggedIn = true
                logInButton.alpha = 1
                logOutButton.alpha = 1
                
            } catch {
                print("Failed to save")
            }
        }
        
    }
    
    
    /*                                          TRY TO DISPLAY THE RESULT FROM CORE DATA                            */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //define request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        
        
        request.returnsObjectsAsFaults = false
        
        //try to fetch, in case of error, catch it!
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    textField.alpha = 0
                    logInButton.alpha = 0
                    label.alpha = 1
                    label.text = "Hi there " + username + "!"
                }
                
            }
            
            
        } catch {
            
            print("Request failed")
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

