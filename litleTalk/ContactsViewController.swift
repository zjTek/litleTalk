//
//  ContactsViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/21.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArr :Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    let tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        getData()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.tableFooterView = UIView()
        
        
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let name = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text
        
        let chatVC = ChatViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId: name)
        chatVC.title = name
        
        self.navigationController?.pushViewController(chatVC, animated: true)
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArr![indexPath.row]
        cell.selectionStyle = .None
        cell.accessoryView =  acceptBtnView()
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func acceptBtnView() -> UIButton {
        let acceptBtn = UIButton(type: UIButtonType.Custom)
        acceptBtn.setTitle("接受", forState: UIControlState.Normal)
        acceptBtn.titleLabel?.font = UIFont.systemFontOfSize(10)
        acceptBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        acceptBtn.backgroundColor = UIColor.greenColor()
        acceptBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        return acceptBtn

    }
    
    
    func getData() -> Void {
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("USERNAME")
        if userId != nil {
            
            
         let query = AVQuery(className: "BGuser")
        query.whereKey("userName", equalTo: userId)
        let obj =  query.getFirstObject() as AVObject
            
            if obj["friends"] != nil {
          dataArr = obj["friends"] as? Array
            }
        
            
            
            
            
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
