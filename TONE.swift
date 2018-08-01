//
//  ViewController.swift
//  ToneCurve
//
//  Created by Filip Vabroušek on 01.08.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var stack: UIStackView! // stackview with 3 sliders
    @IBOutlet var imgView: UIImageView!
    
    var values = [CGPoint?](repeating: nil, count: 4)
    
    @IBOutlet var RS: UISlider!
    @IBOutlet var GS: UISlider!
    @IBOutlet var BS: UISlider!
    
    var bview = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = UIImage(named: "hamilton.jpg")
        stack.distribution = .fillEqually
        stack.frame = CGRect(x: 50, y: 80, width: 200, height: 150) // width is 150, height is 200
        stack.rotate(angle: 90)
        // values.reserveCapacity(3) // space for 3 elements
        
        RS.addTarget(self, action: #selector(rmoved(sender:)), for: .valueChanged)
        GS.addTarget(self, action: #selector(gmoved(sender:)), for: .valueChanged)
        BS.addTarget(self, action: #selector(bmoved(sender:)), for: .valueChanged)
        addView()
    }
    
    func addView(){
        bview = UIView()
        bview.backgroundColor = UIColor.green
        bview.alpha = 0.3
        bview.frame = CGRect(x: 50, y: 80, width: 150, height: 200) // rotated
        view.addSubview(bview)
        view.sendSubview(toBack: bview)
    }
    
    @objc func rmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: sender.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ? // SWAPPED
        
        values[0] = center
        listPoints()
        saturated(to: sender.value)
    }
    
    @objc func gmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: sender.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ?
        values[1] = center
        listPoints()
        contrasted(to: sender.value)
    }
    
    @objc func bmoved(sender:UISlider){
        let track = sender.trackRect(forBounds: sender.bounds)
        let thumb = sender.thumbRect(forBounds: sender.bounds, trackRect: track, value: sender.value)
        let center = CGPoint(x: thumb.origin.y, y: thumb.origin.x) // + 30 - 60 ?
        values[2] = center
        listPoints()
        contrasted(to: sender.value)
    }
    
    
    
    
    func listPoints(){
        
        for (i, val) in values.enumerated(){
            if values[i] != nil {
                print("Point \(i + 1): x: \(values[i]!.x) y: \(values[i]!.y)")
            }
        }
        print("------------------------------------")
        
        if values[0] != nil && values[1] != nil && values[2] != nil {
            let first = CGPoint(x: (values[0]?.x)!, y: (values[2]?.y)!) // 0
            let second = CGPoint(x: ((values[1]?.x)! + 67.0), y: (values[1]?.y)!)
            let third = CGPoint(x: ((values[2]?.x)! + 134.0), y: (values[0]?.y)!) // 2
            //  drawLine(first: first, second: second, third: third, above: bview)
            // quadCurved(points: values, above: bview) cast
        }
        
        
    }
    
    var prevPoint:CGPoint = CGPoint(x: 0, y: 0)
    var isFirst = true
    
    func drawLine(first:CGPoint, second: CGPoint, third:CGPoint, above: UIView){ // make it to UIStackView
        
        
        var path = UIBezierPath()
        path.move(to: first)
        path.addLine(to: second)
        path.move(to: second)
        path.addLine(to: third)
        
        
        
        var shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.blue.cgColor
        shape.lineWidth = 3.0
        above.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        above.layer.addSublayer(shape)
    }
    
    func quadCurved(points: [CGPoint], above: UIView){
        var path = UIBezierPath()
        var p = points[0]
        path.move(to: p)
        
        if points.count == 2 {
            p = points[1]
            var p2 = points[2]
            path.addLine(to: p2)
        }
        
        for (i, val) in points.enumerated() {
            p = points[i]
            var p2 = p
            var mid = getMid(p1: p, p2: p2)
            path.addQuadCurve(to: mid, controlPoint: getControlPoint(p1: p, p2: p2))
            path.addQuadCurve(to: p2, controlPoint: getMid(p1: mid, p2: p2))
        }
    }
    
    
    func getMid(p1:CGPoint, p2:CGPoint) -> CGPoint{
        return CGPoint(x: (p1.x + p2.x) / CGFloat(2.0), y: (p1.y + p2.y) / CGFloat(2.0))
    }
    
    func getControlPoint(p1:CGPoint, p2:CGPoint) -> CGPoint {
        var control = getMid(p1: p1, p2: p2)
        let difY = abs(p2.y - control.y)
        
        if p1.y < p2.y{
            control.y += difY
        } else if p1.y > p2.y{
            control.y = -difY
        }
        
        return control
    }
    
    
    
    
    
    
    
    func contrasted(to:Float) {
        //   imgView.image = UIImage(named: "hamilton.jpg")
        let inp = CIImage(image: imgView.image!)!
        let param = [
            "inputContrast": NSNumber(value: to)  // 1 is default value to / 10 * 10
        ]
        let out = inp.applyingFilter("CIColorControls", parameters: param)
        let cgi = CIContext(options: nil).createCGImage(out, from: out.extent)
        let ret = UIImage(cgImage: cgi!, scale: (imgView.image?.scale)!, orientation: (imgView.image?.imageOrientation)!)
        imgView.image = ret
    }
    
    func saturated(to:Float)  { // fix
        print("to \(to)")
        let img = imgView.image?.cgImage
        let ci = CIImage(cgImage: img!)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ci, forKey: "inputImage")
        filter?.setValue(to, forKey: "inputSaturation")
        let res = filter?.value(forKey: "outputImage") as! CIImage
        let cgi = CIContext(options: nil).createCGImage(res, from: res.extent)
        let ret = UIImage(cgImage: cgi!, scale: (imgView.image?.scale)!, orientation: (imgView.image?.imageOrientation)!)
        imgView.image = ret
    }
    
    
    
    
}


extension UIStackView {
    func rotate(angle:CGFloat){
        let rad = angle / 180.0 * CGFloat.pi
        let rot = CGAffineTransform(rotationAngle: rad)
        self.transform = rot
    }
}
