//
//  FinishPostViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/26/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class FinishPostViewController: UIViewController
{
    var post : Post?
    
    @IBOutlet weak var priceLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("The post being used is: \(post)")
        
    }
    
    func postToUpload(post: Post)
    {
        self.post = post
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // update price and condition before segue
        
        if segue.identifier == "uploadPost"
        {
            if let p = post{
                let detailedVC = segue.destinationViewController as! UploadPostViewController
                detailedVC.postToUpload(p)
            }
        }
    }
}
