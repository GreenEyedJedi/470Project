//
//  PostBrowseTableViewController.swift
//  BookSmart
//
//  Created by Justin Whitmer on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class PostBrowseTableViewController: PFQueryTableViewController {

    var bookTitle: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Posts"
        self.textKey = "BookTitle"
        
        self.paginationEnabled = true
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        var query = PFQuery(className: "Posts")
        query.whereKey("BookTitle", equalTo: bookTitle)
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
    {
        let tcell:BackPackTableViewCell? = tableView.dequeueReusableCellWithIdentifier("browsePostCell", forIndexPath: indexPath) as? BackPackTableViewCell
        
        
        
        if let cell = tcell
        {
            print("Cell stuff")
            cell.postObject = object as! Post
            
            
            
            var imageFromParse = cell.postObject.objectForKey("PostImage") as? PFFile
            
            imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                
                
                let image: UIImage = UIImage(data: imageData!)!
                
                print(image)
                
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
    
    func acceptBookTitle (title: String)
    {
        self.bookTitle = title
        print(bookTitle)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "browseViewPost"
        {
            
            let detailedVC = segue.destinationViewController as! ViewPostDetailViewController
            
            
            if let cell = sender as? BackPackTableViewCell
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
