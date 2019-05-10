//
//  ViewController.swift
//  VC-Containment
//
//  Created by Filip Vabroušek on 10/05/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let an = AnotherVC()
        addChild(an)
        an.view.frame = CGRect(x: 50, y: 50, width: 200, height: 80)
        view.addSubview(an.view)
        an.didMove(toParent: self)
    }
}


class AnotherVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}


// https://www.hackingwithswift.com/example-code/uikit/how-to-use-view-controller-containment
