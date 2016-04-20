//
//  SideMenuViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/30/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SideMenuViewController: UITableViewController {
    
    var MenuArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MenuArray = ["Search", "Find Class Textbooks", "Settings" , "Log out"]
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("slideoutMenuCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = MenuArray[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        NSLog("You selected: \(MenuArray[indexPath.row])!")
        
        
        if indexPath.row == 0
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var SearchVC: UIViewController = Storyboard.instantiateViewControllerWithIdentifier("SearchVC")
            self.presentViewController(SearchVC, animated: true, completion: nil)
        }
        
        if indexPath.row == 1
        {
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var FindBooksVC = Storyboard.instantiateViewControllerWithIdentifier("FindBooksVC")
            self.presentViewController(FindBooksVC, animated: true, completion: nil)
        }
        
        if indexPath.row == 3
        {
            loggedOutPressed()
            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
            var LogInVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("LogInViewController")
            self.presentViewController(LogInVC, animated: true, completion: nil)
        }
        
    }
    
    func loggedOutPressed()
    {
        PFUser.logOut()
        
    }
    
}