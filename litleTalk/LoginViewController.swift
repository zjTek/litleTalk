//
//  LoginViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/18.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userPassWdTF: HoshiTextField!
   
    @IBOutlet weak var userNameTF: HoshiTextField!
    
    @IBAction func logInBtnClicked(sender: AnyObject) {
        
       
        
        if userNameTF.text != nil {
            verfify()
        }
        
        
    }
    let AUTHORIZED =  "isLogin"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    print("logVC***********************")

        
    }

    
    func verfify() -> Void  {
        
        
        AVOSCloud.setApplicationId("EYr5M9SUFcWV1XiCz0eg8eUF-gzGzoHsz", clientKey: "YQhWM27LFxt8jilROwSLYpAC")
        
        
        let query = AVQuery(className: "BGuser")
        query.whereKey("userName", equalTo: userNameTF.text)
        query.getFirstObjectInBackgroundWithBlock { (obj, err) in
            if obj != nil {
            
                  if (obj.valueForKey("passWord") as! String) == self.userPassWdTF.text {
                    let tokens = obj.valueForKey("tokenme") as? String
                    
                    
                    
                    
                      NSUserDefaults.standardUserDefaults().setValue(tokens, forKey: "TOKEN")
                      NSUserDefaults.standardUserDefaults().setValue("1", forKey: self.AUTHORIZED)
                      NSUserDefaults.standardUserDefaults().setValue(self.userNameTF.text, forKey: "USERNAME")
                    NSUserDefaults.standardUserDefaults().setValue("0", forKey: "ISFIRSTLOG")
                      NSUserDefaults.standardUserDefaults().synchronize()
                      self.successNotice("登录成功！")
                    
                    
                    (UIApplication.sharedApplication().delegate as! AppDelegate).connectToServer(tokens!){}
                     self.dismissViewControllerAnimated(true, completion: { 
                        
                        
                     })
                  
                  
                  } else {
                  self.errorNotice("密码错误")
                  }
                
            }else {
                
                self.errorNotice("用户不存在")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = true
        
            }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userNameTF.resignFirstResponder()
        userPassWdTF.resignFirstResponder()
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
