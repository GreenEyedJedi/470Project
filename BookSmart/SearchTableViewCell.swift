//
//  SearchTableViewCell.swift
//  BookSmart
//
//  Created by Justin Whitmer on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellText: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTextLabel (text: String)
    {
        cellText.text = text
    }

}
