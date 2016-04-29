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
    var ISBN : String?
    @IBOutlet weak var MenuBarButton: UIBarButtonItem!
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var postPriceTextField: UITextField!
    @IBOutlet weak var postConditionTextField: UITextField! // will make this into picker
    @IBOutlet weak var bookISBNTextField: UITextField!
    
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var courseNumberTextField: UITextField!
    @IBOutlet weak var courseProfessorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    @IBAction func nextButton(sender: AnyObject)
    {
        if checkTextFields() == true
        {
            var courseID = findCourseID(departmentTextField.text!, course: courseNumberTextField.text!, profLastName: courseProfessorTextField.text!)
            print("COURSE ID IS = \(courseID)")
            post = Post(PostTitle: postTitleTextField.text, User: PFUser.currentUser(), Condition: postConditionTextField.text, Book: nil, Course: nil, Description: descriptionTextField.text, Image: imageView, Price: postPriceTextField.text)
            ISBN = bookISBNTextField.text
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
    
    func findCourseID(department: String, course: String, profLastName: String) -> Int
    {
        var courseID = 0
        var sectionArray = [Int]()
        var sectionQuery = PFQuery(className: "Courses")
        var sectionSkip = 0
        
        sectionQuery.orderByAscending("CourseID")
        sectionQuery.whereKey("CourseNo", equalTo: course)
        sectionQuery.whereKey("Department", equalTo: department)
        sectionQuery.whereKey("PLName", equalTo: profLastName)
        sectionQuery.limit = limit
        //courseQuery.skip = skip
        sectionQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        var course = object.objectForKey("CourseID")
                        var id:Int = course!.integerValue
                        courseID = id
                    }
                }
                
                if objects!.count == self.limit
                {
                    sectionSkip = sectionSkip + self.limit
                    self.findCourseID(department, course: course, profLastName: profLastName)
                }
            }
        }
        
        return courseID
        
    }
    
    func checkTextFields() -> Bool
    {
        if (!postTitleTextField.text!.isEmpty && !departmentTextField.text!.isEmpty && !courseNumberTextField.text!.isEmpty && !courseProfessorTextField.text!.isEmpty && !descriptionTextField.text!.isEmpty)
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
    var professorArray: [String] = ["-- Select Course --"]
    var professorQuery = PFQuery(className: "Courses")
    var professorSkip = 0
    func loadProfessorData(course: String, department: String)
    {
        professorArray.removeAll()
        professorQuery.orderByAscending("PLName")
        professorQuery.whereKey("CourseNo", equalTo: course)
        professorQuery.whereKey("Department", equalTo: department)
        professorQuery.limit = limit
        //courseQuery.skip = skip
        professorQuery.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        //var professorFN = object.objectForKey("PFName")
                        var professorLN = object.objectForKey("PLName") as! String
                        //var FN = professorFN!.stringValue
                        //var LN = professorLN!.stringValue
                        if !self.professorArray.contains(professorLN)
                        {
                            self.professorArray.append(professorLN)
                        }
                    }
                }
                
                if objects!.count == self.limit
                {
                    self.professorSkip = self.professorSkip + self.limit
                    self.loadProfessorData(course, department: department)
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
        courseProfessorTextField.inputView = sectionPickerView
        
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
            return professorArray.count
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
            if professorArray.count <= 0{
                return "-- Select Course --"
            }
            else{
                
                return professorArray[row]
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
            if courseArray.count > 0 {
                courseNumberTextField.text = courseArray[row]
                self.professorSkip = 0
                self.loadProfessorData(courseArray[row], department: departmentTextField.text!)
            }
            else
            {
                courseNumberTextField.text = ""
            }
        }
        
        if pickerView.tag == 2
        {
            if professorArray.count > 0 {
                courseProfessorTextField.text = professorArray[row]
            }
            else
            {
                courseProfessorTextField.text = ""
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
                if let i = ISBN{
                    detailedVC.postToUploadWithISBN(p, isbn: i)
                }
                else
                {
                    detailedVC.postToUpload(p)
                }
            }
        }
    }
    
}