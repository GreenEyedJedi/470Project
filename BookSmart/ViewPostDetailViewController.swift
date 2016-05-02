//
//  ViewPostDetailViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class ViewPostDetailViewController: UIViewController
{
    var post : Post?
    var book : Book?
    var user : PFUser?
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var sellerProfilePictureImageView: UIImageView!
    @IBOutlet weak var sellerUsernameLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    @IBOutlet weak var departmentAndCourseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    @IBOutlet weak var bookDescriptionTextView: UITextView!
    
    @IBOutlet weak var bookInformationLabel: UILabel!
    @IBOutlet weak var bookStockImageView: UIImageView!
    
    @IBOutlet weak var bookConditionLabel: UILabel!
    @IBOutlet weak var bookPageNumLabel: UILabel!
    @IBOutlet weak var bookYearLabel: UILabel!
    
    @IBOutlet weak var saveForLaterButton: UIButton!
    @IBOutlet weak var messageSellerButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setPostDetails()
    }
    
    
    
    func postToView(post: Post)
    {
        self.post = post
    }
    
    func setPostDetails()
    {
        dispatch_async(dispatch_get_main_queue())
            {
                if let post = self.post
                {
                    // retrieve bookObject from post
                    if let bookObject = post["BookObject"] as? PFObject
                    {
                        bookObject.fetchIfNeededInBackgroundWithBlock {
                            (bookObject: PFObject?, error: NSError?) -> Void in
                            let bookTitle = bookObject?["Title"] as? String
                            let bookDescrip = bookObject?["Description"] as? String
                            if let firstName = bookObject?["AuthorFirstName"] as? String, lastName = bookObject?["AuthorLastName"] as? String
                            {
                                self.bookAuthorLabel.text = "Author: \(firstName) \(lastName)"
                                
                            }
                            
                            if let bookStockImage = bookObject?["BookStockImage"] as? PFFile
                            {
                                bookStockImage.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                                    var image: UIImage! = UIImage(data: imageData!)!
                                    self.bookStockImageView.image = image
                                })
                            }
                            
                            self.bookTitleLabel.text = bookTitle
                            self.bookDescriptionTextView.text = bookDescrip
                            
                        }
                    }
                    
                    // retrieve userObject from post
                    if let userObject = post["UserObject"] as? PFObject
                    {
                        userObject.fetchIfNeededInBackgroundWithBlock {
                            (bookObject: PFObject?, error: NSError?) -> Void in
                            
                            if let userName = userObject["username"] as? String
                            {
                                self.sellerUsernameLabel.text = "Seller: \(userName)"
                            }
                            
                            if let userProfilePicture = userObject["ProfilePicture"] as? PFFile
                            {
                                userProfilePicture.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                                    var image: UIImage! = UIImage(data: imageData!)!
                                    self.sellerProfilePictureImageView.image = image
                                })
                            }
                            
                        }
                    }
                    
                    // retrieve courseObject from post
                    if let courseObject = post["CourseObject"] as? PFObject{
                        courseObject.fetchIfNeededInBackgroundWithBlock{
                            (courseObject: PFObject?, error: NSError?) -> Void in
                            
                            if let course = courseObject
                            {
                                if let pFName = course["PFName"] as? String, pLNAme = course["PLName"] as? String
                                {
                                    self.professorLabel.text = "Teacher: \(pFName) \(pLNAme)"
                                }
                                
                                if let dept = course["Department"] as? String, courseNo = course["CourseNo"] as? String
                                {
                                    self.departmentAndCourseLabel.text = "\(dept) \(courseNo)"
                                }
                            }
                            
                        }
                    }
                    
                    
                    
                    // set post details
                    self.postTitleLabel.text = post["PostTitle"] as? String
                    
                    if let imageFromParse = post["PostImage"] as? PFFile
                    {
                        imageFromParse.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                            var image: UIImage! = UIImage(data: imageData!)!
                            self.postImageView.image = image
                        })
                    }
                    
                    if let cond = post["Condition"] as? String
                    {
                        self.bookConditionLabel.text = cond
                    }
                    
                    self.priceLabel.text = "$\(post["Price"])"
                    
                    if let description = post["PostDescription"] as? String
                    {
                        self.postDescriptionLabel.text = description
                    }
                    
                    if let cond = post["Condition"] as? String
                    {
                        self.bookConditionLabel.text = "Condition: \(cond)"
                    }
                    
//                    let date = post["createdAt"] as! NSDate
//                    print("THE DATE IS = \(date)")
                    
                    if let datePosted = post.updatedAt
                    {
                        print("DATE POSTED = \(datePosted)")
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MMM d, yyyy"
                        let date = dateFormatter.stringFromDate(datePosted)
                        self.datePostedLabel.text = "Posted on: \(date)"
                    }
                    
                    
                    
                    
                }
                
                
        }
    }
    
}
