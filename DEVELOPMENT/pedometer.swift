 @objc func pedo(sender: UIButton!){
    
    if CMPedometer.isStepCountingAvailable(){
               
        PM.startUpdates(from: Date()) { (data, err) in
            if let data = data {
                print("Number of steps \(data.numberOfSteps)")
            } 
        }
     
    }
 }

// NSMotionUsageDescription

