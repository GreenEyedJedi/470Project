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
    @NSManaged var username : String?
    @NSManaged var email : String?
    @NSManaged var firstName : String?
    @NSManaged var lastName : String?
    @NSManaged var password : String?
    @NSManaged var profilePicture : PFFile?
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
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
    
    class func parseClassName() -> String {
        return "User"
    }
    
    
    override init() {
        super.init()
    }
    
}