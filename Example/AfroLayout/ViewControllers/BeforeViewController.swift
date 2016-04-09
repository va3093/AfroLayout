//
//  BeforeViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 3/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BeforeViewController: AfroLayoutViewController {
	override func layoutViews(view1: UIView, view2: UIView, view3: UIView, viewController: UIViewController) {
		self.title = "Before"

		viewController.view.addSubviews([self.wrapperView, view1, view2, view3])
		
		self.wrapperView.constrainToTopRightOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
		
		view1.constrainBeforeView(self.wrapperView, inView: self.view)
		view2.constrainBeforeView(self.wrapperView, inView: self.view, allign: .CenterY, horizontalPadding: -32)
		view3.constrainBeforeView(self.wrapperView, inView: self.view, allign: .Bottom)
	}
}

