//
//  HomeViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/30/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//


import UIKit
import Parse

class HomeViewController: UIViewController
{
    @IBOutlet weak var MenuBarButton:UIBarButtonItem!
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        self.title = "BookSmart"
       
        
        
    }

//    func getPosts() {
//        //1
//        let query = Post.query()!
//        query.findObjectsInBackgroundWithBlock { objects, error in
//            if error == nil {
//                //2
//                if let objects = objects as? [Post] {
//                    self.loadWallViews(objects)
//                }
//            } else if let error = error {
//                //3
//                self.showErrorView(error)
//            }
//        }
//    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        
//        //return userPostArray.count ?? 0
//        return postArray.count;
//    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath index: NSIndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCellWithIdentifier("feedcell", forIndexPath: index) as! HomeViewFeedCell
//        
//        //cell.layoutSubviews()
//        print("tableView cellForRowAtIndexPath called")
//        
//        let feed = postArray
//        let post = feed[index.row]
//                cell.bookTitleLabel?.text = post.getBookName()
//                cell.bookImageView.image = post.getPhoto()
//                cell.bookDescripLabel?.text = post.getDescription()
//                cell.userPostTitleLabel?.text = post.getTitle()
//        cell.feedView.frame = CGRectMake(10, 5, 300, 200)
//        
//        return cell
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
}