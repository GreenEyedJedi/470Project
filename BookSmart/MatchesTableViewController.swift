//
//  MatchesTableViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import ParseUI
import Parse

// TableViewController that manages the BackPack's list of posts
class MatchesTableViewController: PFQueryTableViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.reloadData()
        
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    
    func queryMatches() -> [PFObject]
    {
        var matchObjects = [PFObject]()
        let user = PFUser.currentUser()
        let userID = user?.objectId
        
        var matchQuery = PFQuery(className: "Matches")
        print("matchQuery = \(matchQuery)")
        print("userID = \(userID!)")
        matchQuery.whereKey("UserObjectID", equalTo: userID!)
        matchQuery.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error
            {
                print("ERROR \(error) LOADING BACKPACK QUERY")
            }
            else
            {
                print("SUCCESS?!?")
                if let matches = objects
                {
                    for match in matches
                    {
                        
                        matchObjects.append(match)
                        print("appened \(match) to matchObjects")
                    }
                }
            }
        }
        print("returning matchObjects = \(matchObjects)")
        return matchObjects
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toPostDetailFromMatches"
        {
            print("We get from Matches to ViewDetail. Sender is = \(sender)")
            let detailedVC = segue.destinationViewController as! ViewPostDetailViewController
            
            
            if let cell = sender as? MatchesTableViewCell
            {
                print("We get here from Matches!")
                if let post = cell.postObject
                {
                    print("detailedVC.postToViewFromMatches(post) gets called!!")
                    detailedVC.postToViewFromBackPack(post)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let user = PFUser.currentUser()
        let userID = user?.objectId
        
        //
        var getPosts = PFQuery(className: "Posts")
        var getMatches = PFQuery(className: "Matches")
     
        getMatches.whereKey("UserObjectID", equalTo: userID!)
//        getMatches.whereKey("PostObjects", equalTo: PFObject(withoutDataWithClassName: "Posts", objectId: nil))
        //getMatches.whereKey("PostObjects", matchesQuery: getPosts)
        
        return getMatches

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
    {
        var tcell:MatchesTableViewCell? = tableView.dequeueReusableCellWithIdentifier("matchCell", forIndexPath: indexPath) as? MatchesTableViewCell
        
        // set viewPostDetailButton tag to indexPath.row
        //cell?.viewPostDetailButton.tag = indexPath.row
        
        if let cell = tcell
        {

            let postObjectFromMatch = object?["PostObject"] as! PFObject
            print("postObjectFromMatch = \(postObjectFromMatch)")
            cell.postObject = postObjectFromMatch as! Post
            
            print(cell.postObject)
            
            var imageFromParse = cell.postObject.objectForKey("PostImage") as? PFFile
            
            imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                var image: UIImage! = UIImage(data: imageData!)!
                cell.postImageView.image = image
            })
            
            //cell?.postObject = postObject
            cell.bookTitleLabel?.text = cell.postObject["BookTitle"] as? String
            //cell?.bookDescripLabel?.text = postObject["PostDescription"] as? String
            //cell?.userPostTitleLabel?.text = postObject["PostTitle"] as? String
            
            if let price = cell.postObject["Price"] as? NSNumber
            {
                cell.priceLabel?.text = "$\(price)"
            }
            
            // needs to be in a function in Post class
            if let courseObject = cell.postObject["CourseObject"] as? PFObject{
                courseObject.fetchIfNeededInBackgroundWithBlock{
                    (courseObject: PFObject?, error: NSError?) -> Void in
                    
                    if let course = courseObject
                    {
                        if let pFName = course["PFName"] as? String, pLNAme = course["PLName"] as? String
                        {
                            cell.professorLabel.text = "Dr. \(pFName) \(pLNAme)"
                        }
                        
                        if let dept = course["Department"] as? String, courseNo = course["CourseNo"] as? String
                        {
                            cell.deptAndCourseLabel.text = "\(dept) \(courseNo)"
                        }
                    }
                    
                }
            }
            
            // needs to be in Post Object (or in new Book class?)
            if let bookObject = cell.postObject["BookObject"] as? PFObject
            {
                bookObject.fetchIfNeededInBackgroundWithBlock {
                    (bookObject: PFObject?, error: NSError?) -> Void in
                    let bookTitle = bookObject?["Title"] as? String
                    let bookDescrip = bookObject?["Description"] as? String
                    if let firstName = bookObject?["AuthorFirstName"] as? String, lastName = bookObject?["AuthorLastName"] as? String
                    {
                        cell.bookAuthorLabel.text = "Author: \(firstName) \(lastName)"
                        
                    }
                    
                    
                }
            }
            
            
        }
        
        
        
        return tcell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            //                removeObjectAtIndexPath(indexPath)
            //                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade )
            
            if let user = PFUser.currentUser(), object = self.objectAtIndexPath(indexPath)
            {
                
                var postRelation = user.relationForKey("PostObjects")
                postRelation.removeObject(object)
                
                
                user.saveInBackgroundWithBlock{
                    (success: Bool, error: NSError?) -> Void in
                    if (success){
                        self.loadObjects()
                        self.tableView.reloadData()
                    }
                    else
                    {
                        print("Could not delete object = \(object)")
                    }
                    
                }
                
            }
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
}