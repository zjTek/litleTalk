//
//  RegisterTableViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/18.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

import Alamofire

class RegisterTableViewController: UITableViewController {
    @IBOutlet weak var questionTF: UITextField!

    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var regionTF: UITextField!
    @IBOutlet weak var userTF: KaedeTextField!
    @IBOutlet weak var passWordTF: KaedeTextField!
    @IBOutlet weak var emailTF: KaedeTextField!
    
    var possibleInputs : Inputs = []
    var subMitBtn:UIBarButtonItem!
    var userToken :String?
    var userInfo:AVObject!
    var userDefault : NSUserDefaults?
    override func viewDidLoad() {
        super.viewDidLoad()

      userDefault = NSUserDefaults.standardUserDefaults()
        
     subMitBtn  = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Done, target: self, action: #selector(RegisterTableViewController.subMitBtnClick))
        subMitBtn.enabled = false

        self.navigationItem.rightBarButtonItem = subMitBtn
        validateInputs()
        
    
        
    }

    
    func subMitBtnClick() -> Void {
        
        // new register
        
        self.pleaseWait()
        
        //set up oject
        userInfo = AVObject(className:"BGuser")
        // put in data
        
        userInfo["userName"] = userTF.text
        userInfo["passWord"] = passWordTF.text
        userInfo["eamil"]    = emailTF.text
        userInfo["region"]   = regionTF.text
        userInfo["question"] = questionTF.text
        userInfo["answer"]   = answerTF.text
       

        
        let queryName =  AVQuery(className: "BGuser")
        queryName.whereKey("userName", equalTo: self.userTF.text)
        
        let queryEmail = AVQuery(className: "BGuser")
        queryEmail.whereKey("eamil", equalTo:self.emailTF.text)
        
        let query = AVQuery.orQueryWithSubqueries([queryName,queryEmail])
   
        query.getFirstObjectInBackgroundWithBlock { (obj, error) in
            
            self.clearAllNotice()
            if obj != nil {
                
                if (obj.valueForKey("userName") as! String ) == self.userTF.text {
                    self.errorNotice("用户已注册")
                    self.userTF.becomeFirstResponder()
                } else {
                    self.errorNotice("邮箱已注册")
                    self.emailTF.becomeFirstResponder()
                }
                
               
                
            } else {
                
              
                    self.requestToken(self.userTF.text!)
}
    
    }
}
    
    
    
    func requestToken(userID:String) -> Void {
        let dicUser = ["userId":userID,"name":userID,"portraitUrl":""]
        let str = "https://api.cn.rong.io/user/getToken.json"
        let appKey = "y745wfm84xdxv"
        let appSecret = "7IwjQNxDSpvgn"
        
        let nonce = "\(arc4random())"
        let timestamp = "\(NSInteger( NSDate.timeIntervalSinceReferenceDate()))"
       
      let sha1Value = sha1Calcu(appSecret+nonce+timestamp)
        
        let headers = [
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value
        ]
        
        Alamofire.request(.POST, str, parameters: dicUser,  headers: headers)   .responseJSON { (reponse) in
            
           if let dic = reponse.result.value  as? NSDictionary {
           let code = dic.valueForKey("code") as! NSNumber
            if code.stringValue == "200" {
                self.userToken = dic.valueForKey("token") as? String
                self.userInfo["tokenme"] = self.userToken
                
                
                self.userInfo.saveInBackground()
                self.navigationController?.popViewControllerAnimated(true)
                self.successNotice("注册成功!")
                
                
                
                
              }
            }
        
    }
}
    func sha1Calcu(str:String) -> String {
        return str.sha1()
    }
    
    func validateInputs() {
     
        
        let v1 = AJWValidator(type: AJWValidatorType.String)
        
        v1.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名最少3位")
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "用户名最大15位")
        userTF.ajw_attachValidator(v1)
        
        v1.validatorStateChangedHandler = { newState in
            switch newState {
            case .ValidationStateValid:
              self.userTF.placeholder = "用户名"
                self.userTF.placeholderColor = UIColor.lightGrayColor()
              
                self.possibleInputs.unionInPlace(Inputs.user)
            default:
                self.possibleInputs.subtractInPlace(Inputs.user)
                let erroMsg = v1.errorMessages.first as? String
                self.userTF.placeholder = erroMsg
                self.userTF.placeholderColor = UIColor.redColor()
            }
            self.subMitBtn.enabled = self.possibleInputs.isAllDone()
            
        }
        
        let v2 = AJWValidator(type: AJWValidatorType.String)
        v2.addValidationToEnsureMinimumLength(6, invalidMessage: "密码最少为6位")
        
        passWordTF.ajw_attachValidator(v2)
        v2.validatorStateChangedHandler = { newState in
            switch newState {
            case .ValidationStateValid:
                self.passWordTF.placeholderColor = UIColor.lightGrayColor()
                self.passWordTF.placeholder = "密码"
                
                self.possibleInputs.unionInPlace(Inputs.passWord)
            default:
                self.possibleInputs.subtractInPlace(Inputs.passWord)
                let erroMsg = v2.errorMessages.first as? String
                self.passWordTF.placeholderColor = UIColor.redColor()
                self.passWordTF.placeholder = erroMsg
            }
            
            self.subMitBtn.enabled = self.possibleInputs.isAllDone()
        }
        
        let v3 = AJWValidator(type: AJWValidatorType.String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式不正确")
        emailTF.ajw_attachValidator(v3)
        v3.validatorStateChangedHandler = {  newState in
            switch newState {
            case .ValidationStateValid:
                self.possibleInputs.unionInPlace(Inputs.email)
                self.emailTF.placeholder = "邮箱"
                self.emailTF.placeholderColor = UIColor.lightGrayColor()
            default:
                self.possibleInputs.subtractInPlace(Inputs.email)
                let erroMsg = v3.errorMessages.first as? String
                self.emailTF.placeholderColor = UIColor.redColor()
                self.emailTF.placeholder = erroMsg
            }
            
            self.subMitBtn.enabled = self.possibleInputs.isAllDone()
        }
        
        
    }
    
    
    
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
         self.tabBarController?.tabBar.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension String {
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH),repeatedValue:
            0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        
        let hexBytes = digest.map(){String(format:"%02hhx",$0)}
        return hexBytes.joinWithSeparator("")
    }
}
