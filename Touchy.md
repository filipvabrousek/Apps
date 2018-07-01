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

## Round buttoon
```swift
class Round: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame.size = CGSize(width: 60, height: 60)
        self.layer.cornerRadius = 0.5 * self.bounds.width
        self.layer.backgroundColor = UIColor.green.cgColor
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
    }
}
```

## Animations
```swift
extension UIButton{
    func squezze(to amount: CGFloat, dur:TimeInterval){
        UIView.animate(withDuration: dur) {
            self.alpha = amount
            self.frame.size = CGSize(width: self.frame.width - 3.0, height: self.frame.height - 3.0)
        }
    }
    
    func stretch(width w: CGFloat, height h:CGFloat, dur:TimeInterval){
        UIView.animate(withDuration: dur) {
            self.frame.size = CGSize(width: self.frame.width + w, height: self.frame.height + h)
        }
    }  
}
```

## Usage:

```swift
 @IBOutlet var plusBtn: Round!
 
@IBAction func spring(_ sender: Any) {
      plusBtn.squezze(to: 0.2, dur: 0.6)
      plusBtn.stretch(width: 10.0, height: 10.0, dur: 0.8)
}
```





