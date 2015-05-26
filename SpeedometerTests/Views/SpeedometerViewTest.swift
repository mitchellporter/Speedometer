import Speedometer
import UIKit
import XCTest

class SpeedometerViewTest: XCTestCase {
    func testThatInitializerSetsRadiusCorrectly() {
        let firstView = SpeedometerView(radius: 12.0)
        let secondView = SpeedometerView(radius: 15.0)
        
        XCTAssertEqual(12.0, firstView.radius)
        XCTAssertEqual(15.0, secondView.radius)
    }
}
