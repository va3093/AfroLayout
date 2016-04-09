//
//  VerticalStackingViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 1/17/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class VerticalStackingViewController: UIViewController {
	
	//MARK: Instance Variables
	
	//MARK: Views
	
	lazy private(set) var wrapperView1 : UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.lightGrayColor()
		return view
		
	}()
	
	lazy private(set) var wrapperView2 : UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.lightGrayColor()
		return view
		
	}()
	
	lazy private(set) var wrapperView3 : UIView = {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.lightGrayColor()
		return view
		
	}()
	
	//MARK: LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.whiteColor()
		
		self.stackWrapperView1()
		
		self.stackWrapperView2()
		
		self.stackWrapperView3()
		
		
	}
	
	func stackWrapperView1() {
		self.view.addSubview(self.wrapperView1)
		self.wrapperView1.addCustomConstraints(inView: self.view, toViews: [self.topLayoutGuide, self.view,self.view], selfAttributes: [.Top, .Leading, .Trailing], otherViewAttributes: [.Bottom, .Leading, .Trailing], padding: [8.0, 8.0, -8.0])
		
		let view1 = self.view1()
		view1.addDimensions(width: 100.0)
		let view2 = self.view2()
		view2.addDimensions(width: 200.0)
		let view3 = self.view3()
		view3.addDimensions(width: 300.0)
		
		let stackedViews = [view1, view2, view3]
		self.wrapperView1.addSubviews(stackedViews)
		self.wrapperView1.stackViews(stackedViews,
			horizontalAttributes:[[.Leading, .Trailing], [.Leading, .Trailing], [.Leading, .Trailing]],
			horizontalPaddings: [[60.0, -8.0], [100.0, -100.0], [8.0, -20.0]] ,
			gapPadding: 8.0,
			topPadding: 8.0,
			bottomPadding: 8.0)
		
	}
	
	
	func stackWrapperView2() {
		self.view.addSubview(self.wrapperView2)
		self.wrapperView2.addCustomConstraints(inView: self.view, toViews: [self.wrapperView1, self.wrapperView1, self.wrapperView1], selfAttributes: [.Top, .Leading, .Trailing], otherViewAttributes: [.Bottom, .Leading, .Trailing], padding: [8.0, 0.0, 0.0])
		
		let view1 = self.view1()
		view1.addDimensions(width: 100.0)
		let view2 = self.view2()
		view2.addDimensions(width: 200.0)
		let view3 = self.view3()
		view3.addDimensions(width: 50.0)
		
		let stackedViews = [view1, view2, view3]
		self.wrapperView2.addSubviews(stackedViews)
		self.wrapperView2.stackViews(stackedViews,
			gapPadding: 8.0,
			topPadding: 8.0,
			bottomPadding: 8.0)
		
	}
	
	func stackWrapperView3() {
		self.view.addSubview(self.wrapperView3)
		self.wrapperView3.addCustomConstraints(inView: self.view, toViews: [self.wrapperView2, self.wrapperView2, self.wrapperView2], selfAttributes: [.Top, .Leading, .Trailing], otherViewAttributes: [.Bottom, .Leading, .Trailing], padding: [8.0, 0.0, 0.0])
		
		let view1 = self.view1()
		view1.addDimensions(width: 100.0)
		let view2 = self.view2()
		view2.addDimensions(width: 200.0)
		let view3 = self.view3()
		view3.addDimensions(width: 50.0)
		
		let stackedViews = [view1, view2, view3]
		self.wrapperView3.addSubviews(stackedViews)
		
		
		
		self.wrapperView3.stackViews(stackedViews,
			horizontalAttributes:[[.Leading, .Trailing], [.Leading, .Trailing], [.Leading, .Trailing]],
			horizontalPaddings: [[0.0, -8.0], [0.0, -8.0], [0.0, -8.0]] ,
			horizontalRelations: [[.GreaterThanOrEqual, .Equal], [.GreaterThanOrEqual, .Equal], [.GreaterThanOrEqual, .Equal]],
			gapPadding: 8.0,
			topPadding: 8.0,
			bottomPadding: 8.0)
		
		
	}
	
	//MARK: Business Logic
	
 
	
	func view1() -> UIView {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.blueColor()
		view.addDimensions(height: 30.0)
		return view
	}
	
	func view2() -> UIView {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.blackColor()
		view.addDimensions(height: 30.0)
		return view
	}
	
	func view3() -> UIView {
		let view = UIView.withAutoLayout()
		view.backgroundColor = UIColor.redColor()
		view.addDimensions(height: 30.0)
		return view
	}
	
 
	
}