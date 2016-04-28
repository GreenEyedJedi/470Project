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
     
//    private var postID:Int?
//    private var postTitle:String?
//    private var postPhoto:UIImage?
//    private var postDescription:String?
//    private var postBook:String?
//    private var postPrice:Float?
//    private var postCondition:String?

    @NSManaged var postImage : PFFile
    @NSManaged var postTitle: String?
    @NSManaged var postBook : String?
    @NSManaged var postPrice : String?
   
    @NSManaged var user : PFUser
    
    @NSManaged var postCondition : String?
    @NSManaged var postDescrip : String?
    
    @NSManaged var authorFirst: String?
    @NSManaged var authorLast: String?
    
    @NSManaged var bookID: String?
    @NSManaged var bookTitle: String?
    @NSManaged var bookObj: PFObject?
    
    @NSManaged var department: String?
    @NSManaged var courseNum : String?
    @NSManaged var courseSec: String?
    
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
    
    func getBookID() -> String?
    {
        if let id = bookID
        {
            return id
        }
        return nil
    }
    
//    init(BookID: String?, Condition: String?, PostDescription: String?, PostImage: PFFile?, Price: String?, UserID: String?) {
//        super.init()
//        
//        self.postImage = PostImage!
//        
//        self.postCondition = Condition
//        self.postBook = "Example"
//        self.postPrice = Price
//        self.postDescrip = PostDescription
//        
//        print("Initalization of a Post object from Parse")
//   
//    }

    init(PostTitle: String?, BookTitle: String?, Author: String?, ISBN: String?, Department: String?, CNumber:String?, CSection:String?, Description: String?, Image: UIImageView?, Price: String?)
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
        
        if let bTitle = BookTitle
        {
            self.bookTitle = bTitle
        }
        
        if let a = Author
        {
            let fullName = a
            let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
            // or simply:
            // let fullNameArr = fullName.characters.split{" "}.map(String.init)
            
            self.authorFirst = fullNameArr[0] // First
            self.authorLast = fullNameArr[1] // Last
        }
        
        if let bookid = ISBN
        {
            self.bookID = bookid
        }
        
        if let dept = Department
        {
            self.department = dept
        }
        
        if let cNum = CNumber
        {
            self.courseNum = cNum
        }
        
        if let cSec = CSection
        {
            self.courseSec = cSec
        }
        
        if let desc = Description
        {
            self.postDescrip = desc
            
        }
        
        if let p = Price
        {
            self.postPrice = p
        }
        
        
        
    }
    
    class func parseClassName() -> String {
        return "Posts"
    }
    
    override init() {
        super.init()
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