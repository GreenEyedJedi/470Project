//
//  Book.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/27/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class Book: PFObject, PFSubclassing
{
    @NSManaged var bookTitle : String?
    @NSManaged var bookISBN : String?
    @NSManaged var bookNumOfPages : NSNumber?
    @NSManaged var bookDescription : String?
    @NSManaged var authorFN : String?
    @NSManaged var authorLN : String?
    @NSManaged var stockImage : PFFile?
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    func getBookISBN() -> String?
    {
        if let isbn = bookISBN
        {
            return isbn
        }
        return nil
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Book.parseClassName())
        //query.includeKey("user")
        
        query.orderByDescending("createdAt")
        return query
    }
    
    init(title : String?, isbn : String?, pageNum : NSNumber?, desc : String?, author : String?, image : UIImageView?)
    {
        super.init()
        
        if let t = title
        {
            self.bookTitle = t
        }
        
        if let id = isbn
        {
            self.bookISBN = id
        }
        
        if let n = pageNum
        {
            self.bookNumOfPages = n
        }
        
        if let d = desc
        {
            self.bookDescription = d
        }
        
        if let a = author
        {
            let fullName = a
            let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
            // or simply:
            // let fullNameArr = fullName.characters.split{" "}.map(String.init)
            
            self.authorFN = fullNameArr[0] // First
            self.authorLN = fullNameArr[1] // Last
        }
        
        if let img = image
        {
            if let imageView = PFFile(data: UIImageJPEGRepresentation(img.image!, 1.0)!)
            {
                self.stockImage = imageView
            }
        }
        
        
        
    }
    
    class func parseClassName() -> String {
        return "Book"
    }
    
    override init() {
        super.init()
    }
    
    
}