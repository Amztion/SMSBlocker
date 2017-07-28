//
//  MessageFilterExtension.swift
//  SMSFilter
//
//  Created by Liang Zhao on 2017/6/7.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import IdentityLookup

final class MessageFilterExtension: ILMessageFilterExtension {}

extension MessageFilterExtension: ILMessageFilterQueryHandling {
    
    func handle(_ queryRequest: ILMessageFilterQueryRequest, context: ILMessageFilterExtensionContext, completion: @escaping (ILMessageFilterQueryResponse) -> Void) {
        
        let offlineAction = self.offlineAction(for: queryRequest)
        
        let response = ILMessageFilterQueryResponse()
        response.action = offlineAction
        
        completion(response)
    }
    
    private func offlineAction(for queryRequest: ILMessageFilterQueryRequest) -> ILMessageFilterAction {
        guard queryRequest.sender != nil || queryRequest.messageBody != nil else {
            return .none
        }
        
        let action: ILMessageFilterAction!
        
        let inWhiteList = RulesMatcher.inWhiteList(sender: queryRequest.sender, message: queryRequest.messageBody)
        
        if inWhiteList {
            action = .allow
        } else {
            let inBlackList = RulesMatcher.inBlackList(sender: queryRequest.sender, message: queryRequest.messageBody)
            
            if inBlackList {
                action = .filter
            } else {
                action = .allow
            }
        }
        
        return action
    }
    
}
