//
//  ViewController.swift
//  Photo Demo
//
//  Created by Filip vabrouske on 1/1/2017


import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    /*                                                      IMAGE PICKER CONTROLLER                                     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
        imageView.image = image
        } else {
        print("Something failed")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    
    /*                                                      IMPORT IMAGE (from gallery)                                     */
    @IBAction func importImage(_ sender: AnyObject) {
        
      let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.sourceType = UIImagePickerControllerSourceType.photoLibrary
        IMPC.allowsEditing = false
        
        self.present(IMPC, animated: true, completion: nil)
    }
    
    
    
    
    
    /*                                                      IMPORT IMAGE FROM CAMERA                                   */
    @IBAction func importFromCamera(_ sender: Any) {
        let IMPC = UIImagePickerController()
        IMPC.delegate = self
        IMPC.sourceType = UIImagePickerControllerSourceType.camera
        IMPC.allowsEditing = false
    
        self.present(IMPC, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

