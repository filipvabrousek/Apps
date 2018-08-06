class ResizableView: UIView {
    
    enum Edge {
        case topLeft, topRight, bottomLeft, bottomRight, none
    }
    
   var edgeSize: CGFloat = 44.0

    
    var currentEdge: Edge = .none
    var start = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            start = touch.location(in: self)
            
            currentEdge = {
                if sb.width - start.x < 44.0 && sb.height - start.y < 44.0 {
                    return .bottomRight
                } else if start.x < 44.0 && start.y < 44.0 {
                    return .topLeft
                } else if sb.width-start.x < 44.0 && start.y < 44.0 {
                    return .topRight
                } else if start.x < 44.0 && sb.height - start.y < 44.0 {
                    return .bottomLeft
                }
                return .none
            }()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            let previous = touch.previousLocation(in: self)
            
            let originX = self.frame.origin.x
            let originY = self.frame.origin.y
            let width = self.frame.size.width
            let height = self.frame.size.height
            
            let deltaWidth = currentPoint.x - previous.x
            let deltaHeight = currentPoint.y - previous.y
            
            switch currentEdge {
            case .topLeft:
                self.frame = CGRect(x: originX + deltaWidth, y: originY + deltaHeight, width: width - deltaWidth, height: height - deltaHeight)
            case .topRight:
                self.frame = CGRect(x: originX, y: originY + deltaHeight, width: width + deltaWidth, height: height - deltaHeight)
            case .bottomRight:
                self.frame = CGRect(x: originX, y: originY, width: currentPoint.x + deltaWidth, height: currentPoint.y + deltaWidth)
            case .bottomLeft:
                self.frame = CGRect(x: originX + deltaWidth, y: originY, width: width - deltaWidth, height: height + deltaHeight)
            default:
                // Moving
                self.center = CGPoint(x: self.center.x + currentPoint.x - start.x,
                                      y: self.center.y + currentPoint.y - start.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentEdge = .none
    }
}
