import UIKit
import XCTest
@testable import AfroLayout_Example

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		
    }

	func testValidateHorizontalAttributes() {
		let view = UIView()
		XCTAssert(view.validateHorizontalAttributes(forStackViews: [UIView()], horizontalAttributes: [[]]))
		XCTAssertFalse(view.validateHorizontalAttributes(forStackViews: [UIView()], horizontalAttributes: []))
	}
	
	func testValidateHorizontalRelations() {
		let attributes = [[NSLayoutAttribute.Top]]
		let view = UIView()
		XCTAssert(view.validateHorizontalRelations(attributes, horizontalRelations: [[]]))
		XCTAssertFalse(view.validateHorizontalRelations(attributes, horizontalRelations: []))
	}
	
	func testValidateHorizontalPadding() {
		let attributes = [[NSLayoutAttribute.Top]]
		let view = UIView()
		XCTAssert(view.validateHorizontalPadding(attributes, horizontalPadding: [[]]))
		XCTAssertFalse(view.validateHorizontalPadding(attributes, horizontalPadding: []))
	}
	
	func testValidateViews() {
		let view = UIView()
		XCTAssert(view.validateViews(forAttributes: [.Top], views: [UIView()]))
		XCTAssertFalse(view.validateViews(forAttributes: [.Top], views: []))
	}
	
    func testZeroStackViewsDoesntCrash() {
        let view = UIView()
        let mockViews = [UIView]()
        view.stackViews(mockViews)
        // passes if doesnt crash
    }
    
    func testZeroHorizontalStackViewsDoesntCrash() {
        let view = UIView()
        let mockViews = [UIView]()
        view.stackHorizontallViews(mockViews)
        // passes if doesnt crash
    }
}

extension UIView {
	func abortWithMessage(message: String) {
		
	}
}

