//
//  AppDelegate.swift
//  litleTalk
//
//  Created by Tek on 16/4/15.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

let AUTHORIZED =  "isLogin"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource {

    var window: UIWindow?
    var storyboard:UIStoryboard?
    var tabVC:UITabBarController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //leanCloud authorized
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        RCIM.sharedRCIM().userInfoDataSource  = self
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        tabVC = storyboard!.instantiateViewControllerWithIdentifier("tabVC") as? UITabBarController
        
        window?.rootViewController = tabVC
        RCIM.sharedRCIM().initWithAppKey("y745wfm84xdxv")
     
        if isLogedIn() {
            
            
            AVOSCloud.setApplicationId("EYr5M9SUFcWV1XiCz0eg8eUF-gzGzoHsz", clientKey: "YQhWM27LFxt8jilROwSLYpAC")

        } else {
            
            AVOSCloud.setApplicationId("EYr5M9SUFcWV1XiCz0eg8eUF-gzGzoHsz", clientKey: "YQhWM27LFxt8jilROwSLYpAC")
            showLogInView()
            
            
            

        }
        
        
        
        return true
    }
    
    func showLogInView() -> Void {
        
            let loginView = self.storyboard!.instantiateViewControllerWithIdentifier("loginNaiVC")
        
        dispatch_async(dispatch_get_main_queue()) { 
        
            self.tabVC?.presentViewController(loginView, animated: false, completion: {
                
            })
            
        }
        
        

    }
    
    
    func connectToServer(token:String, completion:()->Void) -> Void {
        let sharedRCIM = RCIM.sharedRCIM()
        
        
        
        sharedRCIM.userInfoDataSource = self
        sharedRCIM.connectWithToken(token, success: { (str:String!) in
            print("连接成功")
            
            completion()
            
          let userID =  NSUserDefaults.standardUserDefaults().valueForKey("USERNAME") as? String
        let currentUser = RCUserInfo(userId: userID, name: userID, portrait: "http://ww2.sinaimg.cn/crop.0.0.1080.1080.1024/d773ebfajw8eum57eobkwj20u00u075w.jpg")
            sharedRCIM.currentUserInfo = currentUser
            
            
            
            }, error: { (error:RCConnectErrorCode) in
                print("连接失败")
                
        }) {
            print("口令不正确")
        }
        

    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        
        //设置最近会话的人的信息
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        userInfo.name = userId
        userInfo.portraitUri = "http://ww2.sinaimg.cn/crop.0.0.1080.1080.1024/d773ebfajw8eum57eobkwj20u00u075w.jpg"
        
        
     return completion(userInfo)
    }
    
    func isLogedIn() -> Bool {
        var logState:Bool
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.valueForKey(AUTHORIZED) == nil {
            userDefault.setValue("0", forKey: AUTHORIZED)
            logState = false
        } else if ((userDefault.valueForKey(AUTHORIZED) as! String) == "0") {
            logState = false
        } else {
            logState = true
        }
        
      return logState
        
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

