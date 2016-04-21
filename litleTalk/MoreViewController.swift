//
//  MoreViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/19.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
     let AUTHORIZED =  "isLogin"
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        setView()
       
        
            }
    
    func  setBtn() -> UIButton {
        let logOffBtn = UIButton(type: UIButtonType.Custom)
        logOffBtn.frame = CGRect(x: 0 , y:0, width: self.view.frame.width , height: 30)
        logOffBtn.setTitle("退出登录", forState: UIControlState.Normal)
        logOffBtn.addTarget(self, action: #selector(MoreViewController.logOP), forControlEvents: UIControlEvents.TouchUpInside)
        logOffBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        logOffBtn.backgroundColor = UIColor.redColor()
        
        
        return logOffBtn

    }
    
    func logOP () -> Void {
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
       
        NSUserDefaults.standardUserDefaults().setValue("0", forKey:AUTHORIZED)
        NSUserDefaults.standardUserDefaults().synchronize()
        appdelegate.showLogInView()
        RCIM.sharedRCIM().disconnect()
        
        
    }

    func setView() -> Void {
        let tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
        return 1
        } else if section == 1 {
            return 4
        } else {
            return 1
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 30
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
            
            let userName = NSUserDefaults.standardUserDefaults().stringForKey("USERNAME")
            
            cell.textLabel?.text = "微聊号:" + userName!
            cell.selectionStyle = .None
            cell.imageView?.image = UIImage(named: "xin")
            
            return cell
        }else if indexPath.section == 1 {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "b")
            switch indexPath.row {
                
            case 0:
                cell.textLabel?.text = "相册"
            case 1:
                cell.textLabel?.text = "收藏"
            case 2:
                cell.textLabel?.text = "钱包"
            default:
                cell.textLabel?.text = "优惠券"
            }
          cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .None
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "c")
            cell.contentView.addSubview(setBtn())
         
            return cell
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
