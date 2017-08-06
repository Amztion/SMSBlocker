//
//  RuleDetailTableViewController.swift
//  SMSBlocker
//
//  Created by Liang Zhao on 2017/8/6.
//  Copyright © 2017年 Liang Zhao. All rights reserved.
//

import UIKit

class RuleDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dissmissDetail(_ sender: UIStoryboardSegue) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveDetail(_ sender: UIStoryboardSegue) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
