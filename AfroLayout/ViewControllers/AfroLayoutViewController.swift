//
//  AfroLayoutViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 3/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class AfroLayoutViewController: UIViewController {
	
	lazy private(set) var customView1: UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.redColor()
		view.addDimensions(width: 50.0, height: 50.0)
		return view
	}()
	
	lazy private(set) var customView2: UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.blueColor()
		view.addDimensions(width: 60.0, height: 50.0)
		return view
	}()
	
	lazy private(set) var customView3: UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.greenColor()
		view.addDimensions(width: 50.0, height: 40.0)
		return view
	}()
	
	lazy private(set) var wrapperView: UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
		view.addDimensions(width: 200.0, height: 200.0)
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.layoutViews(customView1, view2: customView2, view3: customView3, viewController: self)
		self.view.backgroundColor = UIColor.whiteColor()
	}
	
	func layoutViews(view1: UIView, view2: UIView, view3: UIView, viewController: UIViewController) {

	}
}
