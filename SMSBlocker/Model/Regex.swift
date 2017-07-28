//
//  Regex.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Regex {
    fileprivate let regularExpression: NSRegularExpression
    
    init?(pattern: String) {
        if let `regularExpression` = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) {
            self.regularExpression = regularExpression
        } else {
            return nil
        }
    }
}

extension Regex: StringMatchable {
    func match(_ pattern: String) -> Bool {
        return self.regularExpression.matches(in: pattern, options: .anchored, range: NSRange(location: 0, length: pattern.characters.count)).count > 0
    }
}

extension Regex: CustomDebugStringConvertible {
    var debugDescription: String {
        return self.regularExpression.pattern
    }
}
