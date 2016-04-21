//
//  ConversationListViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/16.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {

 
 let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func add(sender: AnyObject) {
        let new = ChatViewController()
        new.targetId = "user1"
        new.conversationType = .ConversationType_PRIVATE
        new.title = "jack"
        self.navigationController?.pushViewController(new, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "最近会话"
       
        self.conversationListTableView.tableFooterView = UIView()
        
        if appDelegate.isLogedIn() {
            let token = NSUserDefaults.standardUserDefaults().stringForKey("TOKEN")
            if token != nil {
            appDelegate.connectToServer(token!, completion: {})
            }
        }
        
        
        self.setDisplayConversationTypes([RCConversationType.ConversationType_APPSERVICE.rawValue,
            RCConversationType.ConversationType_CHATROOM.rawValue,
            RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,RCConversationType.ConversationType_DISCUSSION.rawValue,RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_PRIVATE.rawValue,
            RCConversationType.ConversationType_SYSTEM.rawValue])
        self.setCollectionConversationType([RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_DISCUSSION.rawValue])
        
        
        print("************LISTVC******")
        
        
        
    }
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        let chatVC = ChatViewController(conversationType: model.conversationType, targetId: model.targetId)
        chatVC.title = model.conversationTitle
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        
        //super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
       
        self.showConnectingStatusOnNavigatorBar = true
        self.isShowNetworkIndicatorView = true
        
        if appDelegate.isLogedIn() {
            self.refreshConversationTableViewIfNeeded()
        }

        
       
    }
    

    
    func firstLog() -> Void {
        
        NSUserDefaults.standardUserDefaults().setValue("1", forKey: "ISFIRSTLOG")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
        let token = NSUserDefaults.standardUserDefaults().valueForKey("TOKEN")
                as? String
            if token != nil {
                appDelegate.connectToServer(token!) {
    print("***************FIRSTLOG****************")
                    
                    self.setDisplayConversationTypes([RCConversationType.ConversationType_APPSERVICE.rawValue,
                        RCConversationType.ConversationType_CHATROOM.rawValue,
                        RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,RCConversationType.ConversationType_DISCUSSION.rawValue,RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_PRIVATE.rawValue,
                        RCConversationType.ConversationType_SYSTEM.rawValue])
                    self.setCollectionConversationType([RCConversationType.ConversationType_GROUP.rawValue,RCConversationType.ConversationType_DISCUSSION.rawValue])
                    
                    self.refreshConversationTableViewIfNeeded()
                    
                    
                }
            }
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
