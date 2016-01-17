# AfroLayout

[![CI Status](http://img.shields.io/travis/Wilhelm/AfroLayout.svg?style=flat)](https://travis-ci.org/va3093/AfroLayout)
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

Enter AfroLayout. This library reduces the amount of work you need to do to maintain constraints in code. It also lets you perform animations in your view while still maintaining the powers of the autolayout constraint engine but with the effort of animating frames.

## Requirements

- iOS 7.0
- Xcode 7

##Integration

####CocoaPods (iOS 8+, OS X 10.9+)
You can use [Cocoapods](http://cocoapods.org/) to install `SwiftyJSON`by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'AfroLayout', :git => 'https://github.com/va3093/afrolayout.git'
end
```
Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:


####Manually (iOS 7+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag AfroLayout.swift to the project tree

## Usage

#### Everyday constraints

AfroLayout has [one fundamental method](#the-bedrock-of-autoautolayout) that allows for easy adding of constraints to views. This method has been further abstracted into helper methods that apply default values for commonly used constraints. If any of these methods don't suit your needs you can alway fall back to the [custom constraints method](#the-bedrock-of-autoautolayout).

##### Constrain to top of view
[Todo]

##### Constrain to top left of view
[Todo]

##### Constrain to top right of view
[Todo]

##### Constrain to bottom view
[Todo]

##### Constrain to bottom left view
[Todo]

##### Constrain to bottom right view
[Todo]

##### Constrain after view
[Todo]

##### Constrain before view
[Todo]

##### Add bottom constraint
[Todo]

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
