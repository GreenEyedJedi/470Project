//
//  CreatePostViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/14/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

//import Cocoa
import UIKit
import Parse

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var post : Post?
    
    @IBOutlet weak var MenuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var ISBNTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var courseNumberTextField: UITextField!
    @IBOutlet weak var courseSectionTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    @IBAction func nextButton(sender: AnyObject)
    {
        if checkTextFields() == true
        {
            post = Post(PostTitle: postTitleTextField.text, BookTitle: bookTitleTextField.text, Author: authorTextField.text, ISBN: ISBNTextField.text, Department: departmentTextField.text, CNumber: courseNumberTextField.text, CSection: courseSectionTextField.text, Description: descriptionTextField.text, Image: imageView, Price: nil)
        }
        else
        {
            let alertErrorController = UIAlertController(title: "Warning", message: "Required text fields must be completed", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertErrorController, animated: true, completion: nil)
        }
    }
  
    
    @IBAction func uploadImageButton(sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func checkTextFields() -> Bool
    {
        if (!postTitleTextField.text!.isEmpty && !bookTitleTextField.text!.isEmpty && !authorTextField.text!.isEmpty &&
            !departmentTextField.text!.isEmpty && !courseNumberTextField.text!.isEmpty && !courseSectionTextField.text!.isEmpty && !descriptionTextField.text!.isEmpty)
        {
            return true
        }
        else
        {
            return false
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // array and query for loadDepartmentData()
    var departmentArray: [String] = [String]()
    var departmentQuery = PFQuery(className: "Departments")
    func loadDepartmentData()
    {
        departmentQuery.orderByAscending("DeptName")
        departmentQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects{
                    for object in objects {
                        self.departmentArray.append(object.objectForKey("DeptName") as! String)
                    }
                }
            }
        }
    }
    
    // array and query for loadCourseData()
    var courseArray: [String] = ["-- Select Department --"]
    var courseQuery = PFQuery(className: "Courses")
    var courseSkip = 0
    var limit = 1000
    func loadCourseData(dept: String)
    {
        courseArray.removeAll()
        courseQuery.orderByAscending("CourseNo")
        courseQuery.whereKey("Department", equalTo: dept)
        courseQuery.limit = limit
        //courseQuery.skip = skip
        courseQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        var course = object.objectForKey("CourseNo") as! String
                        if !self.courseArray.contains(course)
                        {
                            self.courseArray.append(course)
                        }
                    }
                }
                
                if objects!.count == self.limit
                {
                    self.courseSkip = self.courseSkip + self.limit
                    self.loadCourseData(dept)
                }
            }
        }
        
    }
    
    // array and query for loadSectionData()
    var sectionArray: [String] = ["-- Select Course --"]
    var sectionQuery = PFQuery(className: "Courses")
    var sectionSkip = 0
    func loadSectionData(course: String)
    {
        sectionArray.removeAll()
        sectionQuery.orderByAscending("SectionNo")
        sectionQuery.whereKey("CourseNo", equalTo: course)
        sectionQuery.limit = limit
        //courseQuery.skip = skip
        sectionQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        var section = object.objectForKey("SectionNo")
                        var sectionNo = section!.stringValue
                        if !self.sectionArray.contains(sectionNo)
                        {
                            self.sectionArray.append(sectionNo)
                        }
                    }
                }
                
                if objects!.count == self.limit
                {
                    self.sectionSkip = self.sectionSkip + self.limit
                    self.loadSectionData(course)
                }
            }
        }
    }
    
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuBarButton.target = self.revealViewController()
        MenuBarButton.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        loadDepartmentData()
                
        var departmentPickerView = UIPickerView()
        var coursesPickerView = UIPickerView()
        var sectionPickerView = UIPickerView()
        
        imagePicker.delegate = self
        
        departmentPickerView.tag = 0
        coursesPickerView.tag = 1
        sectionPickerView.tag = 2
        
        departmentPickerView.delegate = self
        coursesPickerView.delegate = self
        sectionPickerView.delegate = self
        
        departmentTextField.inputView = departmentPickerView
        courseNumberTextField.inputView = coursesPickerView
        courseSectionTextField.inputView = sectionPickerView
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 0
        {
            return departmentArray.count
        }
        
        if pickerView.tag == 1
        {
            return courseArray.count
        }
        
        if pickerView.tag == 2
        {
            return sectionArray.count
        }
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        if pickerView.tag == 0
        {
            return departmentArray[row]
        }
        if pickerView.tag == 1
        {
            if courseArray.count <= 0{
                return "-- Select Department --"
            }
            else{
                
                return courseArray[row]
            }
          
        }
        
        if pickerView.tag == 2
        {
            if sectionArray.count <= 0{
                return "-- Select Course --"
            }
            else{
                
                return sectionArray[row]
            }
            
        }
        
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0
        {
            departmentTextField.text = departmentArray[row]
            self.courseSkip = 0
            self.loadCourseData(departmentArray[row])
        }
        if pickerView.tag == 1
        {
            if courseArray.count > 1 {
                courseNumberTextField.text = courseArray[row]
                self.sectionSkip = 0
                self.loadSectionData(courseArray[row])
            }
            else
            {
                courseNumberTextField.text = ""
            }
        }
        
        if pickerView.tag == 2
        {
            if sectionArray.count > 1 {
                courseSectionTextField.text = sectionArray[row]
            }
            else
            {
                courseSectionTextField.text = ""
            }
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "finishPost" {
            if let p = post{
                let detailedVC = segue.destinationViewController as! FinishPostViewController
                detailedVC.postToUpload(p)
            }
        }
    }
    
}