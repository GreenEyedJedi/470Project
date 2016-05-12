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
    
    var users : [PFObject]!
    var userMatch : PFObject?
    
    @IBOutlet weak var userPostTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deptAndCourseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func preparePostToUserMatches(postToPush : Post?)
    {
        //var userThatMatches : PFObject?
        if let post = postToPush
        {
            if let arrayOfUsers = self.users
            {
                for user in arrayOfUsers
                {
                    print("preparePostToUserMatch = \(user)")
                    let userCourseRelation = user.relationForKey("CourseRelation")
                    userCourseRelation.query().findObjectsInBackgroundWithBlock{
                        (userCourses: [PFObject]?, error: NSError?) -> Void in
                        if let error = error
                        {
                            // There was an error
                            print("Error getting course from post")
                        }
                        else
                        {
                            if let courses = userCourses
                            {
                                for course in courses
                                {
                                    print("course for \(user) = \(course)")
                                    let courseID = course["CourseID"] as? NSNumber
                                    let postCourseID = post.courseID
                                    print("COMPARING courseID = \(courseID) WITH postCourseID = \(postCourseID)" )
                                    if courseID == postCourseID
                                    {
                                        print("FOUND A MATCH")
                                        self.userMatch = user
                                        break
                                    }
                                }
                            }
                        }
                    }

                }
            }

        }
//        print("RETURNING USERTHATMATCHES = \(userThatMatches)")
//        return userThatMatches
    
    }
    
    
    
    func getUsers()
    {
        self.users = [PFObject]()
        if let userQuery = PFUser.query()
        {
            userQuery.whereKey("objectId", notEqualTo: (PFUser.currentUser()!.objectId!))
            userQuery.findObjectsInBackgroundWithBlock{
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) users.")
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                            self.users.append(object)
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
       
    }
    
    @IBAction func uploadPostButton(sender: AnyObject)
    {
        self.preparePostToUserMatches(self.post)
        var refreshAlert = UIAlertController(title: "Upload Confirmation", message: "Are you statisfied with your post?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()
            
            var postToParse = PFObject(className:"Posts")
            var bookToParse = PFObject(className: "Book")
            var matchToParse = PFObject(className: "Matches")
            var userToParse = PFUser.currentUser()
            //var userMatch : PFObject?
            
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
            
            
            bookToParse["Year"] = self.book?.bookYear
            bookToParse["Title"] = self.book?.bookTitle
            bookToParse["ISBN"] = self.book?.bookISBN
            bookToParse["Description"] = self.book?.bookDescription
            bookToParse["Pages"] = self.book?.bookNumOfPages
            bookToParse["AuthorFirstName"] = self.book?.authorFN
            bookToParse["AuthorLastName"] = self.book?.authorLN
            bookToParse["BookStockImage"] = self.book?.stockImage
            
            postToParse["PostDescription"] = self.post?.postDescrip
            postToParse["PostImage"] = self.post?.postImage

            
//            if self.preparePostToUserMatches(self.post) == true
//            {
//                let userMatches = userToParse!.relationForKey("Matches")
//                print("DoWeGetHere???")
//                userMatches.addObject(postToParse)
//            }
            
            if let userThatMatches = self.userMatch
            {
//                let relation = userThatMatches.relationForKey("Matches")
//                print("DoWeGetHere???")
//                relation.addObject(postToParse)
                matchToParse["UserObjectID"] = userThatMatches.objectId

                
                
                PFObject.saveAllInBackground([postToParse, bookToParse, userToParse!, matchToParse], block: {
                    (success: Bool, error: NSError?) -> Void in
                    
                    if (success) {
                        dispatch_async(dispatch_get_main_queue()) {
                            // add post to user's Posts made relation
                            //userToParse = PFUser.currentUser()!
                            let relation = userToParse!.relationForKey("Posts")
                            relation.addObject(postToParse)
                            userToParse!.saveInBackground()
                            
                            matchToParse["PostObject"] = postToParse
                            matchToParse.saveInBackground()
                            
                            //self.pushPostToUserBackPack(postToParse)
                            // go home
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
            }
            else{
            PFObject.saveAllInBackground([postToParse, bookToParse, userToParse!], block: {
                (success: Bool, error: NSError?) -> Void in
                
                if (success) {
                    dispatch_async(dispatch_get_main_queue()) {
                        // add post to user's Posts made relation
                        //userToParse = PFUser.currentUser()!
                        let relation = userToParse!.relationForKey("Posts")
                        relation.addObject(postToParse)
                        userToParse!.saveInBackground()
                        //self.pushPostToUserBackPack(postToParse)
                        // go home
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
        setPostToUpload(self.post)
        self.activityIndicator.hidden = true
        getUsers()
        
        
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
            
            
            self.priceLabel.text = ("$\(p.postPrice!)")
            print("Price should be = \(self.priceLabel.text)")
            
            // retrieve courseObject from post
            print("CourseObject before unwrap = \(p["CourseObject"] as? PFObject)")
            //
            //            if let courseObject = post["CourseObject"] as? PFObject{
            //                print("CourseObject = \(courseObject)")
            //                courseObject.fetchIfNeededInBackgroundWithBlock{
            //                    (courseObject: PFObject?, error: NSError?) -> Void in
            //
            //                    if let course = courseObject
            //                    {
            //                        if let pFName = course["PFName"] as? String, pLNAme = course["PLName"] as? String
            //                        {
            //                            self.professorLabel.text = "Dr. \(pFName) \(pLNAme)"
            //                        }
            //
            //                        if let dept = course["Department"] as? String, courseNo = course["CourseNo"] as? String
            //                        {
            //                            self.deptAndCourseLabel.text = "\(dept) \(courseNo)"
            //                        }
            //                    }
            //
            //                }
            //            }
            var courseQuery = PFQuery(className: "Courses")
            if let courseID = p.courseID
            {
                courseQuery.whereKey("CourseID", equalTo: courseID)
                do
                {
                    let course = try courseQuery.getFirstObject()
                    if let pFName = course["PFName"] as? String, pLNAme = course["PLName"] as? String
                    {
                        self.professorLabel.text = "Dr. \(pFName) \(pLNAme)"
                    }
                    
                    if let dept = course["Department"] as? String, courseNo = course["CourseNo"] as? String
                    {
                        self.deptAndCourseLabel.text = "\(dept) \(courseNo)"
                    }
                }
                catch
                {
                    // error with getting course object
                    
                }
            }
            
            
            self.bookTitleLabel.text = book?.bookTitle
            
            self.bookDescriptionLabel.text = post?.postDescrip
            
        }
        
    }
    
    
}
