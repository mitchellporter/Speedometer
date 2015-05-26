import UIKit
import XCTest

class SpeedometerViewTest: XCTestCase {
    func testThatInitializerSetsRadiusCorrectly() {
        let firstView = SpeedometerView(frame: CGRectZero, radius: 12.0)
        let secondView = SpeedometerView(frame: CGRectZero, radius: 15.0)
        
        XCTAssertEqual(12.0, firstView.radius)
        XCTAssertEqual(15.0, secondView.radius)
    }
    
    func testThatInitializerCallsSuperInitWithFrame() {
        let firstFrame = CGRectMake(10.0, 20.0, 30.0, 40.0)
        let secondFrame = CGRectMake(5, 10.0, 15.0, 1.0)
        
        let firstView = SpeedometerView(frame: firstFrame, radius: 12.0)
        let secondView = SpeedometerView(frame: secondFrame, radius: 15.0)
        
        XCTAssertEqual(firstFrame, firstView.frame)
        XCTAssertEqual(secondFrame, secondView.frame)
    }
    
    func testThatInitializerCallsCreateMaskLayer() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 0.0)
        
        XCTAssertTrue(view.setupMaskLayerCalled)
    }
    
    func testThatInitializerCallsCreateGradientLayer() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 0.0)
        
        XCTAssertTrue(view.setupGradientLayerCalled)
    }
    
    func testThatMaskLayerFrameReturnsCorrectFrame() {
        let view = SpeedometerView(frame: CGRectMake(10.0, 20.0, 30.0, 40.0), radius: 13.0)
        
        let frame = view.maskLayerFrame()
        
        XCTAssertEqual(CGRectMake(2.0, 7.0, 26.0, 26.0), frame)
    }
    
    func testThatSetupMaskLayerSetsLayerPropertiesCorrectly() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 15.0)
        view.bounds = CGRectMake(0.0, 0.0, 3.0, 4.0)
        view.mockMaskLayer = CGRectMake(0.0, 0.0, 20.0, 20.0)
        
        view.setupMaskLayer()
        
        XCTAssertTrue(CGRectEqualToRect(view.bounds, view.maskLayer.frame))
        XCTAssertTrue(CGPathEqualToPath(UIBezierPath(ovalInRect: view.mockMaskLayer!).CGPath, view.maskLayer.path))
    }
    
    func testThatSetupGradientLayerSetsLayerPropertiesCorrectly() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 15.0)
        view.bounds = CGRectMake(0.0, 0.0, 3.0, 4.0)
        view.mockMaskLayer = CGRectMake(0.0, 0.0, 20.0, 20.0)
        
        view.setupGradientLayer()
        
        XCTAssertTrue(CGRectEqualToRect(view.bounds, view.gradientLayer.frame))
        XCTAssertEqual(2, view.gradientLayer.locations.count)
        XCTAssertEqual(0.0, view.gradientLayer.locations[0] as! Double)
        XCTAssertEqual(0.5, view.gradientLayer.locations[1] as! Double)
        XCTAssertEqual(2, view.gradientLayer.colors.count)
        XCTAssertEqual(UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0), view.gradientLayer.colors[0] as! UIColor)
        XCTAssertEqual(UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0), view.gradientLayer.colors[1] as! UIColor)
    }
    
    func testThatInitializerAddsMaskedSublayer() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 2.0)
        
        XCTAssertTrue(view.addMaskedSublayerCalled)
    }
    
    func testThatAddMaskedSublayerAddsSublayer() {
        let view = SpeedometerView(frame: CGRectZero, radius: 3.0)
        
        view.addMaskedSublayer()
        
        XCTAssertTrue(contains(view.layer.sublayers as! [CALayer], view.gradientLayer))
        XCTAssertEqual(view.gradientLayer.mask, view.maskLayer)
    }
    
    func testThatLayoutingSubviewsTriggerSettingUpLayers() {
        let view = SpeedometerViewMock(frame: CGRectZero, radius: 11.0)
        
        view.layoutSubviews()
        
        XCTAssertTrue(view.setupMaskLayerCalled)
        XCTAssertTrue(view.setupGradientLayerCalled)
    }
}
