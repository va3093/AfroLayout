//
//  SimpleAnimationViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 1/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SimpleAnimationViewController: UIViewController {
	
	//MARK: Instance Variables
	
	//MARK: Views
	
	lazy private(set) var customView: UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.redColor()
		view.addDimensions(width: 50.0, height: 50.0)
		return view
	}()
	
	//MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Simple Animation"
		self.view.backgroundColor = UIColor.whiteColor()
		
		self.view.addSubview(self.customView)
		self.customView.addCustomConstraints(inView: self.view, selfAttributes: [.CenterX, .CenterY])
		
		self.customView.animateView(1.0, delay: 1.0, options: [.CurveEaseInOut], newConstraintsClosure: {[weak self] () -> () in
			if let strongSelf = self {
				strongSelf.customView.addCustomConstraints(inView: strongSelf.view, selfAttributes: [.CenterX, .CenterY], padding: [100, 100])
			}
			})
		
	}
	
	//MARK: Business Logic
	
}