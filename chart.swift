override func drawInContext(ctx: CGContext!)
    {
        if let curveValues = toneCurveEditor?.curveValues
        {
            var path = UIBezierPath()
    
            let margin = 20
            let thumbRadius = 15
            let widgetWidth = Int(frame.width)
            let widgetHeight = Int(frame.height) - margin - margin - thumbRadius - thumbRadius

            var interpolationPoints : [CGPoint] = [CGPoint]()
            
            for (i: Int, value: Double) in enumerate(curveValues)
            {
                let pathPointX = i * (widgetWidth / curveValues.count) + (widgetWidth / curveValues.count / 2)
                let pathPointY = thumbRadius + margin + widgetHeight - Int(Double(widgetHeight) * value)
                
                interpolationPoints.append(CGPoint(x: pathPointX,y: pathPointY))
            }
     
            path.interpolatePointsWithHermite(interpolationPoints)
       
            CGContextSetLineJoin(ctx, kCGLineJoinRound)
            CGContextAddPath(ctx, path.CGPath)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextSetLineWidth(ctx, 6)
            CGContextStrokePath(ctx)
        }

    }





import Foundation
import UIKit


extension UIBezierPath
{
    func interpolatePointsWithHermite(interpolationPoints : [CGPoint], alpha: CGFloat = 1.0/3.0)
    {
        guard !interpolationPoints.isEmpty else { return }
        self.moveToPoint(interpolationPoints[0])
        
        let n = interpolationPoints.count - 1
        
        for index in 0..<n
        {
            var currentPoint = interpolationPoints[index]
            var nextIndex = (index + 1) % interpolationPoints.count
            var prevIndex = index == 0 ? interpolationPoints.count - 1 : index - 1
            var previousPoint = interpolationPoints[prevIndex]
            var nextPoint = interpolationPoints[nextIndex]
            let endPoint = nextPoint
            var mx : CGFloat
            var my : CGFloat
            
            if index > 0
            {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else
            {
                mx = (nextPoint.x - currentPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            
            let controlPoint1 = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
            currentPoint = interpolationPoints[nextIndex]
            nextIndex = (nextIndex + 1) % interpolationPoints.count
            prevIndex = index
            previousPoint = interpolationPoints[prevIndex]
            nextPoint = interpolationPoints[nextIndex]
            
            if index < n - 1
            {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else
            {
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
            
            self.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
    }
}





import UIKit
import Foundation

extension UIImage
{
    func resizeToBoundingSquare(boundingSquareSideLength boundingSquareSideLength : CGFloat) -> UIImage
    {
        let imgScale = self.size.width > self.size.height ? boundingSquareSideLength / self.size.width : boundingSquareSideLength / self.size.height
        let newWidth = self.size.width * imgScale
        let newHeight = self.size.height * imgScale
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(newSize)
        
        self.drawInRect(CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        
        return resizedImage
    }
}



