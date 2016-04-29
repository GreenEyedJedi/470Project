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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        print("We get here?")
        var cell:HomeViewFeedCell? = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as? HomeViewFeedCell

        let postObject = object as! Post
        
//        if let bookObject = postObject["BookID"] as? Book
//        {
//        
//        bookObject.fetchIfNeededInBackgroundWithBlock {
//            (bookObject: PFObject?, error: NSError?) -> Void in
//            let bookTitle = bookObject?["Title"] as? String
//            cell?.bookTitleLabel?.text = bookTitle
//        }
//        }
//        
        print(postObject)
        
        var imageFromParse = postObject.objectForKey("PostImage") as? PFFile
        imageFromParse!.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
            var image: UIImage! = UIImage(data: imageData!)!
            cell?.bookImageView.image = image
        })
        
        // Need to make a call to Book class and create a relational data with BookID from Post object
        
        cell?.bookTitleLabel?.text = postObject["BookTitle"] as? String
        cell?.bookDescripLabel?.text = postObject["PostDescription"] as? String
        cell?.userPostTitleLabel?.text = postObject["PostTitle"] as? String
        
        if let price = postObject["Price"] as? NSNumber
        {
            cell?.priceLabel?.text = "$\(price)"
        }
        
        
        
        return cell
    }

}
