//
//  RulesManageViewModel.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

class RulesManageViewModel: NSObject {
    var numberOfWhiteListRules: Int {
        return RulesManager.shared.whiteList.count
    }
    
    var numberOfBlackListRules: Int {
        return RulesManager.shared.blackList.count
    }
    
    override init() {
        
    }
    
    func whiteListRuleItem(at index: Int) -> RuleTableViewItem? {
        guard index < RulesManager.shared.whiteList.count else {
            return nil
        }
        
        return RuleTableViewItem(rule: RulesManager.shared.whiteList[index])
    }
    
    func whiteListRule(at index: Int) -> Rule? {
        guard index < RulesManager.shared.whiteList.count else {
            return nil
        }
        
        return RulesManager.shared.whiteList[index]
    }
    
    func removeWhiteListRule(at index: Int) -> Rule? {
        if let rule = whiteListRule(at: index) {
            do {
                try RulesManager.shared.remove(rule, from: .whiteList)
            } catch {
                print("Cannot find whiteList rule to remove at index: \(index)")
                return nil
            }
        }
        
        return nil
    }
    
    func blackListRuleItem(at index: Int) -> RuleTableViewItem? {
        guard index < RulesManager.shared.blackList.count else {
            return nil
        }
        
        return RuleTableViewItem(rule: RulesManager.shared.blackList[index])
    }
    
    func blackListRule(at index: Int) -> Rule? {
        guard index < RulesManager.shared.blackList.count else {
            return nil
        }
        
        return RulesManager.shared.blackList[index]
    }
    
    func removeBlackListRule(at index: Int) -> Rule? {
        if let rule = blackListRule(at: index) {
            do {
                try RulesManager.shared.remove(rule, from: .blackList)
            } catch {
                print("Cannot find blackList rule to remove at index: \(index)")
                return nil
            }
        }
        
        return nil
    }
}
