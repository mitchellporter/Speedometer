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
        self.addMaskedSublayer()
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
        //let startColor = UIColor(red: 27.0/255.0, green: 214.0/255.0, blue: 253.0/255.0, alpha: 1.0);
        //let endColor = UIColor(red: 29.0/255.0, green: 98.0/255.0, blue: 240.0/255.0, alpha: 1.0);
        let startColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0);
        let endColor = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0);

        self.gradientLayer.colors = [startColor, endColor];
        self.gradientLayer.locations = [0.0, 0.5];
        self.gradientLayer.frame = self.bounds
    }
    
    func addMaskedSublayer() {
        self.gradientLayer.mask = self.maskLayer
        self.layer.addSublayer(self.gradientLayer)
    }
}
