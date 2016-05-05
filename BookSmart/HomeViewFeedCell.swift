//
//  HomeViewFeedCell.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/31/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewFeedCell: PFTableViewCell
{
    
    @IBOutlet weak var viewPostDetailButton: UIButton!
    @IBOutlet weak var backPackItButton: UIButton!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookDescripLabel: UILabel!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var userPostTitleLabel: UILabel!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
//   
//    @IBAction func backPackItAction(sender: AnyObject)
//    {
//        if let post = self.postObject
//        {
//            savePostToBackPack(post)
//        }
//    }
    
   

    
    //var parseObject:PFObject?
    
    var postObject : Post?
    var bookObject : Book?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //print("I'm awake!")
    }
    
 
//    @IBAction func SaveForLaterButton(sender: AnyObject)
//    {
//        print("SaveForLaterButton pressed.")
//    }
    
    
//    @IBAction func ViewBookButton(sender: AnyObject)
//    {
//        print("ViewBookButton pressed.")
//    }
    
//    override func layoutSubviews() {
//        homePageFeedViewSetup()
//        bookImageSetup()
//        print("")
//    }
    
    func homePageFeedViewSetup()
    {
        
        feedView.alpha = 1
        feedView.layer.masksToBounds = false
        
        let path = UIBezierPath(rect:                feedView.bounds)
        
        feedView.layer.shadowOffset = CGSizeMake(-0.25, -0.25)
        feedView.layer.shadowRadius = 1
        feedView.layer.shadowPath = path.CGPath
        feedView.layer.shadowOpacity = 0.2
        
    }
    
    func bookImageSetup()
    {
        bookImageView.layer.cornerRadius = bookImageView.frame.size.width/2
        bookImageView.clipsToBounds = true
        bookImageView.backgroundColor = UIColor.whiteColor()
        bookImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        
    }
    
    
    
}
