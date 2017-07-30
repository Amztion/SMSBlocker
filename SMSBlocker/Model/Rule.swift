//
//  File.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Rule: Codable {
    var senderMatcher: Matcher?
    var messageMatcher: Matcher?
    
    init(sender: Matcher?, message: Matcher?) throws {
        guard sender != nil || message != nil else {
            throw RuleError.senderMessageAreAllNil
        }
        
        self.senderMatcher = sender
        self.messageMatcher = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let senderMatcher = try? container.decode(Matcher.self, forKey: .senderMatcher)
        let messageMatcher = try? container.decode(Matcher.self, forKey: .messageMatcher)
        
        try self.init(sender: senderMatcher, message: messageMatcher)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(senderMatcher, forKey: .senderMatcher)
        try container.encode(messageMatcher, forKey: .messageMatcher)
    }
}

// MARK: Matcher Sturct
extension Rule {
    struct Matcher: Codable {
        enum MatcherType: Int {
            case keyword
            case regex
        }
        
        enum MatcherError: Error {
            case typeNotValid
            case matcherNotValid
        }
        
        enum CodingKeys: String, CodingKey {
            case type = "type"
            case matcher = "matcher"
        }
        
        var type: MatcherType
        var matcher: StringMatchable
        
        init(type: MatcherType, matcher: StringMatchable) {
            self.type = type
            self.matcher = matcher
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let typeRaw = try? container.decode(Int.self, forKey: .type)
            let pattern = try? container.decode(String.self, forKey: .matcher)
            
            guard typeRaw != nil else {
                throw MatcherError.typeNotValid
            }
            
            guard pattern != nil else {
                throw MatcherError.matcherNotValid
            }
            
            if let `typeRaw` =  typeRaw, let `pattern` = pattern {
                if let type = MatcherType(rawValue: typeRaw) {
                    var matcherStruct: StringMatchable.Type?
                    switch type {
                    case .keyword:
                        matcherStruct = Keyword.self
                    case .regex:
                        matcherStruct = Regex.self
                    }
                    
                    if let matcher = try matcherStruct.self?.init(pattern: pattern) {
                        self.init(type: type, matcher: matcher)
                    } else {
                        throw MatcherError.matcherNotValid
                    }
                } else {
                    throw MatcherError.typeNotValid
                }
            } else {
                throw MatcherError.matcherNotValid
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(type.rawValue, forKey: .type)
            
            switch type {
            case .keyword:
                try container.encode((matcher as! Keyword), forKey: .matcher)
            case .regex:
                try container.encode(matcher as! Regex, forKey: .matcher)
            }
        }
        
        func match(_ string: String) -> Bool {
            return matcher.match(string)
        }
    }
}

// MARK: Codable
extension Rule {
    enum CodingKeys: String, CodingKey {
        case senderMatcher = "senderMatcher"
        case messageMatcher = "messageMatcher"
    }
}

// MARK: Error
extension Rule {
    enum RuleError: Error {
        case senderMatcherIsNil
        case messageMatcherIsNil
        case senderMessageAreAllNil
    }
}

extension Rule {
    init(dictionary: [String: Any]) throws {
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let rule = try JSONDecoder().decode(Rule.self, from: data)
        
        try self.init(sender: rule.senderMatcher, message: rule.messageMatcher)
    }
    
    func export() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        
        return dictionary!
    }
}
