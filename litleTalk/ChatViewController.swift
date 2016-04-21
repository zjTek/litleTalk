//
//  ChatViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/16.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class ChatViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
      

        //        self.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
//        //self. = RCIM.sharedRCIM().currentUserInfo.name
//        self.targetId = RCIM.sharedRCIM().currentUserInfo.userId
//        self.conversationType = .ConversationType_PRIVATE
//        self.title = RCIM.sharedRCIM().currentUserInfo.name
//        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
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
