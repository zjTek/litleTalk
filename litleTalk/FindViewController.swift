//
//  FindViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/21.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class FindViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let BOUNDS = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cicleCell")
            cell.textLabel?.text = "添加好友"
            cell.accessoryType  = .DisclosureIndicator
            cell.selectionStyle = .None
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell1")
                cell.textLabel?.text = "摇一摇"
                cell.selectionStyle = .None
                return cell
            } else {
                let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell2")
                cell.textLabel?.text = "漂流瓶"
                cell.selectionStyle = .None
                return cell
            }
        }
      
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(AddFriendViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    
    
    


}
