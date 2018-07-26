

## Saturation
```swift
....
  override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage(named: "iceland.jpg")
        let inp = Process(image: imgView.image!)
        imgView.image = inp.saturated(val: 0.8)
    }
```


```swift
class Process {
    var image: UIImage = UIImage()
    
    init(image: UIImage){
        self.image = image
    }
    
    
    func saturated(val:Float) -> UIImage {
        let img = image.cgImage
        let ci = CIImage(cgImage: img!)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ci, forKey: "inputImage")
        filter?.setValue(val, forKey: "inputSaturation") // inputContrast
        let gx = EAGLContext(api: .openGLES3)!
        let cctx = CIContext(eaglContext: gx)
        
        let res = filter?.outputImage
        let output = cctx.createCGImage(res!, from: (res?.extent)!)
        return UIImage(cgImage: output!)
    }
```
