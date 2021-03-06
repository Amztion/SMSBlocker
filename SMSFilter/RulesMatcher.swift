//
//  RulesMatcher.swift
//  SMSFilter
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct RulesMatcher {
    fileprivate let sharedUserDefaults = UserDefaults(suiteName: Domain.group)
    
    var whiteList: [Rule]? {
        return try! load(forKey: UserDefaultsKey.whiteListRules)
    }
    
    var blackList: [Rule]? {
        return try! load(forKey: UserDefaultsKey.blackListRules)
    }

}

extension RulesMatcher {
    func inWhiteList(sender: String?, message: String?) -> Bool {
        if let `whiteList` = self.whiteList {
            return whiteList.filter {isMatch(matcher: $0.senderMatcher, string: sender) || isMatch(matcher: $0.messageMatcher, string: message)}.count > 0
        } else {
            return false
        }
    }
    
    func inBlackList(sender: String?, message: String?) -> Bool {
        if let `blackList` = self.blackList {
            return blackList.filter {isMatch(matcher: $0.senderMatcher, string: sender) || isMatch(matcher: $0.messageMatcher, string: message)}.count > 0
        } else {
            return false
        }
    }
    
    func load(forKey key: String) throws -> [Rule]? {
        let rulesDictionaries = sharedUserDefaults?.array(forKey: key) as? [[String: Any]]
        return try rulesDictionaries?.map {try Rule(dictionary: $0)}
    }
    
    func isMatch(matcher: Rule.Matcher?, string: String?) -> Bool {
        guard matcher != nil && string != nil else {
            return false
        }
        
        return matcher!.match(string!)
    }
}
