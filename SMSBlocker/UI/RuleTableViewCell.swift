//
//  RuleTableViewCell.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/8/2.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

struct RuleTableViewItem {
    let title: String
    let isEnabled: Bool
    
    init(rule: Rule) {
        title = rule.title
        isEnabled = rule.enable
    }
}

class RuleTableViewCell: UITableViewCell {

    var item: RuleTableViewItem!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    func update(with item: RuleTableViewItem) {
        self.item = item
        
        self.title.text = item.title
        self.switch.setOn(item.isEnabled, animated: false)
    }
    
    // MARK: Actions
    @IBAction func switchDidChanged(_ sender: UISwitch) {
    }
    

}
