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
        if checkPasswordFields() == true
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
        }
        else
        {
            var failureAlert = UIAlertController(title: "Password Error", message: "Password fields must be completed and match.", preferredStyle: UIAlertControllerStyle.Alert)
            
            failureAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(failureAlert, animated: true, completion: nil)
        }
        
    }
    
    func checkPasswordFields() -> Bool
    {
        if let pass = self.passwordTextField.text, confirm = self.confirmPasswordTextField.text
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
