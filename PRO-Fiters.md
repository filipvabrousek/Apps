## Image class
```swift

//
//  Image.swift
//  Filtery
//
//  Created by Filip Vabroušek on 23.08.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit


public class Image {
    
    let pixels: UnsafeMutableBufferPointer<RGBAPixel>
    let height: Int
    let width: Int
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
    let bitsPerComponent = Int(8)
    let bytesPerRow: Int
    
    
    /*-----------------------------------------------------------------------------------------------------------------------------*/
    public init(width: Int, height: Int){
        
        self.height = height
        self.width = width
        bytesPerRow = 4 * width
        let rawData = UnsafeMutablePointer<RGBAPixel>.allocate(capacity: (width * height))
        pixels = UnsafeMutableBufferPointer<RGBAPixel>(start: rawData, count: width * height)
    }
    
    
    
    /*-----------------------------------------------------------------------------------------------------------------------------*/
    public init(image: UIImage){
        
        height = Int(image.size.height)
        width = Int(image.size.width)
        bytesPerRow = 4 * width
        
        let rawData = UnsafeMutablePointer<RGBAPixel>.allocate(capacity: (width * height))
        let CGPointZero = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: CGPointZero, size: image.size)
        
        let imageContext = CGContext(data: rawData,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: bitsPerComponent,
                                     bytesPerRow: bytesPerRow,
                                     space: colorSpace,
                                     bitmapInfo: bitmapInfo)
        
        imageContext?.draw(image.cgImage!, in: rect)
        
        pixels = UnsafeMutableBufferPointer<RGBAPixel>(start: rawData, count: width * height)
    }
    
    
    
    
    
    
    
    
    
    
    /*---------------------------------------------------------TO UIIMAGE--------------------------------------------------------------------*/
    public func toUIImage() -> UIImage{
        let outContext = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bitsPerComponent,bytesPerRow: bytesPerRow,space: colorSpace,bitmapInfo: bitmapInfo,releaseCallback: nil,releaseInfo: nil)
        
        return UIImage(cgImage: outContext!.makeImage()!)
    }
    
    
    /*------------------------------------------------------------GET AND SET PIXEL-----------------------------------------------------------------*/
    public func getPixel(x: Int, y:Int) -> RGBAPixel{
        return pixels[x+y*width]
    }
    
    
    public func setPixel(value: RGBAPixel, x: Int, y:Int) {
        pixels[x+y*width] = value
    }
    
    
    
    /*------------------------------------------------------------------TRANSFORM PIXELS-----------------------------------------------------------*/
    public func transformPixels(transformFunc: (RGBAPixel) -> RGBAPixel) -> Image{
        
        let newImage = Image(width: self.width, height: self.height)
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let p1 = getPixel(x: x, y: y)
                let p2 = transformFunc(p1)
                newImage.setPixel(value: p2, x: x, y: y)
            }
        }
        return newImage
    }
    
}



```


## Filters

```swift
import Foundation

protocol Filter{
    func apply(input: Image) -> Image
}

protocol AdjustableFilter: Filter{
    var value: Double {get set}
    var min: Double { get }
    var max: Double {get }
    var defaultValue:Double {get}
}



class Intensity:Filter, AdjustableFilter{
    
    var value: Double
    let min:Double = 0.0
    let max:Double = 0.0
    let defaultValue:Double = 0.5
    
    init(setValue:Double ){
        self.value = setValue
    }
    
    func apply(input: Image) -> Image {
        return input.transformPixels(transformFunc: { (p1: RGBAPixel) -> RGBAPixel in
            var p = p1
            p.red = UInt8(Double(p.red) * self.value)
            p.green = UInt8(Double(p.green) * self.value)
            p.blue = UInt8(Double(p.green) * self.value)
            return p
        })
    }
}



```

## RGBAPixel struct
```swift

public struct RGBAPixel {

    /*-----------------------------------------------------------------------------------------------------------------------------*/
    public init(rawVal: UInt32){
        raw = rawVal
    }
    
    
    public var raw: UInt32
    
    public var red:UInt8 {
        get { return UInt8(raw & 0xFF) }
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    
    public var green:UInt8 {
        get { return UInt8( (raw & 0xFF00) >> 8)}
        set { raw = (UInt32(newValue) << 8) | (raw & 0xFFFF00FF)}
    }
    
    
    public var blue:UInt8 {
        get { return UInt8( (raw & 0xFF0000) >> 16) }
        set { raw = (UInt32(newValue) << 16) | (raw & 0xFF00FFFF)}
    }
    
    
    public var alpha:UInt8 {
        get { return UInt8( (raw & 0xFF000000) >> 24) }
        set { raw = (UInt32(newValue) << 24) | (raw & 0x00FFFFFF)}
    }
}

```

## Usage
```swift
 func weird(){
        
        let image = Image(image: imgView.image!)
        let f = O(intensity: 0.1)
        let image2 = f.apply(input: image)
        imgView.image = image2.toUIImage()
    }
    

```
