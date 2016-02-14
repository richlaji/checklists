//
//  ViewController.swift
//  Checklists
//
//  Created by 张泽昕 on 16/2/9.
//  Copyright © 2016年 张泽昕. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    var rowItem: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        rowItem = [ChecklistItem]()
        
        let r0 = ChecklistItem()
        r0.text = "Walk the dog"
        r0.checked = false
        rowItem.append(r0)
        
        let r1 = ChecklistItem()
        r1.text = "Brush my teeth"
        r1.checked = false
        rowItem.append(r1)
        
        let r2 = ChecklistItem()
        r2.text = "Learn iOS development"
        r2.checked = false
        rowItem.append(r2)

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //numberOfRowsInSection
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowItem.count
    }
    
    //cellForRowAtIndexPath
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
        
        let item = rowItem[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
        configureCheckmarkForCell(cell, withChecklistItem: item)
        return cell
    }
    
    //didSelectRowAtIndexPath
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // change the state
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = rowItem[indexPath.row]
            item.toggleChecked()
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        
        //deselect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    //
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //1
        rowItem.removeAtIndex(indexPath.row)
        //2
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    //prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItem" {
            //
            let navigationController = segue.destinationViewController as! UINavigationController
            //
            let controller = navigationController.topViewController as! AddItemViewController
            //
            controller.delegate = self
        }
    }
    
    
    //delegate
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = rowItem.count
        rowItem.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //configure checkmark for cell with checklist item
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
    
}

