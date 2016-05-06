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

class Post: PFObject, PFSubclassing {
    
    @NSManaged var postImage : PFFile
    @NSManaged var postTitle: String?
    
    @NSManaged var postPrice : NSNumber?
    
    @NSManaged var user : PFUser
    @NSManaged var postCondition : String?
    @NSManaged var postDescrip : String?
    @NSManaged var bookObj: PFObject?
    @NSManaged var courseObj : PFObject?
    @NSManaged var courseID : NSNumber?
    
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Post.parseClassName())
        //query.includeKey("user")
        
        query.orderByDescending("createdAt")
        return query
    }
    
    
    
    
    
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
    
    class func parseClassName() -> String {
        return "Posts"
    }
    
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
    
    func getPostTitle() -> String?
    {
        if let title = self.postTitle
        {
            return title as? String
        }
        return nil
    }
    
//    func getDeptAndCourseString() -> String?
//    {
//        if let courseID = self.courseID
//        {
//            
//        }
//        return nil
//    }

    
    
}