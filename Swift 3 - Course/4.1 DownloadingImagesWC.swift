//
//  ViewController.swift
//  Downloading images
//
//  Created by Filip Vabroušek on 05.11.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var sqImg: UIImageView!
    
    
    /*                                    FETCH THE IMAGE FROM THE DEVICE, WE DONT NEED CODE BELOW THIS CODE ANY LONGER                         */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            let documentDirectory = documentsPath[0]
            let restorePath = documentDirectory + "/Moon.jpg"
            
            sqImg.image = UIImage(contentsOfFile: restorePath)
        }
        
        
        
        
        /*                                                   DOWNLOAD IMAGE FROM WEB TO THE DEVICE                                               */
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/c/c9/Moon.jpg")!
        let request = NSMutableURLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print(error)
                
            } else {
                if let data = data{
                    if let sqImg = UIImage(data: data){
                        self.sqImg.image = sqImg
                        
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        
                        if documentsPath.count > 0 {
                            let documentDirectory = documentsPath[0]
                            let savePath = documentDirectory + "/Moon.jpg"
                            
                            do{
                                try  UIImageJPEGRepresentation(sqImg, 1)?.write(to: URL(fileURLWithPath: savePath))
                            }
                            catch{
                                //proccess error
                            }
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        task.resume()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

