//
//  PostViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/7/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostViewController : PFQueryTableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Post.query()
       
        return query!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
    {
        var cell:HomeViewFeedCell? = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as? HomeViewFeedCell

        // set viewPostDetailButton tag to indexPath.row
        cell?.viewPostDetailButton.tag = indexPath.row
        cell?.backPackItButton.tag = indexPath.row
        
        cell?.backPackItButton.addTarget(self, action: "showAlert:", forControlEvents:UIControlEvents.TouchUpInside)
        
        let postObject = object as! Post
        print(postObject)
        
        var imageFromParse = postObject.objectForKey("PostImage") as? PFFile
        imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            var image: UIImage! = UIImage(data: imageData!)!
            cell?.bookImageView.image = image
        })
        
        // Need to make a call to Book class and create a relational data with BookID from Post object
        cell?.postObject = postObject
        cell?.bookTitleLabel?.text = postObject["BookTitle"] as? String
        cell?.bookDescripLabel?.text = postObject["PostDescription"] as? String
        cell?.userPostTitleLabel?.text = postObject["PostTitle"] as? String
        
        if let price = postObject["Price"] as? NSNumber
        {
            cell?.priceLabel?.text = "$\(price)"
        }
        
        
        
        return cell
    }

    func showAlert(sender:UIButton!)
    {
        let indexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! HomeViewFeedCell
        if let post = cell.postObject
        {
            savePostToBackPack(post)
        }
        
    }
    
    func savePostToBackPack(post: Post)
    {
        let refreshAlert = UIAlertController(title: "Add to BackPack?", message: "Are you sure you want to add this post to your BackPack?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            if let user = PFUser.currentUser()
            {
                let backPackRelation = user.relationForKey("BackPack")
                backPackRelation.addObject(post)
                
                user.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    
                    if (success) {
                        let successAlert = UIAlertController(title: "Success!", message: "Post has been added to BackPack", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        successAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(successAlert, animated: true, completion: nil)
                        
                    } else {
                        // There was a problem, check error.description
                        //self.activityIndicator.stopAnimating()
                        let failureAlert = UIAlertController(title: "Error", message: "There was an error saving your post. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(failureAlert, animated: true, completion: nil)
                        
                    }
                }
                
                print("Post \(post) added to BackPack!")
            }
            
            //var postToBackPack = PFObject(className:"Posts")
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toPostDetail"
        {
            let detailedVC = segue.destinationViewController as! ViewPostDetailViewController
            if let button = sender as? UIButton
            {
                let cell = button.superview?.superview?.superview as! HomeViewFeedCell
                
                if let post = cell.postObject
                {
                    detailedVC.postToView(post)
                }
            }
        }
    }
    
}
