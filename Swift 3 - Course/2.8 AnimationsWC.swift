//
//  ViewController.swift
//  Anim
//
//  Created by Filip Vabroušek on 26.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btn: UIButton!
    @IBOutlet var image: UIImageView!  
    
    /*                                              Loop things                                         */
    var counter = 1
    var isAnimating = false
    
    var timer = Timer()
    
    func animate(){
        
        image.image = UIImage(named:"frame_\(counter)_delay-0.1s.gif")
        counter += 1
        
        if counter == 6 {
            counter = 0
        }
        
        
    }
    
    @IBAction func next(_ sender: AnyObject) {
        btn.setTitle("Start", for: [])
        if isAnimating{
            timer.invalidate()
            isAnimating = false
        } else {
            
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            btn.setTitle("Stop animation", for: [])
            isAnimating = true
        }
        
    }
    
    
    
    /*                                                          FADE IN()                            */
    @IBAction func fadeIn(_ sender: AnyObject) {
        image.alpha = 0
        UIView.animate(withDuration: 1) {
            self.image.alpha = 1
        }
    }
    
    /*                                                          SLIDE IN()                                              */
    @IBAction func slideIn(_ sender: AnyObject) {
        image.center = CGPoint(x: image.center.x - 500, y: image.center.y)
        UIView.animate(withDuration: 2) {
            self.image.center = CGPoint(x: self.image.center.x + 500, y: self.image.center.y)
        }
    }
    
    /*                                                          GROW()                                               */
    @IBAction func Grow(_ sender: AnyObject) {
        image.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.animate(withDuration: 1){
            self.image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
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

