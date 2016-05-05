//
//  MatchesTableViewCell.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MatchesTableViewCell: PFTableViewCell
{
    var postObject : Post!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var deptAndCourseLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
}
