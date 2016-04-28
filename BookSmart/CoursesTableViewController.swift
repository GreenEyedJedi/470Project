//
//  CoursesTableViewController.swift
//  BookSmart
//
//  Created by Justin Whitmer on 4/17/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CoursesTableViewController: PFQueryTableViewController {
    
    var department: String = ""
    var dupCheck: [String] = []
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Courses"
        self.textKey = "CourseNo"
        
        
    }
    
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        var query = PFQuery(className: "Courses")
        query.orderByAscending("CourseNo")
        query.whereKey("Department", equalTo: department)
        return query
    }
    
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        
        if let courseNo  = object?["CourseNo"] as? String {
            print("yy")
            cell.textLabel!.text = courseNo
            
        }
        
        return cell
    }
    
    
    func acceptDept(deptName: String)
    {
        department = deptName
        print(department)
    }
    
    
    
    
}
