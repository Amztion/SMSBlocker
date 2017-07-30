//
//  Mock.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/30.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Mock {
    static var data: [[String: Any]] {
        return [
            dict
        ]
    }
    
    static private let dict = [
        "senderMatcher": [
            "type": 0,
            "matcher": "13261663073"
        ],

        "messageMatcher": [
            "type": 1,
            "matcher": "[测试]"
        ]
    ]
}
