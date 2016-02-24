//
//  AllListsViewController.swift
//  Checklists
//
//  Created by 张泽昕 on 16/2/23.
//  Copyright © 2016年 张泽昕. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    //var
    var checklists: [Checklist]
    
    //func
    required init?(coder aDecoder: NSCoder) {
        checklists = [Checklist]()
        super.init(coder: aDecoder)
        loadChecklists()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let cell = cellForTableView(tableView)
        cell.textLabel!.text = "List \(indexPath.row)"
        return cell
    }
    
    //perform segue
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowChecklist", sender: nil)
    }
    
    //create the cells
    func cellForTableView(tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
    }

    
}
