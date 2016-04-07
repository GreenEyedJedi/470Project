//
//  HomeViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/30/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//


import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var MenuBarButton:UIBarButtonItem!
//    @IBOutlet weak var UserPostTitleLabel: UILabel!
//    @IBOutlet weak var BookTitleLabel: UILabel!
//    @IBOutlet weak var BookDescripLabel: UILabel!
//    @IBOutlet weak var BookImageView: UIImageView!
//    @IBOutlet weak var FeedView: UIView!
    
    var postArray:[Post]!
    var postSizeArray:NSArray!
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        //feedTableView.separatorColor = UIColor(CGColor: clearColor)
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        //FeedTableView.delegate = self
        self.title = "BookSmart"
       // userPostArray = ["Selling used book for SOCI 370!", "Barely used CS 470 textbook", "Like-new CCJS 101 text"]
        
        
    }

    func loadData()
    {
        // Load data into feed
        let bookImage1 : UIImage = UIImage(named: "HeroicEfforts.JPG")!
        let bookImage2 : UIImage = UIImage(named: "DrugsBook.JPG")!
        
        let post1 = Post(id: 1, title: "Used SOCI 317 book for sale", photo: bookImage1, desc: "Like new condition, as if it was never open.", book: "Heroic Efforts", price: 45.99, condition: "Good")
        
        let post2 = Post(id: 2, title: "Book for CCJS 370", photo: bookImage2, desc: "Required textbook for Dr. Wolfe's class", book: "Drugs and Drug Policies", price: 100.00, condition: "Like New")
        
        postArray = [post1, post2]
        
        //postSizeArray = NSArray(objects: 200, 200, 300, nil)
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        //return userPostArray.count ?? 0
        return postArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath index: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedcell", forIndexPath: index) as! HomeViewFeedCell
        
        //cell.layoutSubviews()
        print("tableView cellForRowAtIndexPath called")
        
        let feed = postArray
        let post = feed[index.row]
                cell.bookTitleLabel?.text = post.getBookName()
                cell.bookImageView.image = post.getPhoto()
                cell.bookDescripLabel?.text = post.getDescription()
                cell.userPostTitleLabel?.text = post.getTitle()
        cell.feedView.frame = CGRectMake(10, 5, 300, 200)
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
}