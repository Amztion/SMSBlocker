//
//  Regex.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Regex: StringMatchable {
    fileprivate let regularExpression: NSRegularExpression
    
    init(pattern: String) throws {
        self.regularExpression = try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let pattern = try? container.decode(String.self, forKey: .regularExpression)
        
        guard pattern != nil else {
            throw RegexErrorType.patternIsNil
        }
        
        try self.init(pattern: pattern!)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(regularExpression.pattern, forKey: .regularExpression)
    }
    
    func match(_ string: String) -> Bool {
        return self.regularExpression.matches(in: string, options: .anchored, range: NSRange(location: 0, length: string.characters.count)).count > 0
    }
}

// Codable
extension Regex {
    enum CodingKeys: String, CodingKey {
        case regularExpression = "regularExpression"
    }
}

// Error
extension Regex {
    enum RegexErrorType: Error {
        case patternIsNil
        case patternIsInvalid
    }
}

extension Regex: CustomDebugStringConvertible {
    var debugDescription: String {
        return self.regularExpression.pattern
    }
}
