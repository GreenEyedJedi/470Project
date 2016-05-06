//
//  ProfilePostsTableViewCell.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfilePostsTableViewCell: PFTableViewCell
{
    var postObject : Post!
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var deptAndCourseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

}
