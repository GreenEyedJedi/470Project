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
        
        if let img = Image
        {
            if let imageView = PFFile(data: UIImageJPEGRepresentation(img.image!, 1.0)!)
            {
                self.postImage = imageView
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
    
    
//    init(id: Int, title : String, photo : UIImage, desc : String, book : String, price : Float, condition : String) {
//        //posts = dataSource
//        postID = id
//        postTitle = title
//        postPhoto = photo
//        postDescription = desc
//        postBook = book
//        postPrice = price
//        postCondition = condition
//        super.init()
//    }
//    
//    func getPostID() -> Int?
//    {
//        let id = postID ?? nil
//        return id
//    }
//    
//    func getPhoto () -> UIImage?
//    {
//        let photo = postPhoto ?? nil
//        return photo
//    }
//    
//    func getTitle() -> String?
//    {
//        let title = postTitle ?? nil
//        return title
//    }
//    
//    func getDescription() -> String?
//    {
//        let description = postDescription ?? nil
//        return description
//    }
//    
//    func getBookName() -> String?
//    {
//        let book = postBook ?? nil
//        return book
//    }
//    
//    func getPrice() -> Float?
//    {
//        let price = postPrice ?? nil
//        return price
//    }
//    
//    func getCondition() -> String?
//    {
//        let condition = postCondition ?? nil
//        return condition
//    }
    
    
}