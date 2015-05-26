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
}
