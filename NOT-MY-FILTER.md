## First
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

```


## Saturationable
```swift
import CoreImage

protocol Saturationable: Processable {
    var minSaturationValue: Float { get }
    var maxSaturationValue: Float { get }
    var currentSaturationValue: Float { get }
    func saturation(_ saturation: Float)
}

extension Saturationable {
    
    var minSaturationValue: Float {
        return 0.00
    }
    
    var maxSaturationValue: Float {
        return 2.00
    }
    
    var currentSaturationValue: Float {
        return filter.value(forKey: kCIInputSaturationKey) as? Float ?? 1.00
    }
    
    func saturation(_ saturation: Float) {
        self.filter.setValue(saturation, forKey: kCIInputSaturationKey)
    }
}
```



## Color control
```swift
class ColorControl: Saturationable {
    
    // MARK: - Properties
    
    let filter = CIFilter(name: "CIColorControls")!
}

```


## slide
```swift
    @IBAction func saturationUISliderPressed(_ sender: UISlider) {
        if let indexPath = self.visibleCurrentCell {
            let cell = self.collectionView.cellForItem(at: indexPath) as! MultipleColorCell
            colorControlsFilter.setValue(sender.value, forKey: kCIInputSaturationKey)
            self.saturationLabel.text = "Saturation \(sender.value)"
            
            if let outputImage = self.colorControlsFilter.outputImage {
                if let cgImageNew = self.ciImageContext.createCGImage(outputImage, from: outputImage.extent) {
                    let newImg = UIImage(cgImage: cgImageNew)
                    cell.imageView.image = newImg
                }
            }
        }
        
        print("Saturation: \(sender.value)")
    }
}

```
