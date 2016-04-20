//
//  ViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController
{
    // Storyboard properties
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBAction func LogInButton(sender: AnyObject)
    {
        logIn()
    }
    @IBAction func SignUpButton(sender: AnyObject)
    {
        signUp()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
    
    // Only used to show HomeView for now
    override func viewDidAppear(animated: Bool) {
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
        user.email = EmailTextField.text
        
        // If a field is left empty, show error message
        if UsernameTextField.text == "" || PasswordTextField.text == "" || EmailTextField.text == ""
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
                self.EmailTextField.text = ""
            }
            
        })
        }
    }

    func signUp()
    {
        var user = PFUser()
        user.username = UsernameTextField.text
        user.password = PasswordTextField.text
        user.email = EmailTextField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil{
                // Hooray! Let them use app now
                let alertErrorController = UIAlertController(title: "Welcome!", message: "You are now signed up with BookSmart", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertErrorController, animated: true, completion: nil)
                
               
            }
            else
            {
                // Examine error object and inform user
                let alertErrorController = UIAlertController(title: "Error", message: "There was an error with your sign up. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertErrorController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

