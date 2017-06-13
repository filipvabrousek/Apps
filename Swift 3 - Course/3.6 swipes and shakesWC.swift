//
//  ViewController.swift
//  SwipesShakes
//
//  Created by Filip Vabroušek on 30.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    /*                                      DEFINE SWIPES                  */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    /*                                       DETECT SHAKES              */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake{
            print("Device shaken")
            
        }
    }
    
    
    /*                                          SWIPED                                  */
    func swiped(gesture: UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.right:
                print("User swiped right")
            case UISwipeGestureRecognizerDirection.left:
                print("User swiped left")
            default:
                break
                
                
                
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

