//
//  SendMessageViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/4/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import MessageUI


class SendMessageViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate
{
    var user : PFUser?
    var seller : PFObject?
    var post : Post?
    
    @IBOutlet weak var subjectTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBAction func sendMessageButton(sender: AnyObject)
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        messageTextView.text = "Message"
        
        if let p = self.post
        {
            self.subjectTextField.text = "RE: \(p["PostTitle"] as! String)"
        }
        
        
    }
    
 
    
    func getUserAndSellerAndPost(user : PFUser?, seller: PFObject?, post : Post?)
    {
        if let u = user
        {
            self.user = u
        }
        if let s = seller
        {
            self.seller = s
        }
        if let p = post
        {
            self.post = p
        }
        
        print("Message Info: user = \(self.user), seller = \(self.seller), and post = \(self.post)")
    }
    //
    //    func retrieveSellerInformation()
    //    {
    //        if let seller = self.seller
    //        {
    //
    //        }
    //    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        if let seller = self.seller, post = self.post
        {
            if let email = seller["email"]
            {
                mailComposerVC.setToRecipients([email as! String])
                print("email address to send to is: \(email)")

            }
            
            var postTitle = post["PostTitle"] as! String
            
            
            mailComposerVC.setSubject("RE: \(postTitle)")
            mailComposerVC.setMessageBody(self.messageTextView.text, isHTML: false)
        }
        return mailComposerVC
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
