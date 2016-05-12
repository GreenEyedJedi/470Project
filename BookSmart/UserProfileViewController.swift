//
//  UserProfileViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var MenuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordUpdateTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func uploadProfilePictureButton(sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func updateUserProfileButton(sender: AnyObject)
    {
        
            
            var refreshAlert = UIAlertController(title: "Update Profile", message: "Do you want to update your profile?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
                
                self.activityIndicator.hidden = false
                self.activityIndicator.startAnimating()
                
                if let currentUser = PFUser.currentUser()
                {
                    if let picture = PFFile(data: UIImageJPEGRepresentation(self.userProfileImageView.image!, 1.0)!)
                    {
                        currentUser["ProfilePicture"] = picture
                    }
                    
                    currentUser["username"] = self.usernameTextField.text
                    currentUser["FName"] = self.firstNameTextField.text
                    currentUser["LName"] = self.lastNameTextField.text
                    currentUser["email"] = self.emailTextField.text
                    if self.checkPasswordFields()
                    {
                        currentUser.password = self.passwordUpdateTextField.text
                    }
                    else
                    {
                        if let pass = self.passwordUpdateTextField.text, confirm = self.confirmPasswordTextField.text
                        {
                            if pass != confirm
                            {
                                let failureAlert = UIAlertController(title: "Password Error", message: "Passwords must be identical.", preferredStyle: UIAlertControllerStyle.Alert)
                                
                                failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                                
                                self.presentViewController(failureAlert, animated: true, completion: nil)
                                self.activityIndicator.stopAnimating()
                                return
                            }
                        }
                    }
                   
                    
                    currentUser.saveInBackgroundWithBlock({
                        (success: Bool, error: NSError?) -> Void in
                        
                        if (success) {
                            if self.checkPasswordFields()
                            {
                                PFUser.logInWithUsernameInBackground(currentUser.username!, password: currentUser.password!)
                            }
                            dispatch_async(dispatch_get_main_queue()) {
                                var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                                var HomeVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("HomeNavVC")
                                self.revealViewController().setFrontViewController(HomeVC, animated: true)
                            }
                            
                        } else {
                            // There was a problem, check error.description
                            self.activityIndicator.stopAnimating()
                            var failureAlert = UIAlertController(title: "Error", message: "There was an error with your upload. Try again", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
                        }})
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                return
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.activityIndicator.stopAnimating()
        
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        imagePicker.delegate = self
        
        getUserInformation()
    }
    
    func checkPasswordFields() -> Bool
    {
        if let pass = self.passwordUpdateTextField.text, confirm = self.confirmPasswordTextField.text
        {
            if pass.isEmpty && confirm.isEmpty
            {
                return false
            }
            else
            {
                if pass == confirm
                {
                    return true
                }
                else
                {
                    return false
                }
            }
        }
        return false
       
    }
    
    func getUserInformation()
    {
        if let user = PFUser.currentUser()
        {
            usernameTextField.text = user.username
            emailTextField.text = user.email
            //passwordUpdateTextField.text = user.password
            
            print("Password is = \(user.password)")
            
            if let firstN = user["FName"] as? String
            {
                print("firstN = \(firstN)")
                self.firstNameTextField.text = firstN
            }
            if let lastN = user["LName"] as? String
            {
                print("lastN = \(lastN)")
                self.lastNameTextField.text = lastN
            }
            if let picture = user["ProfilePicture"] as? PFFile
            {
                print("Found picture?")
                picture.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                    let image: UIImage! = UIImage(data: imageData!)!
                    self.userProfileImageView.image = image
                })
            }
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userProfileImageView.contentMode = .ScaleAspectFit
            userProfileImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
