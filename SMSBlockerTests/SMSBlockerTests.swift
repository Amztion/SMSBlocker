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
}
