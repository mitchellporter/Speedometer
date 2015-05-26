import UIKit

public class SpeedometerView: UIView {
    public let radius: Double
    let maskLayer: CAShapeLayer
    let gradientLayer: CAGradientLayer

    // MARK: - Initializers
    
    public init(frame: CGRect, radius: Double)  {
        self.radius = radius
        self.maskLayer = CAShapeLayer()
        self.gradientLayer = CAGradientLayer()

        super.init(frame: frame)
        
        self.setupMaskLayer()
        self.setupGradientLayer()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("SpeedometerView does not support NSCoding")
    }
    
    func setupMaskLayer() -> Void {
        self.maskLayer.frame = self.bounds
        self.maskLayer.path = UIBezierPath(ovalInRect: self.maskLayerFrame()).CGPath
    }
    
    func maskLayerFrame() -> CGRect {
        var maskLayerFrame = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(2 * self.radius), CGFloat(2 * self.radius))
        maskLayerFrame.origin.x = CGRectGetMidX(self.bounds) - CGRectGetMidX(maskLayerFrame)
        maskLayerFrame.origin.y = CGRectGetMidY(self.bounds) - CGRectGetMidY(maskLayerFrame)
        
        return maskLayerFrame
    }
    
    func setupGradientLayer() -> Void {
    }
}
