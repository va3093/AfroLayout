# AfroLayout

[![Build Status](https://travis-ci.org/va3093/AfroLayout.svg?branch=master)](https://travis-ci.org/va3093/AfroLayout)
[![Version](https://img.shields.io/cocoapods/v/AfroLayout.svg?style=flat)](http://cocoapods.org/pods/AfroLayout)
[![License](https://img.shields.io/cocoapods/l/AfroLayout.svg?style=flat)](http://cocoapods.org/pods/AfroLayout)
[![Platform](https://img.shields.io/cocoapods/p/AfroLayout.svg?style=flat)](http://cocoapods.org/pods/AfroLayout)

##Why AfroLayout was built

AfroLayout is a swift library that puts the auto back into AutoLayout.

1. [How it began](#how-it-began)
1. [Requirements](#requirements)
1. [Integration](#integration)
1. [Usage](#usage)
	- [Everyday Constraints](#everyday-constraints)
	- [The bedrock of AfroLayout](#the-bedrock-of-AfroLayout)
	- [UILayoutSupport support](#uilayoutsupport-support)
	- [Caveats](#caveats)

##How it began

For simple projects with simple UI and UX, storyboards are perfect. They can be thrown together quickly and allow for quick feedback to design changes. It also allows you to make customisations to elements on the storyboards with the use of `IBOutlets` and `IBActions`. However as a project grows and the UI becomes more complex your storyboards can introduce bad practices like showing and hiding elements based on some state. They can also become misleading because a glance at a storyboard doesn't illustrate the different states a view can have and as a result give emphasis to one particular state and makes the others difficult to change. 

So if you go full circle and move your view layout code into your source files you end up with methods like this (and much worse in some cases :grimacing:)
![Screenshot of update constraints method](ReadmeAssets/constraints.png?raw=true)

The final nail in the coffin is if you require animation. To do animations require keeping reference to the appropriate constraints and doing the UIView.animationwithduration dance remembering all the [caveats](http://stackoverflow.com/questions/18363399/autolayout-animation-issue). The advantages of using Autolayout all of sudden start to feel not worth the hassle.

Enter AfroLayout. This library reduces the amount of work you need to do to maintain constraints in code. It also lets you animate your views with the power of the AutoLayout engine and the effort of frame animations 

## Requirements

- iOS 7.0
- Xcode 7

##Integration

####CocoaPods (iOS 8+, OS X 10.9+)
You can use [CocoaPods](http://cocoapods.org/) to install `AfroLayout`by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'AfroLayout', :git => 'https://github.com/va3093/AfroLayout.git'
end
```
Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:

####Carthage (iOS 8+, OS X 10.9+)
You can use [Carthage](https://github.com/Carthage/Carthage) to install `AfroLayout` by adding it to your `Cartfile`:
```
github "va3093/afrolayout"
```

####Manually (iOS 7+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag AfroLayout.swift to the project tree

## Usage

#### Everyday constraints

AfroLayout has [one fundamental method](#the-bedrock-of-afroLayout) that allows for easy adding of constraints to views. This method has been further abstracted into helper methods that apply default values for commonly used constraints. If any of these methods don't suit your needs you can alway fall back to the [custom constraints method](#the-bedrock-of-afroLayout).

In all the methods below notice the support for UILayoutSupport

##### Constrain to top of view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/top.png)

```swift
	self.wrapperView.constrainToTopOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
	view1.constrainToTopOfView(self.wrapperView)
```

##### Constrain to top left of view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/topLeft.png)

```swift
	self.wrapperView.constrainToTopLeftOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
	view1.constrainToTopLeftOfView(self.wrapperView)
```

##### Constrain to top right of view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/topRight.png)

```swift
	self.wrapperView.constrainToTopRightOfView(viewController.view, topLayoutGuide: viewController.topLayoutGuide)
	view1.constrainToTopRightOfView(self.wrapperView)
```

##### Constrain to bottom view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/bottom.png)

```swift
	self.wrapperView.constrainToBottomOfView(viewController.view, bottomLayoutGuide: viewController.bottomLayoutGuide)
	view1.constrainToBottomOfView(self.wrapperView)
```

##### Constrain to bottom left view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/bottomLeft.png)

```swift
	self.wrapperView.constrainToBottomLeftOfView(viewController.view, bottomLayoutGuide: viewController.bottomLayoutGuide)
	view1.constrainToBottomLeftOfView(self.wrapperView)
```

##### Constrain to bottom right view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/bottomRight.png)

```swift
	self.wrapperView.constrainToBottomRightOfView(viewController.view, bottomLayoutGuide: viewController.bottomLayoutGuide)
	view1.constrainToBottomRightOfView(self.wrapperView)
```

##### Constrain after view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/after.png)

```swift
	view1.constrainAfterView(self.wrapperView, inView: self.view)
	view2.constrainAfterView(self.wrapperView, inView: self.view, allign: .CenterY, horizontalPadding: 32)
	view3.constrainAfterView(self.wrapperView, inView: self.view, allign: .Bottom)
```

##### Constrain before view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/before.png)

```swift
	view1.constrainBeforeView(self.wrapperView, inView: self.view)
	view2.constrainBeforeView(self.wrapperView, inView: self.view, allign: .CenterY, horizontalPadding: -32)
	view3.constrainBeforeView(self.wrapperView, inView: self.view, allign: .Bottom)
```

##### Constrain below view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/below.png)

```swift
	view1.constrainBelowView(self.wrapperView, inView: self.view)
	view2.constrainBelowView(self.wrapperView, inView: self.view, allign: .CenterX, verticalPadding: 32)
	view3.constrainBelowView(self.wrapperView, inView: self.view, allign: .Trailing)
```

##### Constrain On top of view

See [screenshot](https://github.com/va3093/AfroLayout/blob/master/ReadmeAssets/onTop.png)

```swift
	view1.constrainOnTopOfView(self.wrapperView, inView: self.view)
	view2.constrainOnTopOfView(self.wrapperView, inView: self.view, allign: .CenterX, verticalPadding: -32)
	view3.constrainOnTopOfView(self.wrapperView, inView: self.view, allign: .Trailing)
```

##### Add bottom constraint

This is most used when you are laying out views in a scrollView and you just want to quickly add the bottom constraint to the scrollview so that the scrollview knows how to size its content view.

```swift
	view1.addBottomConstraint(self.scrollView)
```

#### The bedrock of AfroLayout

Almost all of AfroLayout is built around the following method:

```swift
	public func addCustomConstraints(
		inView superView: UIView,
		toViews views: [UIView]? = nil,
		selfAttributes: [NSLayoutAttribute],
		relations: [NSLayoutRelation]? = nil,
		otherViewAttributes: [NSLayoutAttribute]? = nil,
		multipliers: [CGFloat]? = nil,
		padding: [CGFloat]? = nil,
		priorities: [UILayoutPriority]? = nil)
         	-> [NSLayoutConstraint] {
			//... 
		}
```
This method allows you to turn this:
```swift
	self.wrapperView.addConstraints([
			NSLayoutConstraint(
			item: view1, 
			attribute: NSLayoutAttribute.Top, 
			relatedBy: NSLayoutRelation.Equal, 
			toItem: self.wrapperView, 
			attribute: NSLayoutAttribute.Top, 
			multiplier: 1.0, 
			constant: 0.0),
			
			NSLayoutConstraint(
			item: view1, 
			attribute: NSLayoutAttribute.Leading, 
			relatedBy: NSLayoutRelation.Equal, 
			toItem: self.wrapperView, 
			attribute: NSLayoutAttribute.Leading, 
			multiplier: 1.0, 
			constant: 0.0),
			
			NSLayoutConstraint(
			item: view1, 
			attribute: NSLayoutAttribute.Trailing, 
			relatedBy: NSLayoutRelation.Equal, 
			toItem: self.wrapperView, 
			attribute: NSLayoutAttribute.Trailing, 
			multiplier: 1.0, 
			constant: 0.0),
			
			NSLayoutConstraint(item: view1, 
			attribute: NSLayoutAttribute.Bottom, 
			relatedBy: NSLayoutRelation.Equal, 
			toItem: self.wrapperView, 
			attribute: NSLayoutAttribute.Bottom, 
			multiplier: 1.0, 
			constant: 0.0)
			])
```

Into this:
```swift
        view1.addCustomConstraints(inView: self.wrapperView1, selfAttributes: [.Top, .Leading, .Trailing, .Bottom])
```
This is possible because appropriate defaults are applied to fill values that are predominantly the same. For example The multiplier in the NSLayoutConstraint is usually `1.0`. You usually constrain the top of a view to a top of another view and you usually constrain something to its superview. However, there are many ways that to add constraints and this method gives you the utility to be as specific as you want while still being able to make sense of your constraints by looking at one method. For example,

```swift
	self.wrapperView3.addCustomConstraints(inView: self.view,
			toViews: [self.wrapperView2, self.wrapperView1, self.wrapperView2],
			selfAttributes: [.Top, .Leading, .Trailing],
			otherViewAttributes: [.Bottom, .Leading, .Trailing],
			relations: [.GreaterThanOrEqual, .Equal, .LessThanOrEqual],
			padding: [8.0, 0.0, 0.0],
			priorities: [750.0, 800.0, 500.0])
```

#### UILayoutSupport support

#### Caveats

## Author

Wilhelm, va3093@gmail.com

## License

AfroLayout is available under the MIT license. See the LICENSE file for more info.
