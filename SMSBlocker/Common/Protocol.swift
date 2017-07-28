//
//  Protocol.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import Foundation

protocol StringMatchable {
    func match(_ pattern: String) -> Bool
}
