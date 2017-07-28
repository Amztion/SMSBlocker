//
//  File.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Rule {
    struct Matcher: StringMatchable {
        enum MatcherType: Int {
            case keyword
            case regex
        }
        
        var type: MatcherType
        var matcher: StringMatchable
        
        init(type: MatcherType, matcher: StringMatchable) {
            self.type = type
            self.matcher = matcher
        }
    
        func match(_ pattern: String) -> Bool {
            return self.matcher.match(pattern)
        }
    }
    
    var senderMatcher: Matcher?
    var messageMatcher: Matcher?
    
    init(sender: Matcher?, message: Matcher?) {
        self.senderMatcher = sender
        self.messageMatcher = message
    }
}
