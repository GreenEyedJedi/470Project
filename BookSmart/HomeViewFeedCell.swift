//
//  HomeViewFeedCell.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/31/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse


class HomeViewFeedCell: UITableViewCell
{
    @IBOutlet weak var UserPostTitleLabel: UILabel!
    @IBOutlet weak var BookTitleLabel: UILabel!
    @IBOutlet weak var BookDescripLabel: UILabel!
    @IBOutlet weak var BookImageView: UIImageView!
    @IBOutlet weak var FeedView: UIView!
    
    
    @IBAction func SaveForLaterButton(sender: AnyObject)
    {
        
    }
    
    
    @IBAction func ViewBookButton(sender: AnyObject)
    {
        
    }
    
    func homePageFeedViewSetup()
    {
        
        FeedView.alpha = 1
        FeedView.layer.masksToBounds = false
        
        let path = UIBezierPath(rect: FeedView.bounds)
        
        FeedView.layer.shadowOffset = CGSizeMake(-0.25, -0.25)
        FeedView.layer.shadowRadius = 1
        FeedView.layer.shadowPath = path.CGPath
        FeedView.layer.shadowOpacity = 0.2
        
    }
    
    func bookImageSetup()
    {
        BookImageView.layer.cornerRadius = BookImageView.frame.size.width/2
        BookImageView.clipsToBounds = true
        BookImageView.backgroundColor = UIColor.whiteColor()
        BookImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        
    }
    
    
    
}
