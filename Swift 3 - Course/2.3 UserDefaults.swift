//
//  ViewController.swift
//  UserDefaults
//
//  Created by Filip Vabroušek on 19.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var field: UITextField!
    
   //save func
    @IBAction func save(_ sender: AnyObject) {
        let x = field.text
        UserDefaults.standard.set(x, forKey:"data")
    }
    
    
    
   //display func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let object = UserDefaults.standard.object(forKey: "data")
        
        if let data = object as? String{
            field.text = data
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
