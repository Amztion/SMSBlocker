//
//  RulesMatcher.swift
//  SMSFilter
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

class RulesMatcher {
    fileprivate static let sharedUserDefaults = UserDefaults(suiteName: Domain.group)
    
    static var whiteList: [Rule]? {
        return sharedUserDefaults?.array(forKey: UserDefaultsKey.whiteListRules) as? [Rule]
    }
    
    static var blackList: [Rule]? {
        return sharedUserDefaults?.array(forKey: UserDefaultsKey.blackListRules) as? [Rule]
    }
}

extension RulesMatcher {
    static func inWhiteList(sender: String?, message: String?) -> Bool {
        if let `whiteList` = RulesMatcher.whiteList {
            return whiteList.filter({ (rule) -> Bool in
                return true
            }).count > 0
        } else {
            return false
        }
    }
    
    static func inBlackList(sender: String?, message: String?) -> Bool {
        if let `blackList` = RulesMatcher.blackList {
            return blackList.filter({ (rule) -> Bool in
                return true
            }).count > 0
        } else {
            return false
        }
    }
}
