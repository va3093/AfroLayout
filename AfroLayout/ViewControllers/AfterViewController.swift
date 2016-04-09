//
//  AfterViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 3/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class AfterViewController: AfroLayoutViewController {
	override func layoutViews(view1: UIView, view2: UIView, view3: UIView, viewController: UIViewController) {
		self.title = "After"

		
		viewController.view.addSubviews([self.wrapperView, view1, view2, view3])
		
		self.wrapperView.constrainToTopLeftOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
		
		view1.constrainAfterView(self.wrapperView, inView: self.view)
		view2.constrainAfterView(self.wrapperView, inView: self.view, allign: .CenterY, horizontalPadding: 32)
		view3.constrainAfterView(self.wrapperView, inView: self.view, allign: .Bottom)

	}
}

