//
//  ViewController.swift
//  Photo Demo
//
//  Created by Filip vabrouske on 1/1/2017


import UIKit
import CoreImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

   
    @IBOutlet var imageView: UIImageView!
    
    
   
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
    
    
    /*                                                          SEPIA FILTER                                                */
    
    @IBAction func sepia(_ sender: Any) {
        
        guard let image = self.imageView.image?.cgImage else { return }
        let openGLContext = EAGLContext(api: .openGLES3)
        let context = CIContext(eaglContext: openGLContext!)
        
        let ciImage = CIImage(cgImage: image)
        
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(ciImage, forKey: kCIInputIntensityKey)
        filter?.setValue(1, forKey: kCIInputIntensityKey)
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage{
        self.imageView?.image = UIImage(cgImage: context.createCGImage(output, from: output.extent)!)
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

