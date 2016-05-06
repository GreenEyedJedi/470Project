//
//  PostBrowseTableViewController.swift
//  BookSmart
//
//  Created by Justin Whitmer on 5/6/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class PostBrowseTableViewController: PFQueryTableViewController {

    var bookTitle: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Posts"
        self.textKey = "BookTitle"
        
        self.paginationEnabled = true
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        
        var query = PFQuery(className: "Posts")
        query.whereKey("BookTitle", equalTo: bookTitle)
        return query
    }
    
    func acceptBookTitle (title: String)
    {
        self.bookTitle = title
    }

}
