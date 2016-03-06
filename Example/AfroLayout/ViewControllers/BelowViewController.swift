//
//  BelowViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 3/6/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BelowViewController: AfroLayoutViewController {
	override func layoutViews(view1: UIView, view2: UIView, view3: UIView, viewController: UIViewController) {
		self.title = "Below"
		viewController.view.addSubviews([self.wrapperView, view1, view2, view3])
		
		self.wrapperView.constrainToTopOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
		
		view1.constrainBelowView(self.wrapperView, inView: self.view)
		view2.constrainBelowView(self.wrapperView, inView: self.view, allign: .CenterX, verticalPadding: 32)
		view3.constrainBelowView(self.wrapperView, inView: self.view, allign: .Trailing)
		
	}
}
