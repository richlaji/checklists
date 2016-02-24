//
//  ChecklistItem.swift
//  Checklists
//
//  Created by 张泽昕 on 16/2/11.
//  Copyright © 2016年 张泽昕. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject,NSCoding {
    var text = ""
    var checked = false
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        //get the value
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    func toggleChecked() {
        checked = !checked
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
}