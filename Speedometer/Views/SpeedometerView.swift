import QuartzCore
import UIKit

public class SpeedometerView: UIView {
    public let radius: Double
    public let maxSpeed: Double
    let maskLayer: CAShapeLayer
    let gradientLayer: CAGradientLayer
    var currentSpeed = 0.0

    // MARK: - Initializers
    
    public init(frame: CGRect, radius: Double, maxSpeed: Double)  {
        self.radius = radius
        self.maxSpeed = maxSpeed
        self.maskLayer = CAShapeLayer()
        self.gradientLayer = CAGradientLayer()

        super.init(frame: frame)
        
        self.setupMaskLayer()
        self.setupGradientLayer()
        self.addMaskedSublayer()
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("SpeedometerView does not support NSCoding")
    }
    
    func setupMaskLayer() -> Void {
        self.maskLayer.frame = self.bounds
        self.maskLayer.path = UIBezierPath(ovalInRect: self.maskLayerFrame()).CGPath
        self.maskLayer.strokeColor = UIColor.blackColor().CGColor
        self.maskLayer.fillColor = UIColor.clearColor().CGColor
        self.maskLayer.lineWidth = 25.0
        self.maskLayer.strokeStart = 0.1
        self.maskLayer.strokeEnd = 0.9

        let rotateTransform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        self.maskLayer.setAffineTransform(rotateTransform)
    }
    
    func maskLayerFrame() -> CGRect {
        var maskLayerFrame = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(2 * self.radius), CGFloat(2 * self.radius))
        maskLayerFrame.origin.x = CGRectGetMidX(self.bounds) - CGRectGetMidX(maskLayerFrame)
        maskLayerFrame.origin.y = CGRectGetMidY(self.bounds) - CGRectGetMidY(maskLayerFrame)
        
        return maskLayerFrame
    }
    
    func setupGradientLayer() -> Void {
        let startColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0);
        let endColor = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0);

        self.gradientLayer.colors = [startColor.CGColor, endColor.CGColor];
        self.gradientLayer.locations = [0.0, 0.5];
        self.gradientLayer.frame = self.bounds
    }
    
    func addMaskedSublayer() {
        self.gradientLayer.mask = self.maskLayer
        self.layer.addSublayer(self.gradientLayer)
    }
    
    // MARK: - Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        self.setupMaskLayer()
        self.setupGradientLayer()
        self.gradientLayer.mask = self.maskLayer
        
        self.setSpeed(self.currentSpeed)
    }
    
    // MARK: - Utilities
    
    public func setSpeed(speed: Double) {
        self.currentSpeed = speed
        
        let ratio = self.currentSpeed / self.maxSpeed
        let end = 0.8 * ratio + 0.1
        
        self.maskLayer.strokeEnd = CGFloat(end)
    }
}
