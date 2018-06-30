# Touchy
* allows you to add clean buttons to your app


## Simple button
```swift
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
```



## To do:
```swift
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
in VIEW DID LOAD:

 let btn = Simple()
 btn.frame = CGRect(x: 10, y: 10, width: 200, height: 100)
 btn.titleLabel?.text = "Hi"
 self.view.addSubview(btn)
*/
```
