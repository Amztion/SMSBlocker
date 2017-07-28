//
//  RulesManager.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

final class RulesManager {
    static let shared = RulesManager()
    fileprivate let sharedUserDefaults = UserDefaults(suiteName: Domain.group)
    
    fileprivate init() {
        
    }
}
