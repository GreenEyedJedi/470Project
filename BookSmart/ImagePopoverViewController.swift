//
//  ImagePopoverViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class ImagePopoverViewController: UIViewController
{
    @IBOutlet weak var popoverImageView: UIImageView!
    var bookImage : UIImage!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        popoverImageView.image = bookImage
    }
    
    func useImage(image: UIImageView?)
    {
        if let picture = image
        {
            print("do we get here?")
            self.bookImage = picture.image
            
        }
    }
}
