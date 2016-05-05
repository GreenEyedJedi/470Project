//
//  MatchesTableViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class MatchesTableViewController: PFQueryTableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        tableView.delegate = self
        
        tableView.allowsMultipleSelectionDuringEditing = true
    }

    override func viewWillAppear(animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery {
        let query = Post.query()
        
        return query!
    }
}
