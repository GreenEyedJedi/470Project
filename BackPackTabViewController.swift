//
//  BackPackTabViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class BackPackTabViewController: UITabBarController
{
    @IBOutlet weak var MenuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
