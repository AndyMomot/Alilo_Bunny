import Foundation
import UIKit

enum BunnyBodyColors {
    case red, green, teal
    case blue, purple, brown
    case white
}

@IBDesignable class BunnyBodyView: UIView {
    
    private let shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            print("Could not get the context")
            return
        }
        // MARK: Call the method with the required ear color
        drawBunnyBody(using: currentContext)
    }
    
    // MARK: - The method that draws the ears
    private func drawBunnyBody(using context: CGContext) {
        
        // MARK: - right side
        context.addArc(center: CGPoint(x: 40, y: 35), radius: 15, startAngle: .pi * (3 / 2), endAngle: .pi * 11 / 6, clockwise: false)
        context.addArc(center: CGPoint(x: 40, y: 40), radius: 15, startAngle: 0, endAngle: .pi / 4, clockwise: false)
        context.addArc(center: CGPoint(x: 55, y: 60), radius: 10, startAngle: .pi * 5 / 4, endAngle: .pi , clockwise: true)
        context.addArc(center: CGPoint(x: 60, y: 70), radius: 15, startAngle: .pi * 6 / 6, endAngle: .pi * 2 / 3 , clockwise: true) //
        context.addArc(center: CGPoint(x: 60, y: 100), radius: 10, startAngle: .pi * 5 / 3, endAngle: 0 , clockwise: false) //
        context.addArc(center: CGPoint(x: 60, y: 105), radius: 10, startAngle: 0, endAngle: .pi / 3 , clockwise: false)
        context.addLine(to: CGPoint(x: 40, y: 114))
        
        // MARK: left side
        context.addArc(center: CGPoint(x: 40, y: 35), radius: 15, startAngle: .pi * 3 / 2, endAngle: .pi, clockwise: true)
        context.addArc(center: CGPoint(x: 40, y: 40), radius: 15, startAngle: .pi, endAngle: .pi * 3 / 4, clockwise: true)
        context.addArc(center: CGPoint(x: 25, y: 60), radius: 10, startAngle: .pi * 7 / 4, endAngle: 0 , clockwise: false)
        context.addArc(center: CGPoint(x: 20, y: 70), radius: 15, startAngle: .pi * 12 / 6, endAngle: .pi / 3 , clockwise: false)
        context.addArc(center: CGPoint(x: 20, y: 100), radius: 10, startAngle: .pi * 4 / 3, endAngle: .pi , clockwise: true) //
        context.addArc(center: CGPoint(x: 20, y: 105), radius: 10, startAngle: .pi, endAngle: .pi * 2 / 3 , clockwise: true)
        context.addLine(to: CGPoint(x: 40, y: 114))
        
        context.setLineWidth(3)
        context.setStrokeColor(UIColor.clear.cgColor)
        context.setFillColor(UIColor.clear.cgColor)
        
        // MARK: shapeLayer
        shapeLayer.path = context.path
        shapeLayer.fillColor = UIColor.white.cgColor
        
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowRadius = 3
        
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        self.layer.addSublayer(shapeLayer)
    }
}
