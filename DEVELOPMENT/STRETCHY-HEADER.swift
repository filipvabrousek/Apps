//
//  ViewController.swift
//  Stretchy-table
//
//  Created by Filip Vabroušek on 15/05/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.register(UITableViewCell.self, forCellReuseIdentifier: "MCell")
        t.separatorColor = .clear
        t.alpha = 1.0
        t.backgroundColor = .white
        t.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        return t
    }()
    
    
    
    let i: UIImageView = {
        var i = UIImageView()
        i.image = UIImage(named: "iceland.jpg")
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(i)
        i.ignorePin(a: .top, dist: 0, w: view.frame.width, h: 200)
       // i.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200) // (+notch)
        tableView.absolutePin(top: 0)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    let arr = ["Filip", "Sára"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MCell")
        cell?.textLabel?.text = arr[indexPath.row]
        return cell!
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 200 - (scrollView.contentOffset.y + 200)
        let height = min(max(y, 60), 300)
        i.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}


// SOURCE:
// https://medium.com/if-let-swift-programming/how-to-create-a-stretchable-tableviewheader-in-ios-ee9ed049aba3

