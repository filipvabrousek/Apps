//
//  wow.swift
//  Nice
//
//  Created by Filip Vabroušek on 30.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit


class ComplexSimple:UIButton{
    
    var color:UIColor = UIColor.clear
    
    init(color: UIColor) {
        super.init(frame: .zero)
        self.layer.backgroundColor = color.cgColor
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size = CGSize(width: 200, height: 60)
        self.layer.cornerRadius = 30
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    
    }
}


class Simple:UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame.size = CGSize(width: 200, height: 60)
        self.layer.cornerRadius = 30
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor.green
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
}


extension UIButton{
    func opacitySpring(to amount: CGFloat, dur:TimeInterval){
        let timing = UISpringTimingParameters(dampingRatio: 1) // 2
        let animator = UIViewPropertyAnimator(duration: dur, timingParameters: timing)
        
        animator.addAnimations {
            self.alpha = amount
        }
        
        animator.startAnimation()
        
    }
    
}

/*
 class StartButton: UIButton {
 
 override func awakeFromNib() {
 super.awakeFromNib()
 
 self.frame.size = CGSize(width: 200, height: 60)
 self.layer.cornerRadius = 30
 self.layer.backgroundColor = UIColor(red: 10.2, green: 73.7, blue: 61.2, alpha: 1.0).cgColor
 }
 }
 */
