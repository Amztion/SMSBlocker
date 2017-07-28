//
//  File.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

struct Domain {
    static let standard = "com.Amztion.SMSBlocker"
    static var group: String {
        return "group" + standard
    }
}

struct UserDefaultsKey {
    static var whiteListRules: String {
        return Domain.group + "whiteListRules"
    }
    static var blackListRules: String {
        return Domain.group + "blackListRules"
    }
}
