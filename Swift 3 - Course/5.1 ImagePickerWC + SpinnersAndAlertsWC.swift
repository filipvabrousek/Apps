//
//  ViewController.swift
//  importPhoto
//
//  Created by Filip Vabroušek on 14.11.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    
    /*                              imagePickerController()                 */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            
        } else {
            print("There was an error")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    /*                                      IMPORT IMAGE                    */
    @IBAction func importImage(_ sender: Any) {
        
        let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.sourceType = UIImagePickerControllerSourceType.photoLibrary //camera
        IMPC.allowsEditing = false
        
        self.present(IMPC, animated: true, completion: nil)
        
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







//
//  ViewController.swift
//  SpinnersAlerts
//
//  Created by Filip Vabroušek on 14.11.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var AI = UIActivityIndicatorView()
    
    /*                                                          CREATE ALERT                        */
    @IBAction func createAlert(_ sender: Any) {
        
        
        let AC = UIAlertController(title: "Hey there", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        
        //---OK action
        AC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("OK pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        
        //---NO action
        AC.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            print("NO pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))

  
        self.present(AC, animated: true, completion: nil)
    }
    
    
    
    /*                                                          PAUSE APP                               */
    @IBAction func pauseApp(_ sender: Any) {
        AI = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width: 50, height: 50))
        AI.center = self.view.center
        AI.hidesWhenStopped = true
        AI.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(AI)
        AI.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /*                                                  RESTORE APP                             */
    @IBAction func restoreApp(_ sender: Any) {
        AI.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
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

