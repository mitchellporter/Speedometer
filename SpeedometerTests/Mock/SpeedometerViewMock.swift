import UIKit

class SpeedometerViewMock: SpeedometerView {
    var lastSubView: UIView?
    var setupMaskLayerCalled = false
    var setupGradientLayerCalled = false
    var mockMaskLayer: CGRect?
    
    override func addSubview(subView: UIView) {
       self.lastSubView = subView
    }
    
    override func setupMaskLayer() {
        self.setupMaskLayerCalled = true
        super.setupMaskLayer()
    }
    
    override func setupGradientLayer() {
        self.setupGradientLayerCalled = true
        super.setupGradientLayer()
    }
    
    override func maskLayerFrame() -> CGRect {
        if let maskLayer = self.mockMaskLayer {
            return maskLayer
        }
        
        return super.maskLayerFrame()
    }
}
