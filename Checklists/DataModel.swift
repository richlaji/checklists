//
//  DataModel.swift
//  Checklists
//
//  Created by 张泽昕 on 16/2/29.
//  Copyright © 2016年 张泽昕. All rights reserved.
//

import UIKit
import Foundation

class DataModel {
    var checklists = [Checklist]()
    //NSUserDefault
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    //init
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime() 
    }
    
    //storage
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    //save
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(checklists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    //load
    func loadChecklists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                checklists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
                sortChecklists()
            }
        }
    }
    
    //NSUserDefault
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex" : -1, "FirstTime" : true ]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    //
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let checklist = Checklist(name: "List")
            checklists.append(checklist)
            indexOfSelectedChecklist = -1
            userDefaults.setBool(false, forKey: "FirstTime")
            userDefaults.synchronize()
            saveChecklists()
        }
    }
    
    //sort
    func sortChecklists() {
        checklists.sortInPlace({ checklist1, checklist2 in return
                checklist1.name.localizedStandardCompare(checklist2.name) ==
                .OrderedAscending })
    }
}
