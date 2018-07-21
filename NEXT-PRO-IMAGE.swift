import UIKit

import CoreGraphics

struct Pixel {
    
    public var raw: UInt32
    
    public init(rawVal: UInt32){
        raw = rawVal
    }
    
    public init(r:UInt8, g:UInt8, b:UInt8) { // we limit usage of colours to 255
        raw = 0xFF000000 | UInt32(r) | UInt32(g) << 8 | UInt32(b) << 16
    }
    
    public init(uiColor: UIColor){
        var r: CGFloat = 0.0
        var g:CGFloat = 0.0
        var b: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        self.init(r: UInt8(r * 255), g: UInt8(r * 255), b: UInt8(r * 255))
    }
    
    
    
    public var red: UInt8 {
        get { return UInt8(raw & 0xFF)}
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var green: UInt8{
        get { return UInt8(raw & 0xFF)}
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var blue: UInt8{
        get {return UInt8(raw & 0xFF)}
        set {raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var alpha:UInt8 {
        get {return UInt8((raw & 0xFF000000) >> 24)}
        set {raw = (UInt32(newValue) << 24) | (raw & 0x00FFFFFF)}
    }
    
    public var averageIntensity: UInt8{
        get {return UInt8 ((UInt32(red) + UInt32(green) + UInt32(blue)) / 3)}
    }
    
    public func toUIColor() -> UIColor {
        return UIColor(
            red: CGFloat(self.red) / CGFloat(255),
            green: CGFloat(self.green) / CGFloat(255),
            blue: CGFloat(self.blue) / CGFloat(255),
            alpha: CGFloat(self.alpha) / CGFloat(255))
    }
}



class Image {
    let pixels: UnsafeMutableBufferPointer<Pixel> // allocate memory for the image data
    let width: Int
    let height: Int
    let space = CGColorSpaceCreateDeviceRGB()
    let bitmap: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue // what kind of pixel we want to decode (32 bit pixels)
    let bits = Int(8) // 32 bit representation of each pixel (32 / colours (r, g, b, alpha) = 8)
    let rowBits: Int
    
    /*------------------------------------------------FIRST INIT-------------------------------------------------------------*/
    init(width: Int, height: Int){ // use a t the bottom
        self.width = width
        self.height = height
        rowBits = 4 * width // bits per row
        let rawData = UnsafeMutablePointer<Pixel>.allocate(capacity: (width * height))
        // allocate buffer for all the pixels (temporary storage of data between proccesses)
        pixels = UnsafeMutableBufferPointer<Pixel>(start: rawData, count: width * height)
    }
    
    
    /*------------------------------------------------2ND INIT-------------------------------------------------------------*/
    init(image: UIImage){
        height = Int(image.size.height)
        width = Int(image.size.width)
        rowBits = 4 * width // bits per row
        
        // create and draw image from data
        let rawData = UnsafeMutablePointer<Pixel>.allocate(capacity: (width * height))
        let zero = CGPoint.zero // X[0,0]
        let rect = CGRect(origin: zero, size: image.size) // create rect for the image
        let ctx = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bits, bytesPerRow: rowBits, space: space, bitmapInfo: bitmap)
        ctx?.draw(image.cgImage!, in: rect) // draw new image from data
        pixels = UnsafeMutableBufferPointer<Pixel>(start: rawData, count: width * height)
    }
    
    
    /*----------------------------------------------TO UIIMAGE-----------------------------------------------------------*/
    func toUIImage() -> UIImage { // convert image to UIImage
        let ctx = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bits, bytesPerRow: rowBits, space: space, bitmapInfo: bitmap) // different constructor ???
        return UIImage(cgImage: ctx!.makeImage()!)
    }
    
    /*----------------------------------------------GET AND SET PIXELS-----------------------------------------------------------*/
    func getPixel(x:Int, y:Int) -> Pixel {
        return pixels[x+y*width]
    }
    
    func setPixel(value: Pixel, x:Int, y:Int) { // change values in pixels array
        pixels[x+y*width] = value
    }
    
    
    /*----------------------------------------------TRANSFORM-----------------------------------------------------------*/
    func transform(cb: (Pixel) -> Pixel) -> Image{
        let new = Image(width: self.width, height: self.height)
        
        for x in 0 ..< width{
            for y in 0 ..< height{
                let p = getPixel(x: x, y: y)
                let s = cb(p) // apply content of the block at each pixel
                new.setPixel(value: s, x: x, y: y) // compose image from pixels
            }
        }
        
        return new
    }
    
}



let image = UIImage(named: "small.png")!
let img = Image(image: image)
img.transform { (px:Pixel) -> Pixel in
    var p = px
    p.red = UInt8(0)
    return p
}
img.toUIImage()




/*
 EXPLANATION:
 (use playground)
 
 let image = UIImage(named: "small.png")!
 let h = Int(image.size.height)
 let w = Int(image.size.width)
 
 
 let cbits = 8 // 32 bit representation of each pixel / 4 colours (r, g, b, alpha)
 let rbirts = 4 * w // row bits
 
 let space = CGColorSpaceCreateDeviceRGB() // decoding to RGBA space
 let raw = UnsafeMutablePointer<UInt32>.allocate(capacity: w * h)
 // allocate buffer for all the pixels (temporary storage of data between proccesses)
 
 // what kind of pixel we want to decode (32 bit pixels)
 let bitmap:UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
 
 
 
 let ctx = CGContext(data: raw, width: w, height: h, bitsPerComponent: cbits, bytesPerRow: rbirts, space: space, bitmapInfo: bitmap)
 let rect = CGRect(origin: CGPoint.zero, size: image.size)
 ctx?.draw(image.cgImage!, in: rect)
 
 
 let pixels = UnsafeMutableBufferPointer<UInt32>(start: raw, count: w * h)
 let output = CGContext(data: pixels.baseAddress, width: w, height: h, bitsPerComponent: cbits,bytesPerRow: rbirts,space: space,bitmapInfo: bitmap,releaseCallback: nil,releaseInfo: nil)
 let result = UIImage(cgImage: (output?.makeImage())!)
 
 
 
 */

// https://medium.com/@micosmin/swift-enums-basics-b2b306750e7e
// Bond 26 4.11.2022
