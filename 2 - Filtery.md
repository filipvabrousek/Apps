# Filtery 

# View Controller
```swift
//
//  ViewController.swift
//  SOImagePickerController
//
//  Created by myCompany on 9/6/16.
//  Copyright © 2016 myCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SOCropVCDelegate {
    
    var delegate: SOCropVCDelegate?
    var context:CIContext = CIContext(options: nil)
    var filter: CIFilter!
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    /*------------------------------------------------------SEPIA------------------------------------------------------*/
    @IBAction func sepia(_ sender: Any) {
        let applied = CIFilter(name: "CISepiaTone")
        let begin = CIImage(image: imgView.image!)
        applied?.setValue(begin, forKey: kCIInputImageKey)
        
        let cg = context.createCGImage((applied?.outputImage!)!, from: (applied?.outputImage!.extent)!)
        let filtered = UIImage(cgImage: cg!)
        self.imgView.image = filtered
    }
    
    
    /*------------------------------------------------------SAVE------------------------------------------------------*/
    @IBAction func save(_ sender: Any) {
        let data =  UIImageJPEGRepresentation(imgView.image!, 0.8)
        let compressed = UIImage(data: data!)
        UIImageWriteToSavedPhotosAlbum(compressed!, nil, nil, nil)
    }
    
    
    /*------------------------------------------------------IMPORT PHOTO------------------------------------------------------*/
    @IBAction func importPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true;
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    /*------------------------------------------------------DID FINISH PACKING------------------------------------------------------*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*---------------------------------------------------------ACTION CROP IMAGE---------------------------------------------------------*/
    @IBAction func actionCropImage(_ sender: AnyObject) {
        if imgView.image != nil {
            let obj = Crop()
            obj.imgOriginal = imgView.image
            obj.isAllowCropping = true
            obj.cropSize = CGSize(width: 320, height: 320)
            obj.delegate = self
            self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
    
    
    /*---------------------------------------------------------IMAGECROPVC---------------------------------------------------------*/
    func imagecropvc(_ imagecropvc:Crop, finishedcropping:UIImage) {
        imgView.image = finishedcropping
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



```







# SOCropVC


```swift
import UIKit
import CoreGraphics

internal protocol SOCropVCDelegate {
    func imagecropvc(_ imagecropvc:SOCropVC, finishedcropping:UIImage)
}


```



## SOCropVC class

```swift

internal class Crop: UIViewController {
    
    var imgOriginal: UIImage!
    var delegate: SOCropVCDelegate?
    var cropSize: CGSize!
    var isAllowCropping = false
    fileprivate var imgCropped: UIImage!
    fileprivate var imageCropView: SOImageCropView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        self.setupCropView()
    }
    
    
    
    
    //------------------------------------------- VIEW WILL LAYOUT SUBVIEWS
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imageCropView.frame = self.view.bounds
        setupBottomViewView()
    }
    
    
    /*------------------------------------------- SETUP BOTTOM VIEWS
     add cancel and crop views and add correposnding actions
     setup cropview using:
     "SOImageCropView(frame: self.view.bounds)"
     */
    
    func setupBottomViewView() {
        let viewBottom = UIView()
        viewBottom.frame = CGRect(x: 0, y: self.view.frame.size.height-64, width: self.view.frame.size.width, height: 64)
        viewBottom.backgroundColor = UIColor.darkGray
        self.view.addSubview(viewBottom)
        
        let btnCancel = UIButton()
        btnCancel.frame = CGRect(x: 10, y: 17, width: 60, height: 30)
        btnCancel.layer.cornerRadius = 5.0
        btnCancel.layer.masksToBounds = true
        btnCancel.setTitleColor(UIColor.black, for: UIControlState())
        btnCancel.setTitle("Cancel", for: UIControlState())
        btnCancel.backgroundColor = UIColor.white
        btnCancel.addTarget(self, action: #selector(actionCancel), for: .touchUpInside)
        viewBottom.addSubview(btnCancel)
        
        let btnCrop = UIButton()
        btnCrop.frame = CGRect(x: self.view.frame.size.width-50-10, y: 17, width: 50, height: 30)
        btnCrop.layer.cornerRadius = 5.0
        btnCrop.layer.masksToBounds = true
        btnCrop.setTitleColor(UIColor.black, for: UIControlState())
        btnCrop.setTitle("Crop", for: UIControlState())
        btnCrop.backgroundColor = UIColor.white
        btnCrop.addTarget(self, action: #selector(actionCrop), for: .touchUpInside)
        viewBottom.addSubview(btnCrop)
        
    }
    
    //------------------------------------------- ACTION CANCEL
    func actionCancel(_ sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //------------------------------------------- ACTION CROP
    func actionCrop(_ sender: AnyObject) {
        imgCropped = self.imageCropView.croppedImage()
        self.delegate?.imagecropvc(self, finishedcropping:imgCropped)
        self.actionCancel(nil)
    }
    
    
    //------------------------------------------- SETUP CROP VIEWS
    fileprivate func setupCropView() {
        self.imageCropView = SOImageCropView(frame: self.view.bounds)
        self.imageCropView.imgCrop = imgOriginal
        self.imageCropView.isAllowCropping = self.isAllowCropping
        self.imageCropView.cropSize = cropSize
        self.view.addSubview(self.imageCropView)
    }
}







```


