import QuartzCore
import UIKit

class CurrentSpeedViewController: UIViewController {
    var backgroundLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        self.backgroundLayer = CAGradientLayer()
        self.setupBackgroundLayer()
        self.view.layer.addSublayer(self.backgroundLayer)
        
        let radius = 100.0
        let speedometerView = SpeedometerView(frame: self.speedometerFrame(radius), radius: radius, maxSpeed: 200.0)
        speedometerView.setSpeed(160.0)
        self.view.addSubview(speedometerView)
    }
    
    func speedometerFrame(radius: Double) -> CGRect {
        var speedometerFrame = CGRectMake(CGFloat(0.0), CGFloat(0.0), CGFloat(2 * radius + 25.0), CGFloat(2 * radius + 25.0))
        speedometerFrame.origin.x = CGRectGetMidX(self.view.bounds) - CGRectGetMidX(speedometerFrame)
        speedometerFrame.origin.y = CGRectGetMidY(self.view.bounds) - CGRectGetMidY(speedometerFrame)
        
        return speedometerFrame
    }
    
    override func viewWillLayoutSubviews() {
        self.setupBackgroundLayer()
    }
    
    func setupBackgroundLayer() {
        let startColor = UIColor(red: 27.0/255.0, green: 214.0/255.0, blue: 253.0/255.0, alpha: 1.0);
        let endColor = UIColor(red: 29.0/255.0, green: 98.0/255.0, blue: 240.0/255.0, alpha: 1.0);
        
        self.backgroundLayer.locations = [0.0, 0.5]
        self.backgroundLayer.colors = [startColor.CGColor, endColor.CGColor]
        self.backgroundLayer.frame = self.view.bounds
    }
}
