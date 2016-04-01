//
//  HomeViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/30/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//


import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet weak var MenuBarButton: UIBarButtonItem!
   
    // will be using NSMutableArrays later, static for now
    private var userPostArray:[String]?
    private var photoArray:[UIImage]?
    private var titleArray:[String]?
    private var descriptionArray:[String]?
    
    
    @IBOutlet weak var FeedTableView: HomeViewTableController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        FeedTableView.delegate = self
        self.title = "BookSmart"
        
    }

    func loadData()
    {
        // Load data into feed
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return userPostArray!.count ?? 0
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath index: NSIndexPath!) -> UITableViewCell!
    {
        let cell : HomeViewFeedCell = tableView.dequeueReusableCellWithIdentifier("feedcell", forIndexPath: index) as! HomeViewFeedCell
      
        return cell
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
}