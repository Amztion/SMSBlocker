//
//  RulesManageViewController.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/7/28.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

class RulesManageViewController: UIViewController {

    enum ListType {
        case whiteList
        case blackList
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = RulesManageViewModel()
    private let currentListType = ListType.whiteList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView()
    }

}

extension RulesManageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath) as! RuleTableViewCell
        var item: RuleTableViewItem!
        switch currentListType {
        case .whiteList:
            item = viewModel.whiteListRuleItem(at: indexPath.row)
        case .blackList:
            item = viewModel.blackListRuleItem(at: indexPath.row)
        }
        
        cell.update(with: item)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentListType {
        case .whiteList:
            return viewModel.numberOfWhiteListRules
        case .blackList:
            return viewModel.numberOfBlackListRules
        }
    }
}

extension RulesManageViewController: UITableViewDelegate {
    
}
