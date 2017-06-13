//
//  ViewController.swift
//  Advanced Segues
//
//  Created by Filip Vabroušek on 28.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit


var global = "Filip"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activeRow = 0
    
    /*                      Number of rows                  */
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
    return 4
        
    }
    
    
    
  /*                                Fill-in cells               */
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
    cell.textLabel?.text = "Row \(indexPath.row)"
    return cell
        
    
    }
    
    
    /*                                  Did select row                  */
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        activeRow = indexPath.row
        performSegue(withIdentifier: "to2ndVC", sender: "nil")
    }
    
    
    
    /*                                  Prepare seague                  */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // Changed to remove "override" at the beginning
        
        if segue.identifier == "to2ndVC" {
            
            let secondViewController = segue.destination as! SecondViewController // destinationViewController is now called destination
            
            secondViewController.activeRow = activeRow
            
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










//
//  SecondViewController.swift
//  Advanced Segues
//
//  Created by Filip Vabroušek on 28.10.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

var username = "filipV"
var activeRow = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(global)
print(activeRow)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



