//
//  ViewController.swift
//  DwlndWebContent
//
//  Created by Filip Vabroušek on 19.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    
    
    /*                                  LOAD URL                        */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://www.stackoverflow.com") {
            let request = NSMutableURLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
                
                if error != nil{
                print(error)
                } else {
                    if let unwrappedData = data {
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dataString)
                        
                        DispatchQueue.main.sync(execute: {
                        
                        //update the app
                        
                        })
                    }
                
            }
        }
            
            task.resume()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

