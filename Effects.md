

# Effects



## Usage
```swift

    
    
  func custom() {
	let b = Blend(numberOfPulses: 1, radius: 50, position: btn.center)
	// b.dur = 1
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
    
    public init(numberOfPulses:Float = Float.infinity, radius: CGFloat, position: CGPoint){
        
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



class NotifButton: UIButton{
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.tintColor = UIColor.white
        self.backgroundColor = UIColor(red: 26 / 255.0, green: 188 / 255.0, blue: 156 / 255.0, alpha: 1)
        
        
        // self.backgroundColor = UIColor(hue: 198.6 , saturation: 91.3, brightness: 100, alpha: 1)
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y:0, width:self.frame.width / 5, height:10), cornerRadius: 50).cgPath
        layer.fillColor = UIColor.red.cgColor
        self.layer.insertSublayer(layer, at: 0)
        
        
        
    }
    
    
}





class EmitButton: UIButton {

    
    override func awakeFromNib() {
        let emitLayer = CAEmitterLayer()
        emitLayer.emitterPosition = CGPoint(x: 0, y: self.frame.height / 2)
        
        let cell = CAEmitterCell()
        cell.birthRate = 100
        cell.lifetime = 2
        cell.velocity = 100
        cell.scale = 0.1
        
        
        cell.emissionRange = CGFloat.pi / 8
        cell.contents = UIImage(named: "icon.png")!.cgImage
        emitLayer.emitterCells = [cell]
        self.layer.addSublayer(emitLayer)
    }
    

```

## Transition


```swift
class Transition: NSObject {
    
    var circle = UIView()
    var circleColor = UIColor.white
    var dur = 0.3
    
    var startingPoint = CGPoint.zero {
        
        didSet{
            circle.center = startingPoint
        }
    }
    
    
    enum Mode: Int {
        case present, dismiss, pop
    }
    
    var transitionMode:Mode = .present
}





extension Transition: UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return dur
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      
        
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                 circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                
                UIView.animate(withDuration: dur, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }, completion: { (s: Bool) in
                    transitionContext.completeTransition(s)
                })
                
            }
            
            
        } else {
            
            
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startingPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: dur, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop{
                        containerView.insertSubview(returningView, belowSubview: returningView)
                        containerView.insertSubview(self.circle, belowSubview: returningView)
                    }
                    
                    
                    
                }, completion: { (s:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(s)
                    
                })
                
                
                
                
                
            }
        }
        
    }
    
}




func frameForCircle(withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startingPoint: CGPoint) -> CGRect {
    
    let xLength = fmax(startingPoint.x, viewSize.width - startingPoint.x)
    let yLength = fmax(startingPoint.y, viewSize.height - startingPoint.y)
    
    let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
    let size = CGSize(width: offsetVector, height: offsetVector)
    
    return CGRect(origin: CGPoint.zero, size: size)
    
}





```

## Usage


```swift
 @IBOutlet weak var menuButton: UIButton!
    
    let transition = Transition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }



```
* dismiss method in the second VC

## React on events

* in viewDidLoad
```swift
 let g = react(on: "swipe", target: self, action: #selector(handleSwipe(from:))).apply()
 self.view.addGestureRecognizer(g)

```

```swift
class react{
    
    var on: String
    var target: UIViewController
    
    var action: Selector
    
    init(on:String, target: UIViewController, action: Selector) {
        self.on = on
        self.target = target
        self.action = action
        
    }
    
    func apply() -> UIGestureRecognizer{
        
        var res = UIGestureRecognizer()
        
        switch on {
        case "pan":
            res = UIPanGestureRecognizer(target: target, action: action)
        case "swipe":
            res = UISwipeGestureRecognizer(target: target, action: action)
            
        default:
            print("Not defined")
        }
        
        return res
        
    }
    
}


```


## Circle motion
```
 var animator: UIViewPropertyAnimator = UIViewPropertyAnimator()
 var cc: CGPoint = CGPoint()

```
* into viewDidLoad():

```swift
var circle = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
circle.center = self.view.center
circle.backgroundColor = UIColor.orange
circle.layer.cornerRadius = 50.0
self.view.addSubview(circle)
        
        
let pga = UIPanGestureRecognizer(target: self, action: #selector(handleCircle(gesture:)))
circle.addGestureRecognizer(pga)
   
let timing = UICubicTimingParameters(controlPoint1: CGPoint(x:0, y:0.5), controlPoint2: CGPoint(x: 1, y: 1.5))
animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: timing)
animator.isInterruptible = true


```


```swift
func handleCircle(gesture: UIPanGestureRecognizer){
        
        let target = gesture.view!
        
        
        switch gesture.state {
            
        case .began:
            if animator != nil && animator.isRunning{
                animator.stopAnimation(false)
            }
            
            cc = target.center
            
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: cc.x + translation.x, y: cc.y + translation.y)
            
        case .ended:
            
            let v = gesture.velocity(in: target)
            let velocity = CGVector(dx: v.x / 500, dy: v.y / 500)
            let spring = UISpringTimingParameters(mass: 2.5, stiffness: 70, damping: 55, initialVelocity: velocity)
            animator = UIViewPropertyAnimator(duration: 0.0, timingParameters: spring)
            
            animator.addAnimations {
                target.center = self.view.center
                
            }
            
            animator.startAnimation()
            
        default:
            break
        }
        
        
        
    }


```



## Move class

```swift
let e = Move(view: circle, in: "up", dur: 20, delay: 2, spring: 2, v: 6)
        e.perform()

```



```swift
class Move {
    var view:UIView
    var direction:String
    var dur: TimeInterval
    var delay:TimeInterval
    var spring: CGFloat
    var v:CGFloat
    
    
    init(view: UIView, in direction:String, dur:TimeInterval, delay: TimeInterval, spring: CGFloat, v: CGFloat){
        
        self.view = view
        self.direction = direction
        self.dur = dur
        self.delay = delay
        self.spring = spring
        self.v = v
        
    }
    
    
    
    
    
    func perform(){
        
        var anim = UIView.animate(withDuration: dur,
                                  delay: delay,
                                  usingSpringWithDamping: spring,
                                  initialSpringVelocity: v,
                                  options: [.curveEaseInOut],
                                  animations: {}, completion: nil)
        
        
        switch direction {
            
        case "up":
            anim = UIView.animate(withDuration: dur, delay: delay,
                                  usingSpringWithDamping: spring,
                                  initialSpringVelocity: v,
                                  options: [.curveEaseInOut], animations: {
                                    
                                    self.view.frame = CGRect(x: self.view.frame.origin.x,
                                                             y:10,
                                                             width: self.view.frame.width,
                                                             height: self.view.frame.height)
                                    
            }, completion: nil)
            
            
        default:
            break
            
        }
    }
}







```
## Parallax

```swift
 override func viewDidLoad() {
        super.viewDidLoad()

        apply(toView: background, magnitude: 23)
        apply(toView: image, magnitude: -50)
    }

```

```swift
    func apply(toView: UIView, magnitude: CGFloat){
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
        
    }



```



