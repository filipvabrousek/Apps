//
//  ViewController.swift
//  Grades
//
//  Created by Filip Vabroušek on 24.11.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var picker: UIPickerView!
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var selectedGrade: UILabel!
    
    @IBOutlet var gradeA: UILabel!
    
    @IBOutlet var gradeB: UILabel!
    
    
    
    
    var pickerData: [String] = [String]()
    
    
    
    var P  = UIPickerView()
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let USA = ["5.4", "5.5", "5.6", "5.7","5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a",  "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d"]
        
        let UIAA = ["IV", "IV+", "V", "V+","VI-", "VI", "VI+", "VII-", "VII", "VII+", "VII+", "VIII-", "VIII", "VIII+", "IX-", "IX",  "IX+", "IX+", "X-", "X"]
        
        
        let UIAAValue = UIAA[Int(sender.value)]
        let USAValue = USA[Int(sender.value)]
        
        
        gradeA.text = String(USAValue)
        gradeB.text = String(UIAAValue)
        
        //print(USAValue)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    /*                                         DID SELECT                                  */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGrade.text = pickerData[row]
        
        //YDS
        if(row == 0)
        {
            
            print("YDS selected")
        }
            
            //French
        else if(row == 1)
        {
             print("French selected")
        }
            
            //Saxoon
        else if(row == 2)
        {
             print("Saxoon Selected")
        }
            
            //default
        else
        {
            self.view.backgroundColor = UIColor.blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.picker.delegate = self
        self.picker.dataSource = self
        
        
        pickerData = ["YDS", "French", "Saxoon"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

