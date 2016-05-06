//
//  ProfileViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController
{
    var user : PFObject?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstAndLastNameLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setFields()
    }
    
    func useSeller(seller : PFObject?)
    {
        if let user = seller
        {
            self.user = user
            print(self.user)
        }
    }
    
    func setFields()
    {
        if let user = self.user
        {
            if let username = user["Username"] as? String
            {
                self.usernameLabel.text = username
            }
            
            if let fName = user["FName"] as? String, lName = user["LName"] as? String
            {
                self.firstAndLastNameLabel.text = "Name: \(fName) \(lName)"
            }
            if let createdAt = user.createdAt
            {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MMM d, yyyy"
                let date = dateFormatter.stringFromDate(createdAt)
                self.memberSinceLabel.text = "Member since: \(date)"
            }
            if let profileImage = user["ProfilePicture"] as? PFFile
            {
                profileImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    let image: UIImage! = UIImage(data: imageData!)!
                    self.profilePicImageView.image = image
                })

            }
        }
    }
    
}
