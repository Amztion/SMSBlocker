//
//  Keyword.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Keyword {
    var keyword: String
    
    init(string: String) {
        keyword = string
    }
}

extension Keyword: StringMatchable {
    func match(_ pattern: String) -> Bool {
        return pattern.contains(keyword)
    }
}
