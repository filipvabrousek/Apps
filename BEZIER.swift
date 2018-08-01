
import UIKit
import CoreGraphics

class Dview: UIView{
    
      var points = [CGPoint?](repeating: nil, count: 4)
    
     init(frame: CGRect, points: [CGPoint]) {
        super.init(frame: frame)
        self.points = points
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath()

        var points = [CGPoint(x: 70, y: 30), CGPoint(x: 130, y: 120), CGPoint(x: 190, y: 30)] // has to have 3 elements !!!!
        
        for p in points{
            var cpath = UIBezierPath(arcCenter: p, radius: 10, startAngle: 0, endAngle: 360, clockwise: true)
            var shl = CAShapeLayer()
            shl.path = cpath.cgPath
            shl.fillColor = UIColor.orange.cgColor
            self.layer.addSublayer(shl)
        }
        
        path.lineWidth = 3.0
        UIColor.white.setStroke()
        path.move(to: points[0])
        
        var mid = getMid(p1: points[0], p2: points[1])
        path.addQuadCurve(to: mid, controlPoint: getControlPoint(p1: mid, p2: points[0]))
        path.addQuadCurve(to: points[1], controlPoint: getControlPoint(p1: mid, p2: points[1]))
        
        var msrd = getMid(p1: points[1], p2: points[2])
        path.addQuadCurve(to: msrd, controlPoint: getControlPoint(p1: msrd, p2: points[1]))
        path.addQuadCurve(to: points[2], controlPoint: getControlPoint(p1: msrd, p2: points[2]))
        path.stroke()
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





