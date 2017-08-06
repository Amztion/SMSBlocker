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

extension RulesManager {
    enum RuleType {
        case whiteList
        case blackList
    }
    
    enum RuleManagerError: Error {
        
    }
}

extension RulesManager {
    func add(_ rule: Rule, to type: RuleType) throws {
        switch type {
        case .whiteList:
            whiteList.insert(rule, at: 0)
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        case .blackList:
            blackList.insert(rule, at: 0)
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        }
    }
    
    func remove(_ rule: Rule, from type: RuleType) throws {
        switch type {
        case .whiteList:
            whiteList = whiteList.filter {!($0 == rule)}
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        case .blackList:
            blackList = blackList.filter {!($0 == rule)}
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        }
    }
    
    func modify(_ rule: Rule, by modifiedRule: Rule, in type: RuleType) throws {
        try remove(rule, from: type)
        try add(rule, to: type)
        
        switch type {
        case .whiteList:
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        case .blackList:
            try save(whiteList, forKey: UserDefaultsKey.whiteListRules)
        }
    }
}

fileprivate extension RulesManager {
    func loadRules() {
        whiteList = try! load(forKey: UserDefaultsKey.whiteListRules) ?? [Rule]()
        blackList = try! load(forKey: UserDefaultsKey.blackListRules) ?? [Rule]()
        
        print("Loaded Data, number of white list: \(whiteList.count), number of black list: \(blackList.count)")
    }
    
    func load(forKey key: String) throws -> [Rule]? {
        let rulesDictionaries = sharedUserDefaults?.array(forKey: key) as? [[String: Any]]
        return try rulesDictionaries?.map {try Rule(dictionary: $0)}
    }
    
    func save(_ list: [Rule], forKey key: String) throws {
        let rulesDictionaries = try list.map {try $0.export()}
        
        sharedUserDefaults?.set(rulesDictionaries, forKey: key)
        sharedUserDefaults?.synchronize()
    }
}
