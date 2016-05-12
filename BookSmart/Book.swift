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
    // Variables for pushing to Parse Database. Must be of @NSManaged datatype or Parse will throw an error.
    @NSManaged var bookTitle : String?
    @NSManaged var bookISBN : String?
    @NSManaged var bookNumOfPages : NSNumber?
    @NSManaged var bookDescription : String?
    @NSManaged var authorFN : String?
    @NSManaged var authorLN : String?
    @NSManaged var stockImage : PFFile?
    @NSManaged var bookYear : String?
    
    // override initalize function.
    override class func initialize() {
        // register the class as a subclass to the Book class in Parse
        // do it in the background once
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    // get the Book objects ISBN number. Return a String if ISBN != nil. Else, return nil.
    func getBookISBN() -> String?
    {
        if let isbn = bookISBN
        {
            return isbn
        }
        return nil
    }
    
    // Mandatory function call for PFSubclassing delegate
    // return all books in a PFQuery
    override class func query() -> PFQuery? {
        let query = PFQuery(className: Book.parseClassName()) 
        query.orderByDescending("createdAt")
        return query
    }
    
    // basic initalizer used in creating a book for a given post.
    init(title : String?, isbn : String?, pageNum : NSNumber?, desc : String?, author : String?, image : UIImageView?, year: String?)
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
        
        if let y = year
        {
            self.bookYear = y
        }
    }
    
    // helper function for class func query()
    class func parseClassName() -> String {
        return "Book"
    }
    
    override init() {
        super.init()
    }
    
    
}