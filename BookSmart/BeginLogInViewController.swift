//
//  BeginLogInViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/3/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class BeginLogInViewController: UIViewController
{
    // Storyboard properties
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBAction func LogInButton(sender: AnyObject)
    {
        logIn()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let user = PFUser.currentUser() {
            if user.authenticated
            {
                var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                var MainVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("MainVC")
                self.presentViewController(MainVC, animated: true, completion: nil)
            }
        }
    }
    
    // Log in using Parse framework
    func logIn()
    {
        var user = PFUser()
        user.username = UsernameTextField.text
        user.password = PasswordTextField.text
        //user.email = EmailTextField.text
        
        // If a field is left empty, show error message
        if UsernameTextField.text == "" || PasswordTextField.text == ""
        {
            let alertErrorController = UIAlertController(title: "Invalid Log In", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertErrorController.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertErrorController, animated: true, completion: nil)
            
            
        }
        else
        {
            PFUser.logInWithUsernameInBackground(UsernameTextField.text!, password: PasswordTextField.text!, block: {
                (User : PFUser?, Error: NSError?) -> Void in
                
                // if no error, go to HomeView
                if Error == nil
                {
                    dispatch_async(dispatch_get_main_queue()){
                        var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                        var MainVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("MainVC")
                        self.presentViewController(MainVC, animated: true, completion: nil)
                    }
                }
                else
                {
                    // if wrong username or password, clear fields and throw error
                    let alertErrorController = UIAlertController(title: "Wrong Username or Password", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertErrorController.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertErrorController, animated: true, completion: nil)
                    
                    self.UsernameTextField.text = ""
                    self.PasswordTextField.text = ""
                }
                
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

}