## SOCropBorderView

```swift
internal class SOCropBorderView: UIView {
    fileprivate let kCircle: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    
    //------------------------------------------- DRAW
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor(red: 0.16, green: 0.25, blue: 0.75, alpha: 0.5).cgColor)
        context?.setLineWidth(1.5)
        context?.addRect(CGRect(x: kCircle / 2, y: kCircle / 2,
                                width: rect.size.width - kCircle, height: rect.size.height - kCircle))
        context?.strokePath()
        
        context?.setFillColor(red: 0.16, green: 0.25, blue: 0.35, alpha: 0.95)
        for handleRect in calculateAllNeededHandleRects() {
            context?.fillEllipse(in: handleRect)
        }
    }
    
    
    //------------------------------------------- CALCULATE ALL NEEDED
    fileprivate func calculateAllNeededHandleRects() -> [CGRect] {
        
        let width = self.frame.width
        let height = self.frame.height
        
        let leftColX: CGFloat = 0
        let rightColX = width - kCircle
        let centerColX = rightColX / 2
        
        let topRowY: CGFloat = 0
        let bottomRowY = height - kCircle
        let middleRowY = bottomRowY / 2
        
        //starting with the upper left corner and then following clockwise
        let topLeft = CGRect(x: leftColX, y: topRowY, width: kCircle, height: kCircle)
        let topCenter = CGRect(x: centerColX, y: topRowY, width: kCircle, height: kCircle)
        let topRight = CGRect(x: rightColX, y: topRowY, width: kCircle, height: kCircle)
        let middleRight = CGRect(x: rightColX, y: middleRowY, width: kCircle, height: kCircle)
        let bottomRight = CGRect(x: rightColX, y: bottomRowY, width: kCircle, height: kCircle)
        let bottomCenter = CGRect(x: centerColX, y: bottomRowY, width: kCircle, height: kCircle)
        let bottomLeft = CGRect(x: leftColX, y: bottomRowY, width: kCircle, height: kCircle)
        let middleLeft = CGRect(x: leftColX, y: middleRowY, width: kCircle, height: kCircle)
        
        return [topLeft, topCenter, topRight, middleRight, bottomRight, bottomCenter, bottomLeft,
                middleLeft]
    }
}


```




## ScrollView

```swift
private class ScrollView: UIScrollView {
    fileprivate override func layoutSubviews() {
        super.layoutSubviews()
        
        if let zoomView = self.delegate?.viewForZooming?(in: self) {
            let boundsSize = self.bounds.size
            var frameToCenter = zoomView.frame
            
            // center horizontally
            if frameToCenter.size.width < boundsSize.width {
                frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
            } else {
                frameToCenter.origin.x = 0
            }
            
            // center vertically
            if frameToCenter.size.height < boundsSize.height {
                frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
            } else {
                frameToCenter.origin.y = 0
            }
            
            zoomView.frame = frameToCenter
        }
    }
}

```




## SOImageCropView

