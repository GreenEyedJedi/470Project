//
//  SignUpViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/3/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var user : PFUser?
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBAction func uploadProfilePicButton(sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func nextButton(sender: AnyObject)
    {
        beginSignUp()
    }
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    func beginSignUp()
    {
        var user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        
        if let profilepic = self.profilePictureImageView.image, picture = PFFile(data: UIImageJPEGRepresentation(profilepic, 1.0)!)
        {
            user["ProfilePicture"] = picture
        }
        
        self.user = user
        
//        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            if error == nil{
//                // Hooray! Let them use app now
//                let alertErrorController = UIAlertController(title: "Welcome!", message: "You are now signed up with BookSmart", preferredStyle: UIAlertControllerStyle.Alert)
//                
//                alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
//                
//                self.presentViewController(alertErrorController, animated: true, completion: nil)
//                
//                
//            }
//            else
//            {
//                // Examine error object and inform user
//                let alertErrorController = UIAlertController(title: "Error", message: "There was an error with your sign up. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
//                
//                alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
//                
//                self.presentViewController(alertErrorController, animated: true, completion: nil)
//            }
//        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureImageView.contentMode = .ScaleAspectFit
            profilePictureImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // update price and condition before segue
        
        if segue.identifier == "nextSignUp"
        {
            if let u = self.user{
                let detailedVC = segue.destinationViewController as! FinishSignUpViewController
                
                detailedVC.useUserInformation(u)
            }
        }
    }

    

}
