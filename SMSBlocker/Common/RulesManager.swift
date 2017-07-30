//
//  RulesManager.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

final class RulesManager {
    static let shared = RulesManager()
    fileprivate let sharedUserDefaults = UserDefaults(suiteName: Domain.group)
    
    var whiteList: [Rule]
    var blackList: [Rule]
    
    fileprivate init() {
        whiteList = [Rule]()
        blackList = [Rule]()
        
        loadRules()
    }
}

fileprivate extension RulesManager {
    func loadRules() {
        self.whiteList = try! self.load(forKey: UserDefaultsKey.whiteListRules) ?? [Rule]()
        self.blackList = try! self.load(forKey: UserDefaultsKey.blackListRules) ?? [Rule]()
    }
    
    func load(forKey key: String) throws -> [Rule]? {
        let rulesDictionaries = sharedUserDefaults?.array(forKey: key) as? [[String: Any]]
        return try rulesDictionaries?.map({ (ruleDictionary) -> Rule in
            return try Rule(dictionary: ruleDictionary)
        })
    }
    
    func save(_ list: [Rule], forKey key: String) throws {
        let rulesDictionaries = try list.map { (rule) -> [String: Any] in
            return try rule.export()
        }
        
        sharedUserDefaults?.set(rulesDictionaries, forKey: key)
        sharedUserDefaults?.synchronize()
    }
}
