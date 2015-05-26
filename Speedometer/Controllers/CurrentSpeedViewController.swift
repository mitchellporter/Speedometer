import QuartzCore
import UIKit

class CurrentSpeedViewController: UIViewController {
    var backgroundLayer: CAGradientLayer!
    var speedometerView: SpeedometerView!
    var currentSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        self.backgroundLayer = CAGradientLayer()
        self.setupBackgroundLayer()
        self.view.layer.addSublayer(self.backgroundLayer)
        
        let radius = 100.0
        self.speedometerView = SpeedometerView(frame: self.speedometerFrame(radius), radius: radius, maxSpeed: 200.0)
        self.view.addSubview(self.speedometerView)
        
        self.currentSpeedLabel = UILabel(frame: self.view.frame)
        self.currentSpeedLabel.center = self.speedometerView.center
        self.currentSpeedLabel.textColor = UIColor.whiteColor()
        self.currentSpeedLabel.font = UIFont(name: "Avenir", size: 36.0)
        self.currentSpeedLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.currentSpeedLabel)
        
        self.setSpeed(0.0)
        self.startTimer()
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

    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
    }
    
    func updateSpeed() {
        let randomSpeed = 200.0 * Double(arc4random()) / 0xFFFFFFFF
        self.setSpeed(randomSpeed)
    }
    
    func setSpeed(speed: Double) {
        self.speedometerView.setSpeed(speed)
        self.currentSpeedLabel.text = "\(Int(speed)) kmph"
    }
}
