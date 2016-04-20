//
//  FindClassTextbooksTableViewController.swift
//  BookSmart
//
//  Created by Justin Whitmer on 4/17/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FindClassTextbooksTableViewController: PFQueryTableViewController {
    
    // Variable that will hold the department that the user selected.
    // Will be passed along to next VC and be used to display the
    // courses relevant to this key
    var deptToPass: String = ""
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Departments"
        self.textKey = "DeptName"
        
        
        
    }
    
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        // Pull the DeptName field from entries in the Departments table
        var query = PFQuery(className: "Departments")
        query.orderByAscending("DeptName")
        return query
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = objectAtIndexPath(indexPath)
        // Get the name of the department the user selected and then segue to the Courses table
        self.deptToPass = object!.objectForKey("DeptName") as! String
        
        
        self.performSegueWithIdentifier("Courses", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Courses"
        {
            let newVC = segue.destinationViewController as!
            CoursesTableViewController
            // Pass along the relevant department
            newVC.acceptDept(deptToPass)
            
        }
    }
    

    
}
