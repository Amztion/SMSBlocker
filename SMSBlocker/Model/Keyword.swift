//
//  Keyword.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Keyword: StringMatchable {
    var keyword: String
    
    init(pattern: String) throws {
        keyword = pattern
    }
    
    func match(_ string: String) -> Bool {
        return string.contains(keyword)
    }
}
