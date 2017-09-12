

# Effects



## Usage
```swift

    
    
  func custom() {
	let b = Blend(numberOfPulses: 1, radius: 50, position: btn.center)
	b.dur = 1
	b.backgroundColor = UIColor.white.cgColor
	self.view.layer.insertSublayer(b, above: btn.layer)
	btn.alpha = 0.6
	btn.resize(to: 200, dur: 2)
}

func blury() {
	let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
	blur.frame = imgView.bounds
	imgView.addSubview(blur)
}

```



## UIButton extensions
```swift
import UIKit

extension UIButton {
    
    
    /*---------------------------------------------OPACITY---------------------------------------------*/
    
    func resize(to size: CGFloat, dur:TimeInterval){
        
        UIView.animate(withDuration: dur, animations: {
            let rect = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: size, height: self.frame.height)
            self.frame = rect
        })
    }
    
    
    
    /*---------------------------------------------OPACITY---------------------------------------------*/
    func opacity(toAmount: CGFloat, dur: TimeInterval){
        
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: dur, timingParameters: timing)
        
        animator.addAnimations {
            self.alpha = toAmount
        }
        animator.startAnimation()
    }
    
    
    /*---------------------------------------------OPACITY---------------------------------------------*/
    func opacitySpring(toAmount: CGFloat, dur: TimeInterval){
        
        let timing = UISpringTimingParameters(dampingRatio: 2)
        let animator = UIViewPropertyAnimator(duration: dur, timingParameters: timing)
        
        animator.addAnimations {
            self.alpha = toAmount
        }
        
        animator.startAnimation()
    }
    
    
    /*---------------------------------------------MOVE---------------------------------------------*/
    func move(by x: CGFloat, dur: TimeInterval) {
        let yPos = self.frame.origin.y
        
        let height = self.frame.height
        let width = self.frame.width
        
        UIView.animate(withDuration: dur) {
            self.frame = CGRect(x: x, y: yPos, width: width, height: height)
        }
    }
    
    /*-----------------------------------------CHANGE BACKGROUND-----------------------------------------*/
    func changeBackground(to color: UIColor, dur:TimeInterval){
        
        UIView.animate(withDuration: dur) {
            self.backgroundColor = color
        }
    }
    
    /*-----------------------------------------CHANGE BORDER-----------------------------------------*/
    func changeBorder(to color: CGColor, width width:CGFloat,  dur: TimeInterval){
        
        UIView.animate(withDuration: dur) {
            self.layer.borderWidth = width
            self.layer.borderColor = color
            
            
        }
    }
    
}


```


## Blend effect layer
```swift
public class Blend: CALayer{
    
    var group = CAAnimationGroup()
    
    var initalPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var dur: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = Float.infinity
    
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    init(numberOfPulses:Float = Float.infinity, radius: CGFloat, position: CGPoint){
        
        super.init()
        
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = 0.9 * self.bounds.size.width
        
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.group, forKey: "pulse")
            }
        }
    }
    
    
    
    func createOpacityAnimation() -> CAKeyframeAnimation{
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = dur
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        return opacityAnimation
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initalPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = dur
        return scaleAnimation
    }
    
    
    func setupAnimationGroup(){
        self.group = CAAnimationGroup()
        self.group.duration = dur + nextPulseAfter
        self.group.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        self.group.timingFunction = defaultCurve
        self.group.animations = [createOpacityAnimation(), createScaleAnimation()]
    }

}

```


## Custom buttons
```swift

import UIKit

class GradientButton: UIButton {
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 2.0
        self.clipsToBounds = true
        
        
        self.frame.size = CGSize(width: 100, height: 60)
        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        self.tintColor = UIColor.white
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        
        let c1 = UIColor(red: 26.0 / 255.0, green: 188.0 / 255.0, blue: 156.0 / 255.0, alpha: 1).cgColor
        let c2 = UIColor(red: 200.0 / 255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1).cgColor
        
        gradient.colors = [c1, c2]
        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
}



class SimpleButton: UIButton {
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
        
        
        self.frame.size = CGSize(width: 100, height: 60)
        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor(red: 26 / 255.0, green: 188 / 255.0, blue: 156 / 255.0, alpha: 1)
        
    }
    
}







class CircleButton: UIButton {
   
    override func awakeFromNib() {
        self.layer.cornerRadius = 0.8 * self.bounds.size.width
        self.clipsToBounds = true
        
        
        self.frame.size = CGSize(width: 80, height: 80)
        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor(red: 26 / 255.0, green: 188 / 255.0, blue: 156 / 255.0, alpha: 1)
        
    }
    
}


```