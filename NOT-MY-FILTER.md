

## Saturation
```swift

import UIKit
import CoreImage
import Foundation

protocol Processable {
    
    var filter: CIFilter { get }
    func input(_ image: UIImage)
    func outputUIImage() -> UIImage?
}


extension Processable {
    
    func input(_ image: UIImage) {
        if let cgImage = image.cgImage {
            
            let ciImage = CIImage(cgImage: cgImage)
            self.filter.setValue(ciImage, forKey: kCIInputImageKey)
        }
    }
}


extension Processable {
    
    func outputUIImage() -> UIImage? {
        
        if let outputImage = self.filter.outputImage {
            let openGLContext = EAGLContext(api: .openGLES3)!
            let ciImageContext = CIContext(eaglContext: openGLContext)
            
            if let cgImageNew = ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImageNew)
            }
        }
        
        return nil
    }
}





protocol Saturationable: Processable {
    var currentSaturationValue: Float { get }
    func saturation(_ saturation: Float)
}

extension Saturationable {
    var currentSaturationValue: Float {
        return filter.value(forKey: kCIInputSaturationKey) as? Float ?? 1.00
    }
    
    func saturation(_ saturation: Float) {
        self.filter.setValue(saturation, forKey: kCIInputSaturationKey)
    }
}





class ColorControl: Saturationable  {
    let filter = CIFilter(name: "CIColorControls")!
}
```


## Usage
```swift

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    
    fileprivate var colorControl = ColorControl()
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage(named: "iceland.jpg")
        colorControl.input(imgView.image!)
        
    }
    
    
    @IBAction func slide(_ sender: UISlider) {
        
        DispatchQueue.main.async {
            self.colorControl.saturation(sender.value)
            self.imgView.image = self.colorControl.outputUIImage()
        }
    }
```
