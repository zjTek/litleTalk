//
//  AddFriendViewController.swift
//  litleTalk
//
//  Created by Tek on 16/4/21.
//  Copyright © 2016年 Tek. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let BOUNDS = UIScreen.mainScreen().bounds
    var searchData : Array<String>?
    var tableView : UITableView!
    var searchBar : UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.grayColor()
        //self.edgesForExtendedLayout = .None
        searchData = Array()
        setUpSearchBar()
        tableView.tableFooterView = UIView()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()        // Dispose of any resources that can be recreated.
    }
    

    func setUpSearchBar() -> Void {
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 64, width: BOUNDS.width, height: 30))
        searchBar.placeholder = "请输入对方的id"
        searchBar.delegate = self
        tableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(searchBar.frame), BOUNDS.width, BOUNDS.height), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "userNameCell")
        tableView.alpha = 0.0
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchData?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userNameCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = searchData![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = SearedFriendDetailViewController()
        detailVC.dataArr.append(searchData![indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        UIView.animateWithDuration(0.3) { 
            self.tableView.alpha = 1
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        let query = AVQuery(className: "BGuser")
        query.whereKey("userName", containsString: searchBar.text)
                 
        
        query.findObjectsInBackgroundWithBlock { (obj, error) in
            for item in obj {
                let userId = (item as! AVObject)["userName"] as! String
                self.searchData?.append(userId)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
}