```swift
internal class SOImageCropView: UIView, UIScrollViewDelegate {
    var isAllowCropping = false
    
    fileprivate var scrollView: UIScrollView!
    fileprivate var imageView: UIImageView!
    fileprivate var cropOverlayView: SOCropOverlayView!
    fileprivate var xOffset: CGFloat!
    fileprivate var yOffset: CGFloat!
    
    
    
    //------------------------------------------- SCALE RECT
    fileprivate static func scaleRect(_ rect: CGRect, scale: CGFloat) -> CGRect {
        return CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale)
    }
    
    var imgCrop: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    var cropSize: CGSize {
        get {
            return self.cropOverlayView.cropSize
        }
        set {
            if let view = self.cropOverlayView {
                view.cropSize = newValue
            } else {
                if self.isAllowCropping {
                    self.cropOverlayView = SOResizableCropOverlayView(frame: self.bounds,
                                                                      initialContentSize: CGSize(width: newValue.width, height: newValue.height))
                } else {
                    self.cropOverlayView = SOCropOverlayView(frame: self.bounds)
                }
                self.cropOverlayView.cropSize = newValue
                self.addSubview(self.cropOverlayView)
            }
        }
    }
    
    
    
    //------------------------------------------- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.black
        self.scrollView = ScrollView(frame: frame)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.clipsToBounds = false
        self.scrollView.decelerationRate = 0
        self.scrollView.backgroundColor = UIColor.clear
        self.addSubview(self.scrollView)
        
        self.imageView = UIImageView(frame: self.scrollView.frame)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.backgroundColor = UIColor.black
        self.scrollView.addSubview(self.imageView)
        
        self.scrollView.minimumZoomScale =
            self.scrollView.frame.width / self.scrollView.frame.height
        self.scrollView.maximumZoomScale = 20
        self.scrollView.setZoomScale(1.0, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //------------------------------------------- HIT TEST
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isAllowCropping {
            return self.scrollView
        }
        
        let resizableCropView = cropOverlayView as! SOResizableCropOverlayView
        let outerFrame = resizableCropView.cropBorderView.frame.insetBy(dx: -10, dy: -10)
        
        if outerFrame.contains(point) {
            if resizableCropView.cropBorderView.frame.size.width < 60 ||
                resizableCropView.cropBorderView.frame.size.height < 60 {
                return super.hitTest(point, with: event)
            }
            
            let innerTouchFrame = resizableCropView.cropBorderView.frame.insetBy(dx: 30, dy: 30)
            if innerTouchFrame.contains(point) {
                return self.scrollView
            }
            
            let outBorderTouchFrame = resizableCropView.cropBorderView.frame.insetBy(dx: -10, dy: -10)
            if outBorderTouchFrame.contains(point) {
                return super.hitTest(point, with: event)
            }
            
            return super.hitTest(point, with: event)
        }
        
        return self.scrollView
    }
    
    
    
    //------------------------------------------- LAYOUT SUBVIEWS
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = self.cropSize;
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        self.xOffset = floor((self.bounds.width - size.width) * 0.5)
        self.yOffset = floor((self.bounds.height - toolbarSize - size.height) * 0.5)
        
        let height = self.imgCrop!.size.height
        let width = self.imgCrop!.size.width
        
        var factor: CGFloat = 0
        var factoredHeight: CGFloat = 0
        var factoredWidth: CGFloat = 0
        
        if width > height {
            factor = width / size.width
            factoredWidth = size.width
            factoredHeight =  height / factor
        } else {
            factor = height / size.height
            factoredWidth = width / factor
            factoredHeight = size.height
        }
        
        self.cropOverlayView.frame = self.bounds
        self.scrollView.frame = CGRect(x: xOffset, y: yOffset, width: size.width, height: size.height)
        self.scrollView.contentSize = CGSize(width: size.width, height: size.height)
        self.imageView.frame = CGRect(x: 0, y: floor((size.height - factoredHeight) * 0.5),
                                      width: factoredWidth, height: factoredHeight)
    }
    
    
    //------------------------------------------- VIEW FOR ZOOMING
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    
    //------------------------------------------- CROPPED IMAGE
    func croppedImage() -> UIImage {
        // Calculate rect that needs to be cropped
        var visibleRect = isAllowCropping ?
            calcVisibleRectForResizeableCropArea() : calcVisibleRectForCropArea()
        
        // transform visible rect to image orientation
        let rectTransform = orientationTransformedRectOfImage(imgCrop!)
        visibleRect = visibleRect.applying(rectTransform);
        
        // finally crop image
        let imageRef = imgCrop!.cgImage?.cropping(to: visibleRect)
        let result = UIImage(cgImage: imageRef!, scale: imgCrop!.scale,
                             orientation: imgCrop!.imageOrientation)
        
        return result
    }
    
    
    
    /*------------------------------------------- CALC VISIBLE RECT FOR RESIZABLE CROP AREA
     
     1) first of all, get the size scale by taking a look at the real image dimensions. Here it
     doesn't matter if you take the width or the hight of the image, because it will always
     be scaled in the exact same proportion of the real image
     
     2) get the postion of the cropping rect inside the image
     
     */
    
    fileprivate func calcVisibleRectForResizeableCropArea() -> CGRect {
        
        //1
        let resizableView = cropOverlayView as! SOResizableCropOverlayView
        var sizeScale = self.imageView.image!.size.width / self.imageView.frame.size.width
        sizeScale *= self.scrollView.zoomScale
        
        //2
        var visibleRect = resizableView.contentView.convert(resizableView.contentView.bounds, to: imageView)
        visibleRect = SOImageCropView.scaleRect(visibleRect, scale: sizeScale)
        return visibleRect
    }
    
    
    //------------------------------------------- CALC VISIBLE RECT FOR CROP AREA
    fileprivate func calcVisibleRectForCropArea() -> CGRect {
        // scaled width/height in regards of real width to crop width
        let scaleWidth = imgCrop!.size.width / cropSize.width
        let scaleHeight = imgCrop!.size.height / cropSize.height
        var scale: CGFloat = 0
        
        if cropSize.width == cropSize.height {
            scale = max(scaleWidth, scaleHeight)
        } else if cropSize.width > cropSize.height {
            scale = imgCrop!.size.width < imgCrop!.size.height ?
                max(scaleWidth, scaleHeight) :
                min(scaleWidth, scaleHeight)
        } else {
            scale = imgCrop!.size.width < imgCrop!.size.height ?
                min(scaleWidth, scaleHeight) :
                max(scaleWidth, scaleHeight)
        }
        
        // extract visible rect from scrollview and scale it
        var visibleRect = scrollView.convert(scrollView.bounds, to:imageView)
        visibleRect = SOImageCropView.scaleRect(visibleRect, scale: scale)
        
        return visibleRect
    }
    
    
    
    //------------------------------------------- ORIENTATION TRANSFORMED REDCT OF IMAGE
    fileprivate func orientationTransformedRectOfImage(_ image: UIImage) -> CGAffineTransform {
        var rectTransform: CGAffineTransform!
        
        switch image.imageOrientation {
        case .left:
            rectTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2)).translatedBy(x: 0, y: -image.size.height)
        case .right:
            rectTransform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2)).translatedBy(x: -image.size.width, y: 0)
        case .down:
            rectTransform = CGAffineTransform(rotationAngle: CGFloat(-M_PI)).translatedBy(x: -image.size.width, y: -image.size.height)
        default:
            rectTransform = CGAffineTransform.identity
        }
        
        return rectTransform.scaledBy(x: image.scale, y: image.scale)
    }
}





```





