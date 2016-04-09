//
//  BottomViewController.swift
//  AfroLayout
//
//  Created by Wilhelm Van Der Walt on 3/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class BottomViewController: AfroLayoutViewController {
	override func layoutViews(view1: UIView, view2: UIView, view3: UIView, viewController: UIViewController) {
		
		self.title = "Bottom"

		viewController.view.addSubviews([self.wrapperView])
		self.wrapperView.addSubviews([view1])
		
		self.wrapperView.constrainToBottomOfView(viewController.view, bottomLayoutGuide: viewController.bottomLayoutGuide)
		
		view1.constrainToBottomOfView(self.wrapperView)
	}
}
