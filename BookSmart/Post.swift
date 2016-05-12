//
//  PostDataSource.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Post: PFObject, PFSubclassing
{
    // Variables for pushing to Parse Database. Must be of @NSManaged datatype or Parse will throw an error.
    @NSManaged var postImage : PFFile
    @NSManaged var postTitle: String?
    @NSManaged var postPrice : NSNumber?
    @NSManaged var user : PFUser
    @NSManaged var postCondition : String?
    @NSManaged var postDescrip : String?
    @NSManaged var bookObj: PFObject?
    @NSManaged var courseObj : PFObject?
    @NSManaged var courseID : NSNumber?
    
    // override the class initalize function.
    override class func initialize()
    {
        var onceToken: dispatch_once_t = 0
        // register the class as a subclass to the Post class in Parse
        // do it in the background once
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery?
    {
        let query = PFQuery(className: Post.parseClassName())
        //query.includeKey("user")
        
        query.orderByDescending("createdAt")
        return query
    }
    
    // Mandatory function call for PFSubclassing delegate
    // return all books in a PFQuery
    class func query(seller: PFObject)
    {
        let query = PFQuery(className: Post.parseClassName())
        //query.whereKey("UserObject", containedIn: seller.objectId)
        
        
    }
    
    // init function for creating a post
    init(PostTitle: String?, User : PFUser?, Condition: String?, Book : PFObject?, Course : NSNumber?, Description: String?, Image: UIImageView?, Price: NSNumber?)
    {
        super.init()
        if let picture = Image
        {
            if let jpeg = picture.image
            {
                if let pic = UIImageJPEGRepresentation(jpeg, 1.0), imageView = PFFile(data: pic)
                {
                    self.postImage = imageView
                }
            }
        }
        
        if let title = PostTitle
        {
            self.postTitle = title
        }
        
        if let desc = Description
        {
            self.postDescrip = desc
            
        }
        
        if let p = Price
        {
            self.postPrice = p
        }
        
        if let b = Book
        {
            self.bookObj = b
        }
        
        if let c = Course
        {
            self.courseID = c
        }
        
        if let user = User
        {
            self.user = user
        }
        
        if let cond = Condition
        {
            self.postCondition = cond
        }
    }
    
    // helper function that returns
    class func parseClassName() -> String
    {
        return "Posts"
    }
    
    // set the book functon for a given post
    func setBookObject(book: Book?)
    {
        if let b = book
        {
            self.bookObj = b as PFObject
        }
        
    }
    
    override init() {
        super.init()
    }
    
    // get the Post's title 
    func getPostTitle() -> String?
    {
        if let title = self.postTitle
        {
            return title as? String
        }
        return nil
    }
}