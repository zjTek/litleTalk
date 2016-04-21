//
//  SearedFriendDetailViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/21.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class SearedFriendDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArr : Array<String> = []
    
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
     return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        } else {
            return 10
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell1")
            cell.textLabel?.text = dataArr.first
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell2")
            cell.textLabel?.text = "我是一个快乐的人"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let butt = UIButton(type: UIButtonType.Custom)
            butt.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-10, height: 50)
            butt.setTitle("加为好友", forState: UIControlState.Normal)
            butt.backgroundColor = UIColor.greenColor()
            butt.setTitleColor(UIColor.whiteColor()
                , forState: UIControlState.Normal)
            
            butt.addTarget(self, action: #selector(SearedFriendDetailViewController.addBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
            
            return butt
        }
    }

    func addBtnClick() -> Void {
        
        let user = NSUserDefaults.standardUserDefaults().stringForKey("USERNAME")
        
        let query = AVQuery(className: "BGuser")
        query.whereKey("userName", equalTo: user)
        let myObj = query.getFirstObject() as AVObject
         var arrFriends =  myObj.valueForKey("friends") as! Array<String>
        
        arrFriends.append((dataArr.first)!)
        
        myObj["friends"] = arrFriends
        myObj.saveInBackground()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
