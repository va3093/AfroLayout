//
//  AfroLayout.swift
//  Pods
//
//  Created by Wilhelm Van Der Walt on 1/7/16.
//
//

import Foundation
import UIKit
import ObjectiveC


extension UIView {
	
	public class func withAutoLayout() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
	
	public func addSubviews(views: [UIView]) {
		for view in views {
			self.addSubview(view)
		}
	}
	
	public func stackViews(
		stackedViews: [UIView],
        topLayoutGuide: UILayoutSupport? = nil,
		horizontalAttributes: [[NSLayoutAttribute]]? = nil,
		horizontalRelations: [[NSLayoutRelation]]? = nil,
		horizontalPaddings: [[CGFloat]]? = nil,
		gapPadding: CGFloat = 8.0,
		topPadding: CGFloat = 0.0,
		bottomPadding: CGFloat = 0.0,
		bottomRelation: NSLayoutRelation = .Equal
		) {
			var lastView: UIView?
			let hAttributes: [[NSLayoutAttribute]] = self.getHorizontalAttributes(forStackViews: stackedViews, horizontalAttributes: horizontalAttributes)
			let hRelations: [[NSLayoutRelation]] = self.getHorizontalRelations(hAttributes, horizontalRelations: horizontalRelations)
			let hPadding: [[CGFloat]] = self.getHorizontalPadding(hAttributes, horizontalPadding: horizontalPaddings)
			
			for index in 0...(stackedViews.count - 1) {
				if let nLastView = lastView {
					
					stackedViews[index].addCustomConstraints(inView: self, toViews: [nLastView, self, self], selfAttributes: [NSLayoutAttribute.Top] + hAttributes[index], otherViewAttributes: [NSLayoutAttribute.Bottom] + hAttributes[index], relations: [NSLayoutRelation.Equal] + hRelations[index], padding: [gapPadding] + hPadding[index])
					
				} else {
                    stackedViews[index].addCustomConstraints(inView: self, toViews: topLayoutGuide == nil ? nil : [topLayoutGuide!, self, self], selfAttributes: [NSLayoutAttribute.Top] + hAttributes[index], otherViewAttributes: (topLayoutGuide == nil ?  [NSLayoutAttribute.Top] : [NSLayoutAttribute.Bottom]) + hAttributes[index], relations: [NSLayoutRelation.Equal] + hRelations[index], padding: [topPadding] + hPadding[index])
				}
				lastView = stackedViews[index]
			}
			
			if let nLastView = lastView {
				nLastView.addCustomConstraints(inView: self, selfAttributes: [.Bottom], otherViewAttributes: [.Bottom], relations: [bottomRelation], padding: [-bottomPadding])
			}
			
			
	}
	
	
	func getHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]?) -> [[NSLayoutAttribute]]{
		if let hAttributes = horizontalAttributes {
			self.validateHorizontalAttributes(forStackViews: stackViews, horizontalAttributes: hAttributes)
			return hAttributes
		}
		else {
			return  stackViews.map({ (view: UIView) -> [NSLayoutAttribute] in
				return [NSLayoutAttribute.CenterX, NSLayoutAttribute.Width]
			})
		}
	}
	
	func validateHorizontalAttributes(forStackViews stackViews: [UIView], horizontalAttributes: [[NSLayoutAttribute]]) -> Bool {
		let isValid = horizontalAttributes.count == stackViews.count
		if !isValid {
			self.abortWithMessage("The number of views to stack to should equal the number of horizontal attribute sets provided. At the moment you have provided \(stackViews.count) views to stack and \(horizontalAttributes.count) horizontal attribute sets")
		}
		return isValid
	}
	
	func getHorizontalRelations(horizontalAttributes: [[NSLayoutAttribute]], horizontalRelations: [[NSLayoutRelation]]?) -> [[NSLayoutRelation]]{
		if let hRelations = horizontalRelations {
			self.validateHorizontalRelations(horizontalAttributes, horizontalRelations: hRelations)
			return hRelations
		}
		else {
			return  horizontalAttributes.map({ (attributes: [NSLayoutAttribute]) -> [NSLayoutRelation] in
                return attributes.map({ (attribute: NSLayoutAttribute) in
                    return attribute == .CenterX ?  NSLayoutRelation.Equal : NSLayoutRelation.LessThanOrEqual
                })
			})
		}
	}
	
	func validateHorizontalRelations(horizontalAttributes: [[NSLayoutAttribute]], horizontalRelations: [[NSLayoutRelation]]) -> Bool {
		let isValid = horizontalRelations.count == horizontalAttributes.count
		if !isValid {
			self.abortWithMessage("The number of attribute sets used should match the number of NSLayoutRelation sets passed in")
		}
		return isValid
	}
	
	func getHorizontalPadding(horizontalAttributes: [[NSLayoutAttribute]], horizontalPadding: [[CGFloat]]?) -> [[CGFloat]]{
		if let hPadding = horizontalPadding {
			self.validateHorizontalPadding(horizontalAttributes, horizontalPadding: hPadding)
			return hPadding
		}
		else {
			return  horizontalAttributes.map({ (attributes: [NSLayoutAttribute]) -> [CGFloat] in
				return attributes.map({ _ in 0.0})
			})
		}
	}
	
	func validateHorizontalPadding(horizontalAttributes: [[NSLayoutAttribute]], horizontalPadding: [[CGFloat]]) -> Bool {
		let isValid = horizontalPadding.count == horizontalAttributes.count
		if !isValid {
			self.abortWithMessage("The number of attribute sets used should match the number of padding sets passed in")
		}
		return isValid
	}
	
	
	public func addCustomConstraints(
		inView superView: UIView,
		toViews views: [AnyObject]? = nil,
		selfAttributes: [NSLayoutAttribute],
		relations: [NSLayoutRelation]? = nil,
		otherViewAttributes: [NSLayoutAttribute]? = nil,
		multipliers: [CGFloat]? = nil,
		padding: [CGFloat]? = nil,
		priorities: [UILayoutPriority]? = nil
		)
		-> [NSLayoutConstraint]
	{
		let nRelations: [NSLayoutRelation] = self.getConstraintElements(forReferenceElement: selfAttributes, inputElements: relations, abortMessage: "The number of NSLayoutRelations provided must be the same as the number of NSLayoutAttributes for the item being constrained") { () -> [NSLayoutRelation] in
			return selfAttributes.map({_ in return NSLayoutRelation.Equal})
		}
		let otherViews: [AnyObject] = self.getviews(forAttributes: selfAttributes, views: views, superView: superView)
		
		let nOtherViewAttributes: [NSLayoutAttribute] = self.getConstraintElements(forReferenceElement: selfAttributes, inputElements: otherViewAttributes, abortMessage: "The number of NSLayoutAttributes provided for the other views should be the same as for the attributes provided for the view being constrained") { () -> [NSLayoutAttribute] in
			return selfAttributes
		}
		
		let nMultipliers: [CGFloat] = self.getConstraintElements(forReferenceElement: selfAttributes, inputElements: multipliers, abortMessage: "The number of multipliers must mathc the number of attributes provided for the view being constrained") { () -> [CGFloat] in
			return selfAttributes.map({_ in 1.0})
		}
		
		let nPadding: [CGFloat] = self.getConstraintElements(forReferenceElement: selfAttributes, inputElements: padding, abortMessage: "The number of padding values provided should be the same as the ammount of attributes provided for the view being constrained") { () -> [CGFloat] in
			return selfAttributes.map({_ in return CGFloat(0.0)})
		}
		
		let nPriorities: [UILayoutPriority] = self.getConstraintElements(forReferenceElement: selfAttributes, inputElements: priorities, abortMessage: "The number of priorities should be the same as the amoutn of attributes provided for the view being constrained") { () -> [UILayoutPriority] in
			return selfAttributes.map({_ in return UILayoutPriorityRequired})
		}
		
		
		var constraints: [NSLayoutConstraint] = []
		
		for index in 0...(selfAttributes.count - 1) {
			constraints.append(NSLayoutConstraint(item: self, attribute: selfAttributes[index], relatedBy: nRelations[index], toItem: otherViews[index], attribute: nOtherViewAttributes[index], multiplier: nMultipliers[index], constant: nPadding[index], priority: nPriorities[index]))
			
			
		}
		
		superView.addConstraints(constraints)
		self.addedLayoutConstraints += constraints
		return constraints
	}
	
	func getviews(forAttributes attributes: [NSLayoutAttribute], views: [AnyObject]?, superView: UIView) -> [AnyObject]{
		if let nViews = views {
			self.validateViews(forAttributes: attributes, views: nViews)
			return nViews
		}
		else {
			return  attributes.map{_ in superView}
		}
	}
	
	func validateViews(forAttributes attributes: [NSLayoutAttribute], views: [AnyObject]) -> Bool {
		let isValid = attributes.count <= views.count
        
        for view in views {
            if !(view is UIView) && !(view is UILayoutSupport) {
                self.abortWithMessage("The items passed in must be UIViews or UILayoutSupports. The type ")
            }
        }
		if !isValid {
			self.abortWithMessage("The number of views to constrain to should equal the number of attributes provided. At the moment you have provided \(attributes.count) attributes and \(views.count) views")
		}
		return isValid
	}
	
	func getConstraintElements<T, U>(forReferenceElement referenceElements: [T], inputElements: [U]?, abortMessage: String, defaultElementsClosure: (() ->[U]) )-> [U] {
		if let inputEl = inputElements {
			self.validateElementst(referenceElements, inputElements: inputEl, abortMessage: abortMessage)
			return inputEl
		}
		else {
			return defaultElementsClosure()
		}
	}
	
	func validateElementst<T, U>(referenceElements: [T], inputElements: [U], abortMessage: String) -> Bool {
		let isValid: Bool = (referenceElements.count == inputElements.count)
		
		if !isValid {
			self.abortWithMessage(abortMessage)
		}
		return isValid
	}
	
	public func addDimensions(width width: CGFloat? = nil, height: CGFloat? = nil, widthRelation: NSLayoutRelation = .Equal, heightRelation: NSLayoutRelation = .Equal) {
		if let w : CGFloat = width {
			let constraints: [NSLayoutConstraint] = [
				NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: widthRelation, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: w),
			];
			
			self.addConstraints(constraints);
			self.addedDimensionConstraints.appendContentsOf(constraints)
		}
		if let h: CGFloat = height {
			let constraints: [NSLayoutConstraint] = [
				NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: heightRelation, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: h)
			];
			
			self.addConstraints(constraints);
			self.addedDimensionConstraints.appendContentsOf(constraints)
		}
		
	}
    
    public func flushCurrentDimentionConstraints() {
        self.removeConstraints(self.addedDimensionConstraints)
    }
	
	func abortWithMessage(message: String) {
		assertionFailure(message)
	}
    
    //MARK: Helper methods
    
    public func constrainToTopLayoutGuide(
        superView: UIView,
        topLayoutGuide: UILayoutSupport,
        topRelation: NSLayoutRelation = .Equal,
        leadingRelation: NSLayoutRelation = .Equal,
        trailingRelation: NSLayoutRelation = .Equal,
        topPadding: CGFloat = 0.0,
        leadingPadding: CGFloat = 0.0,
        trailingPadding: CGFloat = 0.0
        ) {
        
        self.addCustomConstraints(inView: superView, toViews: [topLayoutGuide, superView, superView], selfAttributes: [.Top, .Leading, .Trailing], relations: [topRelation, leadingRelation, trailingRelation], otherViewAttributes: [.Bottom, .Leading, .Trailing], padding: [topPadding, leadingPadding, trailingPadding])
            
    }
    
    public func fill(
        superView: UIView,
        topLayoutGuide: UILayoutSupport? = nil
        ) {
            self.addCustomConstraints(inView: superView, toViews: topLayoutGuide == nil ? nil : [topLayoutGuide!, superView, superView, superView], selfAttributes: [.Top, .Leading, .Trailing, .Bottom], otherViewAttributes: topLayoutGuide == nil ? nil : [.Bottom, .Leading, .Trailing, .Bottom])
    }
	
	
	//MARK: Animation methods
	
	private struct AssociatedKey {
		static var kAddedLayoutConstraints: String = "kAddedLayoutConstraints"
		static var kAddedDimensionsConstraints: String = "kAddedDimensionConstraints"
		
	}
	
	public var addedLayoutConstraints: [NSLayoutConstraint] {
		get {
			return objc_getAssociatedObject(self, &AssociatedKey.kAddedLayoutConstraints) as? [NSLayoutConstraint] ?? []
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKey.kAddedLayoutConstraints, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	public var addedDimensionConstraints: [NSLayoutConstraint] {
		get {
			return objc_getAssociatedObject(self, &AssociatedKey.kAddedDimensionsConstraints) as? [NSLayoutConstraint] ?? []
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKey.kAddedDimensionsConstraints, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
    public func animateView(timeInterval: NSTimeInterval, delay: NSTimeInterval = 0.0, options: UIViewAnimationOptions = [], damping: CGFloat = 1.0, springVelocity: CGFloat = 1.0, ignoreDimensions: Bool = true, newConstraintsClosure: (() -> ()), completion: (() -> ()) = {}) {
		//This ensures that the constraints are set http://corsarus.com/2015/auto-layout-and-constraints-animation/
		UIView.animateWithDuration(0.0) { () -> Void in
			self.superview?.layoutIfNeeded()
		}
		
		self.superview?.removeConstraints( ignoreDimensions ? self.addedLayoutConstraints: self.addedLayoutConstraints + self.addedDimensionConstraints)
		newConstraintsClosure()
        
        UIView.animateWithDuration(timeInterval, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: springVelocity, options: options, animations: {[weak self] () -> Void in
            self?.superview?.layoutIfNeeded()

            }) { (success: Bool) -> Void in
                completion()

        }
		

		
	}
	
	
	
	
}

public extension UITextField {
	override class func withAutoLayout() -> UITextField {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		return field
	}
}

public extension UIScrollView {
	override class func withAutoLayout() -> UIScrollView {
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
	
	
}

public extension UITableView {
	override class func withAutoLayout() -> UITableView {
		let view = UITableView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
	
	
}

public extension UILabel {
	override class func withAutoLayout() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
	
	public func multiLine() {
		self.numberOfLines = 0
		self.lineBreakMode = NSLineBreakMode.ByWordWrapping
	}
	
	
}

public extension UIControl {
	override class func withAutoLayout() -> UIControl {
		let control = UIControl()
		control.translatesAutoresizingMaskIntoConstraints = false
		return control
	}
	
	
}


public extension UIButton {
	override class func withAutoLayout() -> UIButton {
		let control = UIButton(type: UIButtonType.Custom)
		control.translatesAutoresizingMaskIntoConstraints = false
		return control
	}
}

public extension UIImageView {
    override class func withAutoLayout() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

public extension NSLayoutConstraint {
	convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat, priority: UILayoutPriority) {
		self.init(item: view1, attribute: attr1, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
		self.priority = priority
	}
}



