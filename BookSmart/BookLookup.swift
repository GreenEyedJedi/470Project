//
//  BookLookup.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/28/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

// Designed to save JSON data from Google Books API ISBN lookup URL.
class BookLookup : NSObject
{
    let book : AnyObject
    
    init(book : AnyObject)
    {
        self.book = book
        super.init()
    }
    
    func bookTitle() -> String?
    {
        if let b = book["title"]
        {
            return b as? String
        }
        return nil
    }
    
    func bookAuthors() -> [String]?
    {
        if let a = book["authors"]
        {
            return a as? [String]
        }
        return nil
    }
    
    func bookDescription() -> String?
    {
        if let d = book["description"]
        {
            return d as? String
        }
        return nil
    }
    
    func bookPages() -> Int?
    {
        if let p = book["pageCount"]
        {
            return p as? Int
        }
        return nil
        
    }
    
    func bookYearPublished() -> String?
    {
        if let year = book["publishedDate"]
        {
            return year as? String
        }
        return nil
    }
    
    func bookStockImageURL() -> UIImage? {
        if let image = book["imageLinks"]
        {
            if let uriString = image!["thumbnail"], let uri = uriString as? String {
                print("URL FOR IMAGE = \(uri)")
                if let url = NSURL(string: uri),
                    data = NSData(contentsOfURL: url),
                    image = UIImage(data: data) {
                        return image
                }
            }
        }
        return nil
    }
}