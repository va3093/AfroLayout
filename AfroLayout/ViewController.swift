//
//  ViewController.swift
//  AfroLayout
//
//  Created by Wilhelm on 01/15/2016.
//  Copyright (c) 2016 Wilhelm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	lazy private(set) var tableView: UITableView = {
		let tableView = UITableView.withAutoLayout()
		tableView.delegate = self
		tableView.dataSource = self
		
		return tableView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.whiteColor()
		
		self.view.addSubview(self.tableView)
		self.tableView.addCustomConstraints(inView: self.view, selfAttributes: [.Top, .Leading, .Trailing, .Bottom])
	}
	
	//MARK: UITableViewDelegate
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		switch indexPath.row {
		case 0:
			self.navigationController?.pushViewController(VerticalStackingViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 1:
			self.navigationController?.pushViewController(SimpleAnimationViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 2:
			self.navigationController?.pushViewController(TopViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 3:
			self.navigationController?.pushViewController(TopLeftViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 4:
			self.navigationController?.pushViewController(TopRightViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 5:
			self.navigationController?.pushViewController(BottomViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 6:
			self.navigationController?.pushViewController(BottomLeftViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 7:
			self.navigationController?.pushViewController(BottomRightViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 8:
			self.navigationController?.pushViewController(AfterViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 9:
			self.navigationController?.pushViewController(BeforeViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 10:
			self.navigationController?.pushViewController(BelowViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)
		case 11:
			self.navigationController?.pushViewController(OnTopOfViewController(), animated: true)
			tableView.deselectRowAtIndexPath(indexPath, animated: true)

		default:
			break;
		}
	}
	
	//MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 12
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCellWithIdentifier("Identifier") {
			
			return cell
		} else {
			let cell = UITableViewCell()
			switch indexPath.row {
			case 0:
				cell.textLabel?.text = "Vertical Stacking"
			case 1:
				cell.textLabel?.text = "Simple Animation"
			case 2:
				cell.textLabel?.text = "Constrain to Top of view"
			case 3:
				cell.textLabel?.text = "Constrain to Top Left of view"
			case 4:
				cell.textLabel?.text = "Constrain to Top Right of view"
			case 5:
				cell.textLabel?.text = "Constrain to Bottom of view"
			case 6:
				cell.textLabel?.text = "Constrain to Bottom Left of view"
			case 7:
				cell.textLabel?.text = "Constrain to Bottom Right of view"
			case 8:
				cell.textLabel?.text = "Constrain After a view"
			case 9:
				cell.textLabel?.text = "Constrain Before a view"
			case 10:
				cell.textLabel?.text = "Constrain Below a view"
			case 11:
				cell.textLabel?.text = "Constrain On top of a view"
			default:
				break;
			}
			return cell
		}
	}
	
	
}


