//
//  FindBooksViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/31/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class FindBooksViewController: UIViewController
{
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var sideMenuButton: UIButton!

   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var URL = NSURL(string: "http://sonoma.bncollege.com/webapp/wcs/stores/servlet/BNCBHomePage?storeId=27551&catalogId=10001&langId=-1")
        
        webView.loadRequest(NSURLRequest(URL: URL!))

//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    
    
}
