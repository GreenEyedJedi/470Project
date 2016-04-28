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
    
    @IBOutlet weak var userPostTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    @IBAction func uploadPostButton(sender: AnyObject)
    {
        var refreshAlert = UIAlertController(title: "Upload Confirmation", message: "Are you statisfied with your post?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            var postToParse = PFObject(className:"Posts")
            postToParse["UserID"] = PFUser.currentUser()?.objectId
            postToParse["PostTitle"] = self.post?.postTitle
            postToParse["BookTitle"] = self.post?.bookTitle
            postToParse["AuthorFN"] = self.post?.authorFirst
            postToParse["AuthorLN"] = self.post?.authorLast
            postToParse["BookID"] = self.post?.bookID
            postToParse["PostDescription"] = self.post?.postDescrip
            postToParse["PostImage"] = self.post?.postImage
            //postToParse["Condition"] = self.post?.postCondition
            //postToParse["Price"] = self.post?.postPrice
            
            
            
            postToParse.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("Object Saved!")
                    
                } else {
                    // There was a problem, check error.description
                }
            }

            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPostToUpload(post)
        
    }
    
    func postToUpload(post: Post)
    {
        self.post = post
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
            
            self.bookTitleLabel.text = post?.postBook
            
            self.bookDescriptionLabel.text = post?.postDescrip
            
        }
        
    }
    
    
}
