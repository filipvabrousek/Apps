//
//  ViewController.swift
//  TouchIDDemo
//
//  Created by Filip Vabroušek on 05.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let authenticationContext = LAContext()
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We want to know who you are") { (success, error) -> in
        
            if success {
            print("User has autenthicated")
                
            } else {
            if let errro = error {
                print(error)

                } else {
                print("Didnt autenthicate")

                }
            
            }
        
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

