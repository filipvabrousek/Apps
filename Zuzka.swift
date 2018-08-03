//
//  ViewController.swift
//  ToneCurve
//
//  Created by Filip Vabroušek on 01.08.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    var stack = UIStackView()
    // var values = [CGPoint?](repeating: nil, count: 4)
    
    var values = [CGPoint]()
    
    
    @IBOutlet var RS: UISlider!
    @IBOutlet var GS: UISlider!
    @IBOutlet var BS: UISlider!
    
    // var bview = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        values.append(CGPoint(x: 0.0, y: 0.0))
        values.append(CGPoint(x: 0.0, y:0.5))
        values.append(CGPoint(x: 0.0, y: 1.0))
        imgView.image = UIImage(named: "hamilton.jpg")
        addSliders()
        //  shadow()
    }
    
    
    func addSliders(){
        // add sliders
        stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.frame = CGRect(x: 40, y: 50, width: 200, height: 150) // width is 150, height is 200
        stack.rotate(angle: 90)
        
        let rs = UISlider()
        rs.isContinuous = true
        rs.tintColor = UIColor.red
        rs.addTarget(self, action: #selector(rmoved(sender:)), for: .valueChanged)
        rs.value = 0.0
        
        let gs = UISlider()
        gs.isContinuous = true
        gs.tintColor = UIColor.green
        gs.addTarget(self, action: #selector(gmoved(sender:)), for: .valueChanged)
        gs.value = 0.5
        
        let bs = UISlider()
        bs.isContinuous = true
        bs.tintColor = UIColor.blue
        bs.value = 1.0
        bs.addTarget(self, action: #selector(bmoved(sender:)), for: .valueChanged)
        
        
        stack.addArrangedSubview(rs)
        stack.addArrangedSubview(gs)
        stack.addArrangedSubview(bs)
        view.addSubview(stack)
        redraw(points: values)
    }
    
    
    @objc func rmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: stack.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ? // SWAPPED
        
        values[0] = CGPoint(x: 245 , y: Double(sender.value) * Double(stack.frame.height))
        listPoints()
        redraw(points: values)
        //saturated(to: sender.value)
    }
    
    @objc func gmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: stack.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ?
        values[1] = CGPoint(x: 145, y: Double(sender.value) * Double(stack.frame.height) )
        listPoints()
        redraw(points: values)
        //contrasted(to: sender.value)
    }
    
    @objc func bmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: stack.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ?
        values[2] = CGPoint(x: 45, y: Double(sender.value) * Double(stack.frame.height))
        print("OP \(Double(sender.value) * Double(stack.frame.height))")
        listPoints()
        redraw(points: values)
        // contrasted(to: sender.value)
    }
    
    
    
    
    func listPoints(){
            shadow(to: values[0].y)
            highlight(to: values[1].y)
            midtone(to: values[2].y)
    }
    
    
    var views = [UIView]()
    var tag = 0
    
    func redraw(points: [CGPoint]){
        tag += 1
        
        var fr = CGRect(x: 40, y: 60, width: 300, height: 200)
        var f = Dview(frame:fr, points: points)
        // f.transform = CGAffineTransform(scaleX: -1, y: 1) // sideway mirrored :D
        f.backgroundColor = UIColor.orange
        f.tag = tag
        views.append(f)
        view.addSubview(views[views.count - 1])
        
        var e = stack
        e.frame = fr
        view.addSubview(e)
        for v in views{
            if v != views[views.count - 1]{
                v.removeFromSuperview()
            }
        }
    }
    
    
    func shadow(to: CGFloat){
        let inp = CIImage(image: imgView.image!)!
        
        let filter = CIFilter(name: "CIHighlightShadowAdjust")
        filter?.setValue(inp, forKey: "inputImage")
        //  filter?.setValue(1, forKey: "inputHighlightAmount")
        filter?.setValue(to, forKey: "inputShadowAmount")
        
        let res = filter?.value(forKey: "outputImage") as! CIImage
        let cgi = CIContext(options: nil).createCGImage(res, from: res.extent)
        let ret = UIImage(cgImage: cgi!, scale: (imgView.image?.scale)!, orientation: (imgView.image?.imageOrientation)!)
        imgView.image = ret
        
        print("Shadow called")
    }
    
    func highlight(to:CGFloat) {
        let inp = CIImage(image: imgView.image!)!
        
        let filter = CIFilter(name: "CIHighlightShadowAdjust")
        filter?.setValue(inp, forKey: "inputImage")
        filter?.setValue(1, forKey: "inputHighlightAmount")
        // filter?.setValue(to + 3, forKey: "inputShadowAmount")
        
        let res = filter?.value(forKey: "outputImage") as! CIImage
        let cgi = CIContext(options: nil).createCGImage(res, from: res.extent)
        let ret = UIImage(cgImage: cgi!, scale: (imgView.image?.scale)!, orientation: (imgView.image?.imageOrientation)!)
        imgView.image = ret
        
        print("Highlight called")
    }
    
    // https://stackoverflow.com/questions/49820710/cifilters-to-show-clipped-highlights-and-shadows
    
    func midtone(to:CGFloat){
        let inp = CIImage(image: imgView.image!)!
        
        let filter = CIFilter(name: "CIGammaAdjust")
        filter?.setValue(inp, forKey: "inputImage")
       // filter?.setValue(1, forKey: kCIInput)
        // filter?.setValue(to + 3, forKey: "inputShadowAmount")
        
        let res = filter?.value(forKey: "outputImage") as! CIImage
        let cgi = CIContext(options: nil).createCGImage(res, from: res.extent)
        let ret = UIImage(cgImage: cgi!, scale: (imgView.image?.scale)!, orientation: (imgView.image?.imageOrientation)!)
        imgView.image = ret
        print("Midtone called")
    }
    
    
   
}


extension UIStackView {
    func rotate(angle:CGFloat){
        let rad = angle / 180.0 * CGFloat.pi
        let rot = CGAffineTransform(rotationAngle: rad)
        self.transform = rot
    }
}

