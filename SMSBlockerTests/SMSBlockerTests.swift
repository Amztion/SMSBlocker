//
//  SMSBlockerTests.swift
//  SMSBlockerTests
//
//  Created by Liang Zhao on 2017/6/7.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import XCTest
@testable import SMSBlocker

class SMSBlockerTests: XCTestCase {
    fileprivate let sharedUserDefaults = UserDefaults(suiteName: Domain.group)
    var sharedRule: Rule?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension SMSBlockerTests {
    struct Request {
        var sender: String?
        var message: String?
    }
    
    func testRegexCodableCase() {
        let regexJson = """
        {
            "regularExpression": "[0-9]"
        }
        """.data(using: .utf8)!
        
        let regex = try? JSONDecoder().decode(Regex.self, from: regexJson)
        print(regex)
    }
    
    func testKeywordCodableCase() {
        let keywordJson = """
        {
            "keyword": "测试"
        }
        """.data(using: .utf8)!
        
        let keyword = try? JSONDecoder().decode(Keyword.self, from: keywordJson)
        print(keyword)
    }
    
    func testRuleCodableCase() {
        let ruleJson = """
        {
            "senderMatcher": {
                "type": 0,
                "matcher": "测试"
            },
            "messageMatcher": {
                "type": 1,
                "matcher": "[0-9]"
            }
        }
        """.data(using: .utf8)!
        
        let rule = try? JSONDecoder().decode(Rule.self, from: ruleJson)
        print(rule)
    }
    
    func testDictionaryToRuleCase() {
        let dict = [
            "senderMatcher": [
                "type": 0,
                "matcher": "测试"
            ],
            
            "messageMatcher": [
                "type": 1,
                "matcher": "[0-9]"
            ]
        ]
        
        sharedRule = try! Rule(dictionary: dict)
        
        print(sharedRule)
    }
    
    func testRuleToDictionaryCase() {
        testDictionaryToRuleCase()
        
        let dict = try! sharedRule?.export()
        
        print(dict)
    }
    
    
    func testMatch() {
        sharedUserDefaults?.set(Mock.data, forKey: UserDefaultsKey.blackListRules)
        
        var allow = false
        
        let request = Request(sender: "13261663073", message: "测试")
        
        let inWhiteList = RulesMatcherTester().inWhiteList(sender: request.sender, message: request.message)
        
        if inWhiteList {
            allow = true
        } else {
            let inBlackList = RulesMatcherTester().inBlackList(sender: request.sender, message: request.message)
            
            if inBlackList {
                allow = false
            } else {
                allow = true
            }
        }
        
        print(allow)
    }
}
