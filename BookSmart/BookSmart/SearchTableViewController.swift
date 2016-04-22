//
//  SearchTableViewController.swift
//  BookSmart
//
//  Created by Justin Whitmer on 4/19/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import Foundation

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    // Keep an array of the courses selected by the search
    
    var queriedCourses = [Course]()
    
    var searchResultsToDisplay = [String]()
    
    // Dictonary to ensure that only one instance of a course is being displayed in the search results
    var duplicateCheck = [String: AnyObject]()
     
    @IBOutlet weak var querySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        querySearchBar.delegate = self
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultsToDisplay.count
        
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // searchBar.resignFirstResponder()
        
        print("Searching for \(searchBar.text)")
        
        // Array to parse the query
        var searchQuery = [String]()
        
        if let str = searchBar.text
        {// Check to see if the text was actually searched
            searchQuery = str.componentsSeparatedByString(" ")
        }
        
        // Variables that will hold query conditions depending on what's entered
        
        // Department condition
        var deptPredicate = NSPredicate()
        // Course number condition
        var coursePredicate = NSPredicate()
        let dept = searchQuery[0]
    
        var course: String?
        
        
        if searchQuery.count > 1
        {// Check to see if a course was entered as well
             course = searchQuery[1]
        }
        
        
        
        deptPredicate = NSPredicate(format: "Department == %@", dept)
        // Store different conditions in an array so they can be combined with an AND by NSCompoundPredicate
        var predicate = [deptPredicate]
        
        // If course was included, use that as a query restraint. Otherwise just search for the department
        if course != nil
        {
            coursePredicate = NSPredicate(format: "CourseNo == %@", course!)
            predicate.append(coursePredicate)
        }
        
        let pred = NSCompoundPredicate(andPredicateWithSubpredicates: predicate)
        
        let query = PFQuery(className: "Courses", predicate: pred)
        
        
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            
            
            // Error checking stuff
            if error != nil {
                let myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle:UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
            }
            
            if let objects = results {
                // Empy the results arrays
                self.searchResultsToDisplay.removeAll(keepCapacity: false)
                self.duplicateCheck.removeAll()
                self.queriedCourses.removeAll()
                
                
                for object in objects {
                    // Get the keys under department and course number and put them as one string
                    let dept = object.objectForKey("Department") as! String
                    let course = object.objectForKey("CourseNo") as! String
                    let wholeClass = dept + " " + course
                
                    let firstName =  object.objectForKey("PFName") as! String
                    let lastName = object.objectForKey("PLName") as! String
                    let wholeName = firstName + " " + lastName
                    
                    let classSection = object.objectForKey("SectionNo") as! Int
                    
                    if self.duplicateCheck.indexForKey(wholeClass) == nil
                    {// This course has not been added yet
                        self.duplicateCheck[wholeClass] = object
                        self.searchResultsToDisplay.append(wholeClass)
                        
                    }
                    
                    let newCourse = Course(prof: wholeName, section: classSection, course: wholeClass)
                    self.queriedCourses.append(newCourse)
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    // Refresh the table to reflect the results of the query
                    self.tableView.reloadData()

                    self.querySearchBar.resignFirstResponder()
                    
                    
                }
                
                
                
            }
            
        }
        self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell to print entries from the array containing the query results
        
        cell.textLabel!.text = searchResultsToDisplay[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // Need to determine if the selected course is just taught by one or more teachers and segue 
        // accordingly
        // Get the text of the selected row, filter the course array for multiple instances of the 
        // same class 
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        let course = selectedCell?.textLabel?.text
        
        let allDuplicateCourses = self.queriedCourses.filter() {$0.deptAndCourse == course}
        queriedCourses = allDuplicateCourses
        
        
        if allDuplicateCourses.count == 1
        {// Go directly to books page
            
        }
        
        else
        {// Go to page to select teacher/section number
            self.performSegueWithIdentifier("toProfessor", sender: self)
        }
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toProfessor"
        {
            let newVC = segue.destinationViewController as! ProfessorTableViewController
            newVC.receiveCourses(queriedCourses)
            
        }
    
    }


}
