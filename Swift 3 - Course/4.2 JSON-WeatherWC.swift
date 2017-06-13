//
//  ViewController.swift
//  API Demo
//
//  Created by Filip Vabroušek on 05.11.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    
    
    /*                                                                  SUBMIT                                              */
    @IBAction func submit(_ sender: Any) {
        
        // get desired URL (with data from input field, replace spaces with "%20")
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + field.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=b2a9aab846b30509b066f35c8f5122f3") {
            
            //define task (handle data, response, error)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error)
                } else {
                    
                    // extract JSON data
                    if let urlContent = data {
                        
                        do{
                            let JSONResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(JSONResult)
                            print(JSONResult["name"])
                            
                            if let description = ((JSONResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                
                                DispatchQueue.main.sync(execute:  {
                                    self.result.text = description
                                })
                                
                                
                                print(description)
                            }
                        }
                            
                            
                        catch{
                            print("JSON processing failed")
                        }
                    }
                    
                }
                
            }
            
            
            task.resume()
        } else {
            
            result.text = "Couldnt find a weather for that city."
        }
    }
    
    @IBOutlet var result: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

