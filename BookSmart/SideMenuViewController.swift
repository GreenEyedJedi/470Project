//
//  SideMenuViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/30/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class SideMenuViewController: UITableViewController {
    
    var MenuArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MenuArray = ["Home", "Search", "My Classes", "Browse Textbooks", "My BackPack", "Post", "Settings" , "Log out"]
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("slideoutMenuCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = MenuArray[indexPath.row]
        cell.textLabel?.font = UIFont(name:"Avenir", size:20)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected: \(MenuArray[indexPath.row])")
        
        // if user selects Home
        if indexPath.row == 0
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var HomeVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("HomeNavVC")
            self.revealViewController().setFrontViewController(HomeVC, animated: true)
        }
        
        if indexPath.row == 1
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var SearchVC: UIViewController = Storyboard.instantiateViewControllerWithIdentifier("SearchVC")
            self.revealViewController().setFrontViewController(SearchVC, animated: true)
        }
        
        // if user select Browse Textbooks
        if indexPath.row == 3
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var FindBooksVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("FindBooksVC")
            self.revealViewController().setFrontViewController(FindBooksVC, animated: true)
        }
        
        // if user selects My BackPack
        if indexPath.row == 4
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var BackPackNavVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("BackPackNavVC")
            self.revealViewController().setFrontViewController(BackPackNavVC, animated: true)
        }
        
        // if user selects Post
        if indexPath.row == 5
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var PostVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("PostVC")
            self.revealViewController().setFrontViewController(PostVC, animated: true)

        }
        
        // if user selects Settings (user management)
        if indexPath.row == 6
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var UserProfileVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("UserProfileVC")
            self.revealViewController().setFrontViewController(UserProfileVC, animated: true)
        }
        
        // if user selects Log Out
        if indexPath.row == 7
        {
            loggedOutPressed()
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var LogInVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("BeginLoginNav")
            self.presentViewController(LogInVC, animated: true, completion: nil)
        }
        
    }
    
    func loggedOutPressed()
    {
        PFUser.logOut()
        
    }
    
}