## SOResizableCropOverlayView
```swift

internal class SOResizableCropOverlayView: SOCropOverlayView {
    fileprivate let kBorderWidth: CGFloat = 12
    
    var contentView: UIView!
    var cropBorderView: SOCropBorderView!
    
    fileprivate var initialContentSize = CGSize(width: 0, height: 0)
    fileprivate var resizingEnabled: Bool!
    fileprivate var anchor: CGPoint!
    fileprivate var startPoint: CGPoint!
    
    var widthValue: CGFloat!
    var heightValue: CGFloat!
    var xValue: CGFloat!
    var yValue: CGFloat!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            
            let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
            let width = self.bounds.size.width
            let height = self.bounds.size.height
            
            contentView?.frame = CGRect(x: (
                width - initialContentSize.width) / 2,
                                        y: (height - toolbarSize - initialContentSize.height) / 2,
                                        width: initialContentSize.width,
                                        height: initialContentSize.height)
            
            cropBorderView?.frame = CGRect(
                x: (width - initialContentSize.width) / 2 - kBorderWidth,
                y: (height - toolbarSize - initialContentSize.height) / 2 - kBorderWidth,
                width: initialContentSize.width + kBorderWidth * 2,
                height: initialContentSize.height + kBorderWidth * 2)
        }
    }
    
    
    //------------------------------------------- INIT
    init(frame: CGRect, initialContentSize: CGSize) {
        super.init(frame: frame)
        
        self.initialContentSize = initialContentSize
        self.addContentViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    //------------------------------------------- TOUCHES BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: cropBorderView)
            
            anchor = self.calculateAnchorBorder(touchPoint)
            fillMultiplyer()
            resizingEnabled = true
            startPoint = touch.location(in: self.superview)
        }
    }
    
    //------------------------------------------- TOUCHES MOVED
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if resizingEnabled! {
                self.resizeWithTouchPoint(touch.location(in: self.superview))
            }
        }
    }
    
    
    //------------------------------------------- DRAW
    override func draw(_ rect: CGRect) {
        //fill outer rect
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).set()
        UIRectFill(self.bounds)
        
        //fill inner rect
        UIColor.clear.set()
        UIRectFill(self.contentView.frame)
    }
    
    
    
    //------------------------------------------- ADD CONTENT VIEW
    fileprivate func addContentViews() {
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        contentView = UIView(frame: CGRect(x: (
            width - initialContentSize.width) / 2,
                                           y: (height - toolbarSize - initialContentSize.height) / 2,
                                           width: initialContentSize.width,
                                           height: initialContentSize.height))
        contentView.backgroundColor = UIColor.clear
        self.cropSize = contentView.frame.size
        self.addSubview(contentView)
        
        cropBorderView = SOCropBorderView(frame: CGRect(
            x: (width - initialContentSize.width) / 2 - kBorderWidth,
            y: (height - toolbarSize - initialContentSize.height) / 2 - kBorderWidth,
            width: initialContentSize.width + kBorderWidth * 2,
            height: initialContentSize.height + kBorderWidth * 2))
        self.addSubview(cropBorderView)
    }
    
    
    
    //------------------------------------------- CALCULATE ANCHOR BORDER
    fileprivate func calculateAnchorBorder(_ anchorPoint: CGPoint) -> CGPoint {
        let allHandles = getAllCurrentHandlePositions()
        var closest: CGFloat = 3000
        var anchor: CGPoint!
        
        for handlePoint in allHandles {
            // Pythagoras is watching you :-)
            let xDist = handlePoint.x - anchorPoint.x
            let yDist = handlePoint.y - anchorPoint.y
            let dist = sqrt(xDist * xDist + yDist * yDist)
            
            closest = dist < closest ? dist : closest
            anchor = closest == dist ? handlePoint : anchor
        }
        
        return anchor
    }
    
    
    
    //------------------------------------------- GET ALL CURRENT HANDLERS POSITION
    fileprivate func getAllCurrentHandlePositions() -> [CGPoint] {
        let leftX: CGFloat = 0
        let rightX = cropBorderView.bounds.size.width
        let centerX = leftX + (rightX - leftX) / 2
        
        let topY: CGFloat = 0
        let bottomY = cropBorderView.bounds.size.height
        let middleY = topY + (bottomY - topY) / 2
        
        // starting with the upper left corner and then following the rect clockwise
        let topLeft = CGPoint(x: leftX, y: topY)
        let topCenter = CGPoint(x: centerX, y: topY)
        let topRight = CGPoint(x: rightX, y: topY)
        let middleRight = CGPoint(x: rightX, y: middleY)
        let bottomRight = CGPoint(x: rightX, y: bottomY)
        let bottomCenter = CGPoint(x: centerX, y: bottomY)
        let bottomLeft = CGPoint(x: leftX, y: bottomY)
        let middleLeft = CGPoint(x: leftX, y: middleY)
        
        return [topLeft, topCenter, topRight, middleRight, bottomRight, bottomCenter, bottomLeft,
                middleLeft]
    }
    
    
    
    
    //------------------------------------------- RESIING WITH TOUCH POINT
    fileprivate func resizeWithTouchPoint(_ point: CGPoint) {
        // This is the place where all the magic happends
        // prevent goint offscreen...
        let border = kBorderWidth * 2
        var pointX = point.x < border ? border : point.x
        var pointY = point.y < border ? border : point.y
        pointX = pointX > self.superview!.bounds.size.width - border ?
            self.superview!.bounds.size.width - border : pointX
        pointY = pointY > self.superview!.bounds.size.height - border ?
            self.superview!.bounds.size.height - border : pointY
        
        let heightNew = (pointY - startPoint.y) * heightValue
        let widthNew = (startPoint.x - pointX) * widthValue
        let xNew = -1 * widthNew * xValue
        let yNew = -1 * heightNew * yValue
        
        var newFrame =  CGRect(
            x: cropBorderView.frame.origin.x + xNew,
            y: cropBorderView.frame.origin.y + yNew,
            width: cropBorderView.frame.size.width + widthNew,
            height: cropBorderView.frame.size.height + heightNew);
        newFrame = self.preventBorderFrameFromGettingTooSmallOrTooBig(newFrame)
        self.resetFrame(to: newFrame)
        startPoint = CGPoint(x: pointX, y: pointY)
    }
    
    
    
    
    //------------------------------------------- PREVENT BORDER FRAME FROM GETTING UP TOO SMALL OR TOO BIG
    fileprivate func preventBorderFrameFromGettingTooSmallOrTooBig(_ frame: CGRect) -> CGRect {
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        var newFrame = frame
        
        if newFrame.size.width < 64 {
            newFrame.size.width = cropBorderView.frame.size.width
            newFrame.origin.x = cropBorderView.frame.origin.x
        }
        if newFrame.size.height < 64 {
            newFrame.size.height = cropBorderView.frame.size.height
            newFrame.origin.y = cropBorderView.frame.origin.y
        }
        
        if newFrame.origin.x < 0 {
            newFrame.size.width = cropBorderView.frame.size.width +
                (cropBorderView.frame.origin.x - self.superview!.bounds.origin.x)
            newFrame.origin.x = 0
        }
        
        if newFrame.origin.y < 0 {
            newFrame.size.height = cropBorderView.frame.size.height +
                (cropBorderView.frame.origin.y - self.superview!.bounds.origin.y)
            newFrame.origin.y = 0
        }
        
        if newFrame.size.width + newFrame.origin.x > self.frame.size.width {
            newFrame.size.width = self.frame.size.width - cropBorderView.frame.origin.x
        }
        
        if newFrame.size.height + newFrame.origin.y > self.frame.size.height - toolbarSize {
            newFrame.size.height = self.frame.size.height -
                cropBorderView.frame.origin.y - toolbarSize
        }
        
        return newFrame
    }
    
    
    //------------------------------------------- RESET FRAME
    fileprivate func resetFrame(to frame: CGRect) {
        cropBorderView.frame = frame
        contentView.frame = frame.insetBy(dx: kBorderWidth, dy: kBorderWidth)
        cropSize = contentView.frame.size
        self.setNeedsDisplay()
        cropBorderView.setNeedsDisplay()
    }
    
    
    //------------------------------------------- FILL MULTIPLYER
    fileprivate func fillMultiplyer() {
        heightValue = anchor.y == 0 ?
            -1 : anchor.y == cropBorderView.bounds.size.height ? 1 : 0
        widthValue = anchor.x == 0 ?
            1 : anchor.x == cropBorderView.bounds.size.width ? -1 : 0
        xValue = anchor.x == 0 ? 1 : 0
        yValue = anchor.y == 0 ? 1 : 0
    }
}

```





## SOCropOverlayView


```swift
internal class SOCropOverlayView: UIView {
    
    var cropSize: CGSize!
    var toolbar: UIToolbar!
    
    
    //------------------------------------------- INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
    }
    
    
    
    //------------------------------------------- INIT
    override func draw(_ rect: CGRect) {
        
        let toolbarSize = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 0 : 54)
        
        let width = self.frame.width
        let height = self.frame.height - toolbarSize
        
        let heightSpan = floor(height / 2 - self.cropSize.height / 2)
        let widthSpan = floor(width / 2 - self.cropSize.width / 2)
        
        // fill outer rect
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).set()
        UIRectFill(self.bounds)
        
        // fill inner border
        UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).set()
        UIRectFrame(CGRect(x: widthSpan - 2, y: heightSpan - 2, width: self.cropSize.width + 4,
                           height: self.cropSize.height + 4))
        
        // fill inner rect
        UIColor.clear.set()
        UIRectFill(CGRect(x: widthSpan, y: heightSpan, width: self.cropSize.width, height: self.cropSize.height))
    }
}




```
