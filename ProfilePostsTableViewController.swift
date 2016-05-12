//
//  ProfilePostsTableViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfilePostsTableViewController: PFQueryTableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.reloadData()
        
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        //var query = PFQuery()
        let user = PFUser.currentUser()
        
        
        let postsRelation = user!.relationForKey("Posts")
        
        
        postsRelation.query().findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if let error = error
            {
                print("ERROR \(error) LOADING BACKPACK QUERY")
            }
            else
            {
            }
        }
        var query = postsRelation.query()
        return query
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
    {
        var tcell:ProfilePostsTableViewCell? = tableView.dequeueReusableCellWithIdentifier("profilePostsCell", forIndexPath: indexPath) as? ProfilePostsTableViewCell
        
        // set viewPostDetailButton tag to indexPath.row
        //cell?.viewPostDetailButton.tag = indexPath.row
        
        if let cell = tcell
        {
            
            cell.postObject = object as! Post
            
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
                        cell.authorLabel.text = "Author: \(firstName) \(lastName)"
                        
                    }
                    
                    
                }
            }
 
        }
  
        return tcell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "fromProfilePosts"
        {
            print("We get here. Sender is = \(sender)")
            let detailedVC = segue.destinationViewController as! ViewPostDetailViewController
            
            
            if let cell = sender as? ProfilePostsTableViewCell
            {
                print("We get here!")
                if let post = cell.postObject
                {
                    print("detailedVC.postToViewFromBackPack(post) gets called!!")
                    detailedVC.postToViewFromBackPack(post)
                }
            }
        }
    }
}
