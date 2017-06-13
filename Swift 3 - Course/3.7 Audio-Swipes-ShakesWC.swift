//
//  ViewController.swift
//  SwipesShakes
//
//  Created by Filip Vabroušek on 30.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    /*                                      INIT AUDIO PLAYER                      */
    var player = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    /*                                              DETECT SHAKES                       */
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake{
            let soundArray = ["lout", "gimme"]
            let rand = Int(arc4random_uniform(UInt32(soundArray.count)))
            
            
            let fileLocation = Bundle.main.path(forResource: soundArray[rand], ofType: ".mp3")
            
            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                player.play()
            }
                
            catch {
                
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

