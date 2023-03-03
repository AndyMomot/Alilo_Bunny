
import UIKit

enum EarColors {
    case red, green, teal
    case blue, purple, brown
    case orange, yellow, pinc
    case white, clear
}

@IBDesignable class HareEarView: UIView {
    
    private let shapeLayer = CAShapeLayer()
    private var fillColor: EarColors = .white
    
    override func draw(_ rect: CGRect) {
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            print("Could not get the context")
            return
        }
        drawAEar(using: currentContext)
    }
    
    // MARK: - The method that changes the color of your ears
    func changeFillColor(color: EarColors) {
        fillColor = color
        animateFillColor()
        setNeedsDisplay()
    }
    
    // MARK: Song mode
    func earAnimatingForSongsMode() {
        let zeroAnimation = CABasicAnimation(keyPath: "fillColor")
        zeroAnimation.fromValue = UIColor.yellow.cgColor
        zeroAnimation.toValue = UIColor.green.cgColor
        zeroAnimation.beginTime = 0
        zeroAnimation.duration = 1.5
        
        let firstAnimation = CABasicAnimation(keyPath: "fillColor")
        firstAnimation.fromValue = UIColor.green.cgColor
        firstAnimation.toValue = UIColor.red.cgColor
        firstAnimation.beginTime = 1.5
        firstAnimation.duration = 1.5
        
        let secondAnimation = CABasicAnimation(keyPath: "fillColor")
        secondAnimation.fromValue = UIColor.red.cgColor
        secondAnimation.toValue = UIColor.blue.cgColor
        secondAnimation.beginTime = 3
        secondAnimation.duration = 1.5
        
        let thirdAnimation = CABasicAnimation(keyPath: "fillColor")
        thirdAnimation.fromValue = UIColor.blue.cgColor
        thirdAnimation.toValue = UIColor.yellow.cgColor
        thirdAnimation.beginTime = 4.5
        thirdAnimation.duration = 1.5
        
        let animationsGroup = CAAnimationGroup()
        animationsGroup.duration = 6
        animationsGroup.repeatDuration = .infinity
        animationsGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        animationsGroup.animations = [zeroAnimation, firstAnimation, secondAnimation, thirdAnimation]
        shapeLayer.add(animationsGroup, forKey: "fillColor")
    }
}

private extension HareEarView {
    func color() -> CGColor {
        switch fillColor {
        case .red:
            return UIColor.red.cgColor
        case .green:
            return UIColor.green.cgColor
        case .teal:
            return UIColor.systemTeal.cgColor
        case .blue:
            return UIColor.blue.cgColor
        case .purple:
            return UIColor.purple.cgColor
        case .brown:
            return UIColor.brown.cgColor
        case .white:
            return UIColor.white.cgColor
        case .clear:
            return UIColor.clear.cgColor
        case .orange:
            return UIColor.orange.cgColor
        case .yellow:
            return UIColor.yellow.cgColor
        case .pinc:
            return UIColor.systemPink.cgColor
        }
    }
    
    // MARK: - The method that draws the ears
    func drawAEar(using context: CGContext) {
        
        let startPoint = CGPoint(x: 4, y: 23)
        let leftLine = CGPoint(x: 2, y: 6)
        let topCorner = CGPoint(x: 7, y: 6)
        let rightLine = CGPoint(x: 10, y: 23)
        let bottomCorner = CGPoint(x: 7, y: 23)
        
        context.move(to: startPoint)
        context.addLine(to: leftLine)
        context.addArc(center: topCorner, radius: 5, startAngle: .pi, endAngle: 0, clockwise: false)
        context.addLine(to: rightLine)
        context.addArc(center: bottomCorner, radius: 3, startAngle: 0, endAngle: .pi, clockwise: false)
        
        context.setLineWidth(0)
        context.setStrokeColor(UIColor.clear.cgColor)
        context.setFillColor(UIColor.clear.cgColor)
        
        // MARK: shapeLayer
        shapeLayer.path = context.path
        shapeLayer.fillColor = color()
        setShadow()
        context.drawPath(using: CGPathDrawingMode.fillStroke)
        
        self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: Sound mode
   func animateFillColor() {
        let animationFillColor = CABasicAnimation(keyPath: "fillColor")
        animationFillColor.fromValue = self.color()
        animationFillColor.toValue = UIColor.clear.cgColor
        animationFillColor.duration = 1.5
        animationFillColor.fillMode = .both
        animationFillColor.repeatDuration = .infinity
        animationFillColor.isRemovedOnCompletion = true
    
        shapeLayer.add(animationFillColor, forKey: "fillColor")
    }
    
    func setShadow() {
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowRadius = 10
    }
}

