//
//  ChecklistItem.swift
//  Checklists
//
//  Created by 张泽昕 on 16/2/11.
//  Copyright © 2016年 张泽昕. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    func toggleChecked() {
        checked = !checked
    }
}