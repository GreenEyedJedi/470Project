//
//  ViewPostDetailViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class ViewPostDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    var post : Post?
    var book : Book?
    var seller : PFObject?
    
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
    @IBOutlet weak var messageSellerButton: UIButton!
    @IBOutlet weak var backPackIt: UIButton!
    @IBAction func backPackItButton(sender: AnyObject)
    {
        if let post = self.post
        {
            savePostToBackPack(post)
        }
    }
    
    @IBOutlet weak var removeBackPackButton: UIButton!
    @IBAction func removeBackPackAction(sender: AnyObject)
    {
        if let post = self.post
        {
            removeFromBackPack(post)
        }
    }
    private var viewingFromBackPackFlag : Bool = false

    func removeFromBackPack(post: Post)
    {
        var refreshAlert = UIAlertController(title: "Remove from BackPack?", message: "Are you sure you want to remove this post from your BackPack?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            if let user = PFUser.currentUser()
            {
                var backPackRelation = user.relationForKey("BackPack")
                backPackRelation.removeObject(post)
                
                user.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    
                    if (success) {
                        self.backPackIt.hidden = false
                        self.removeBackPackButton.hidden = true
                        
                        var successAlert = UIAlertController(title: "Removed!", message: "Post has been removed from BackPack", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        successAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(successAlert, animated: true, completion: nil)
                        
                    } else {
                        // There was a problem, check error.description
                        //self.activityIndicator.stopAnimating()
                        var failureAlert = UIAlertController(title: "Error", message: "There was an error removing your post. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(failureAlert, animated: true, completion: nil)
                        
                    }
                }
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func savePostToBackPack(post: Post)
    {
        var refreshAlert = UIAlertController(title: "Add to BackPack?", message: "Are you sure you want to add this post to your BackPack?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
   
            if let user = PFUser.currentUser()
            {
                var backPackRelation = user.relationForKey("BackPack")
                backPackRelation.addObject(post)
                
                user.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    
                    if (success) {
                        var successAlert = UIAlertController(title: "Success!", message: "Post has been added to BackPack", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        successAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(successAlert, animated: true, completion: nil)
                        
                    } else {
                        // There was a problem, check error.description
                        //self.activityIndicator.stopAnimating()
                        var failureAlert = UIAlertController(title: "Error", message: "There was an error saving your post. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(failureAlert, animated: true, completion: nil)
                    
                }
                }

            }

        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.backPackIt.hidden = false
        self.removeBackPackButton.hidden = true
        checkIsInBackPack()
        setPostDetails()
        
        postImageView.userInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("postImageTapped:"))
        postImageView.addGestureRecognizer(tapRecognizer)
        
        bookStockImageView.userInteractionEnabled = true
        
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: Selector("bookImageTapped:"))
        bookStockImageView.addGestureRecognizer(tapRecognizer2)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func postImageTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        var Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC : ImagePopoverViewController = Storyboard.instantiateViewControllerWithIdentifier("imagePopover") as! ImagePopoverViewController
        VC.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 400)
        
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = self.postImageView
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.Left
        
        if let pic = self.postImageView
        {
            VC.useImage(pic)
        }
        
        navController.popoverPresentationController?.sourceView = self.view
        
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    func bookImageTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        var Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC : ImagePopoverViewController = Storyboard.instantiateViewControllerWithIdentifier("imagePopover") as! ImagePopoverViewController
        VC.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 400)
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = UIModalPresentationStyle.Popover
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = self.postImageView
        popOver?.permittedArrowDirections = UIPopoverArrowDirection.Left
        if let pic = self.bookStockImageView
        {
            VC.useImage(pic)
        }
        navController.popoverPresentationController?.sourceView = self.view
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    func checkIsInBackPack()
    {
        if let user = PFUser.currentUser()
        {
            if let user = PFUser.currentUser()
            {
                var flag : Bool = false
                var backPackRelation = user.relationForKey("BackPack")
                backPackRelation.query().findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        if let objects = objects{
                            print("objects in checkIsInBackPack = \(objects)")
                            for object in objects
                            {
                                if let post = self.post
                                {
                                    print("postID = \(post.objectId) object.id = \(object.objectId)")
                                    if object.objectId == post.objectId
                                    {
                                        print("post is in BackPack!")
                                        self.backPackIt.hidden = true
                                        self.removeBackPackButton.hidden = false
                                        break
                                    }
                                    else
                                    {
                                        self.backPackIt.hidden = false
                                        self.removeBackPackButton.hidden = true
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                }
             
                
            }
        }
    }
 
    func postToView(post: Post)
    {
        self.post = post
        self.viewingFromBackPackFlag = false
        checkIsInBackPack()
    }
    
    func postToViewFromBackPack(post: Post)
    {
        self.post = post
        self.viewingFromBackPackFlag = true
        print("postToViewFromBackPack called!")
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
                            if let bookYear = bookObject?["Year"] as? String
                            {
                                self.bookYearLabel.text = "Year: \(bookYear)"
                            }
                            
                            if let pages = bookObject?["Pages"] as? NSNumber
                            {
                                self.bookPageNumLabel.text = "Page count: \(pages)"
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
                            
                            self.seller = userObject
                            
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
                                    self.professorLabel.text = "Dr. \(pFName) \(pLNAme)"
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // update price and condition before segue
        
        if segue.identifier == "messageSeller"
        {
            if let seller = self.seller, user = PFUser.currentUser(), post = self.post {
                let detailedVC = segue.destinationViewController as! SendMessageViewController
                
                detailedVC.getUserAndSellerAndPost(user, seller: seller, post: post)
            }
        }
        if segue.identifier == "viewProfileInfo"
        {
            if let seller = self.seller
            {
                let detailedVC = segue.destinationViewController as! ProfileViewController
                detailedVC.useSeller(seller)
                
            }
        }
    }
    
}
