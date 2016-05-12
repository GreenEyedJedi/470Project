//
//  User.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class User : PFObject, PFSubclassing
{
    // Variables for pushing to Parse Database. Must be of @NSManaged datatype or Parse will throw an error.
    @NSManaged var username : String?
    @NSManaged var email : String?
    @NSManaged var firstName : String?
    @NSManaged var lastName : String?
    @NSManaged var password : String?
    @NSManaged var profilePicture : PFFile?
    
    // override class initalize function.
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        // register the class as a subclass to the Post class in Parse
        // do it in the background once
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    // initializer during User Sign Up
    init(userName: String?, emailAddress: String?, pw: String?)
    {
        super.init()
        
        if let un = userName
        {
            self.username = un
        }
        if let email = emailAddress
        {
            self.email = email
        }
        if let passwd = pw
        {
            self.password = passwd
        }
    }
    
    // complete, more detailed initalizer
    init(userName: String?, emailAddress: String?, pw: String?, fName: String?, lName: String?, profilePic: UIImageView?)
    {
        super.init()
        
        if let un = userName
        {
            self.username = un
        }
        if let email = emailAddress
        {
            self.email = email
        }
        if let passwd = pw
        {
            self.password = passwd
        }
        if let first = fName
        {
            self.firstName = first
        }
        if let last = lName
        {
            self.lastName = last
        }
        if let img = profilePic
        {
            if let imageView = PFFile(data: UIImageJPEGRepresentation(img.image!, 1.0)!)
            {
                self.profilePicture = imageView
            }
        }
    }
    
    override class func query() -> PFQuery? {
        let query = PFQuery(className: User.parseClassName())
        //query.includeKey("user")
        
        query.orderByDescending("createdAt")
        return query
    }
    
    // helper function for query() -> PFQuery?
    class func parseClassName() -> String {
        return "User"
    }
    
    
    override init() {
        super.init()
    }
    
}