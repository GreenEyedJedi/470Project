//
//  ViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBAction func LogInButton(sender: AnyObject)
    {
        LogIn()
    }
    @IBAction func SignUpButton(sender: AnyObject)
    {
        SignUp()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func LogIn()
    {
        var user = PFUser()
        user.username = UsernameTextField.text
        user.password = PasswordTextField.text
        user.email = EmailTextField.text
        
        PFUser.logInWithUsernameInBackground(UsernameTextField.text!, password: PasswordTextField.text!, block: {
            (User : PFUser?, Error: NSError?) -> Void in
            
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
                NSLog("Wrong Password")
            }
            
        })
    }

    func SignUp()
    {
        var user = PFUser()
        user.username = UsernameTextField.text
        user.password = PasswordTextField.text
        user.email = EmailTextField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if error == nil{
                // Hooray! Let them use app now
            }
            else
            {
                // Examine error object and inform user
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

