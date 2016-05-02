//
//  UploadPostViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/26/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class UploadPostViewController: UIViewController
{
    var post : Post?
    var book : Book?
    
    
    @IBOutlet weak var userPostTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func uploadPostButton(sender: AnyObject)
    {
        var refreshAlert = UIAlertController(title: "Upload Confirmation", message: "Are you statisfied with your post?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            
            var postToParse = PFObject(className:"Posts")
            var bookToParse = PFObject(className: "Book")
           
            var courseQuery = PFQuery(className: "Courses")
            if let courseID = self.post?.courseID
            {
                courseQuery.whereKey("CourseID", equalTo: courseID)
                do
                {
                    let course = try courseQuery.getFirstObject()
                    postToParse["CourseObject"] = course
                }
                catch
                {
                    // error with getting course object
                    
                }
            }
            
            postToParse["UserID"] = PFUser.currentUser()?.objectId
            postToParse["PostTitle"] = self.post?.postTitle
            postToParse["BookTitle"] = self.book?.bookTitle
            postToParse["Condition"] = self.post?.postCondition
            postToParse["Price"] = self.post?.postPrice
            postToParse["BookObject"] = bookToParse
            postToParse["UserObject"] = PFUser.currentUser()
            
            
            
            bookToParse["Title"] = self.book?.bookTitle
            bookToParse["ISBN"] = self.book?.bookISBN
            bookToParse["Description"] = self.book?.bookDescription
            //bookToParse["Pages"] = self.book?.bookNumOfPages
            bookToParse["AuthorFirstName"] = self.book?.authorFN
            bookToParse["AuthorLastName"] = self.book?.authorLN
            bookToParse["BookStockImage"] = self.book?.stockImage
            
            postToParse["PostDescription"] = self.post?.postDescrip
            postToParse["PostImage"] = self.post?.postImage
            
            
            PFObject.saveAllInBackground([postToParse, bookToParse], block: {
                (success: Bool, error: NSError?) -> Void in
                
                if (success) {
                    dispatch_async(dispatch_get_main_queue()) {
                        var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                        var HomeVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("HomeNavVC")
                        self.revealViewController().setFrontViewController(HomeVC, animated: true)
                    }
                    
                } else {
                    // There was a problem, check error.description
                    self.activityIndicator.stopAnimating()
                    var failureAlert = UIAlertController(title: "Error", message: "There was an error with your upload. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(failureAlert, animated: true, completion: nil)
                }
            })
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPostToUpload(post)
        self.activityIndicator.hidden = true
        
    }
    
    func postToUpload(post: Post, book: Book)
    {
        self.post = post
        self.book = book
    }
    
    func setPostToUpload(post: Post?)
    {
        if let p = post
        {
            self.userPostTitleLabel.text = post?.postTitle
            
            var imageFromParse = post?.postImage
            imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                var image: UIImage! = UIImage(data: imageData!)!
                self.postImageView.image = image
            })
            
            self.bookTitleLabel.text = book?.bookTitle
            
            self.bookDescriptionLabel.text = post?.postDescrip
            
        }
        
    }
    
    
}
