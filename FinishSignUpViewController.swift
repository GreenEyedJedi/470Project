//
//  FinishSignUpViewController.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/3/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class FinishSignUpViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    var user : PFUser?
    
    var deptCourseProf1 : DeptCourseProfLookup?
    var deptCourseProf2 : DeptCourseProfLookup?
    var deptCourseProf3 : DeptCourseProfLookup?
    var deptCourseProf4 : DeptCourseProfLookup?
    var deptCourseProf5 : DeptCourseProfLookup?
    var deptCourseProf6 : DeptCourseProfLookup?
    
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    
    @IBOutlet weak var departmentTextField1: UITextField!
    @IBOutlet weak var courseTextField1: UITextField!
    @IBOutlet weak var professorTextField1: UITextField!
    
    @IBOutlet weak var departmentTextField2: UITextField!
    @IBOutlet weak var courseTextField2: UITextField!
    @IBOutlet weak var professorTextField2: UITextField!
    
    @IBOutlet weak var departmentTextField3: UITextField!
    @IBOutlet weak var courseTextField3: UITextField!
    @IBOutlet weak var professorTextField3: UITextField!
    
    @IBOutlet weak var departmentTextField4: UITextField!
    @IBOutlet weak var courseTextField4: UITextField!
    @IBOutlet weak var professorTextField4: UITextField!
    
    @IBOutlet weak var departmentTextField5: UITextField!
    @IBOutlet weak var courseTextField5: UITextField!
    @IBOutlet weak var professorTextField5: UITextField!
    
    @IBOutlet weak var departmentTextField6: UITextField!
    @IBOutlet weak var courseTextField6: UITextField!
    @IBOutlet weak var professorTextField6: UITextField!
    
    @IBAction func signUpButton(sender: AnyObject)
    {
        signUpUser()
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func loadPickers()
    {
        if let dept1 = self.deptCourseProf1
        {
            dept1.loadDepartmentData()
        }
        if let dept2 = self.deptCourseProf2
        {
            dept2.loadDepartmentData()
        }
        if let dept3 = self.deptCourseProf3
        {
            dept3.loadDepartmentData()
        }
        if let dept4 = self.deptCourseProf4
        {
            dept4.loadDepartmentData()
        }
        if let dept5 = self.deptCourseProf5
        {
            dept5.loadDepartmentData()
        }
        if let dept6 = self.deptCourseProf6
        {
            dept6.loadDepartmentData()
        }
    }
    
    func findCourseIDs() -> [NSNumber]
    {
        var courseIDArray: Array<NSNumber> = []
        
        if !(self.departmentTextField1.text == nil && self.courseTextField1.text == nil && self.professorTextField1.text == nil)
        {
            if let lookup = self.deptCourseProf1, dept = self.departmentTextField1.text, course = self.courseTextField1.text, prof = self.professorTextField1.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        
        if !(self.departmentTextField2.text == nil && self.courseTextField2.text == nil && self.professorTextField2.text == nil)
        {
            if let lookup = self.deptCourseProf2, dept = self.departmentTextField2.text, course = self.courseTextField2.text, prof = self.professorTextField2.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        
        if !(self.departmentTextField3.text == nil && self.courseTextField3.text == nil && self.professorTextField3.text == nil)
        {
            if let lookup = self.deptCourseProf3, dept = self.departmentTextField3.text, course = self.courseTextField3.text, prof = self.professorTextField3.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        
        if !(self.departmentTextField4.text == nil && self.courseTextField4.text == nil && self.professorTextField4.text == nil)
        {
            if let lookup = self.deptCourseProf4, dept = self.departmentTextField4.text, course = self.courseTextField4.text, prof = self.professorTextField4.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        
        if !(self.departmentTextField5.text == nil && self.courseTextField5.text == nil && self.professorTextField5.text == nil)
        {
            if let lookup = self.deptCourseProf5, dept = self.departmentTextField5.text, course = self.courseTextField5.text, prof = self.professorTextField5.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        
        if !(self.departmentTextField6.text == nil && self.courseTextField6.text == nil && self.professorTextField6.text == nil)
        {
            if let lookup = self.deptCourseProf6, dept = self.departmentTextField6.text, course = self.courseTextField6.text, prof = self.professorTextField6.text
            {
                let courseID = lookup.findCourseID(dept, course: course, profLastName: prof)
                if courseID != 0
                {
                    courseIDArray.append(courseID)
                    print("Course ID: \(courseID) appended")
                }
            }
        }
        return courseIDArray
    }
    
    func signUpUser()
    {
        
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        var courseObjects = [PFObject]()
        
        var courseIDArray = findCourseIDs()
        
        //findCourseIDs()
        
        if let newUser = self.user
        {
            var relation = newUser.relationForKey("CourseRelation")
            
            var courseQuery = PFQuery(className: "Courses")
            
            print("Elements in courseIDArray = \(courseIDArray)")
            
            let courses = courseIDArray
            
            for (var i = 0; i < courses.count; i++)
            {
                print("CourseID to query: \(courses[i])")
                if courses[i] != 0
                {
                    
                    courseQuery.whereKey("CourseID", equalTo: courses[i])
                    do
                    {
                        let course = try courseQuery.getFirstObject()
                        relation.addObject(course)
                        print("CourseRelation: \(course) added!")
                    }
                    catch
                    {
                        // error with getting course object
                        
                    }
                }
            }
            
            
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if error == nil{
                    self.activityIndicator.stopAnimating()
                    let refreshAlert = UIAlertController(title: "Welcome!", message: "You are now signed up with BookSmart", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            var Storyboard = UIStoryboard(name: "Main", bundle: nil)
                            var MainVC : UIViewController = Storyboard.instantiateViewControllerWithIdentifier("MainVC")
                            self.presentViewController(MainVC, animated: true, completion: nil)
                        }
                        }
                        ))
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                    
                }
                else
                {
                    self.activityIndicator.stopAnimating()
                    // Examine error object and inform user
                    let alertErrorController = UIAlertController(title: "Error", message: "There was an error with your sign up. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertErrorController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertErrorController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.activityIndicator.hidden = true
        
        deptCourseProf1 = DeptCourseProfLookup()
        deptCourseProf2 = DeptCourseProfLookup()
        deptCourseProf3 = DeptCourseProfLookup()
        deptCourseProf4 = DeptCourseProfLookup()
        deptCourseProf5 = DeptCourseProfLookup()
        deptCourseProf6 = DeptCourseProfLookup()
        
        loadPickers()
        
        let departmentPickerView1 = UIPickerView()
        let coursesPickerView1 = UIPickerView()
        let sectionPickerView1 = UIPickerView()
        
        let departmentPickerView2 = UIPickerView()
        let coursesPickerView2 = UIPickerView()
        let sectionPickerView2 = UIPickerView()
        
        let departmentPickerView3 = UIPickerView()
        let coursesPickerView3 = UIPickerView()
        let sectionPickerView3 = UIPickerView()
        
        let departmentPickerView4 = UIPickerView()
        let coursesPickerView4 = UIPickerView()
        let sectionPickerView4 = UIPickerView()
        
        let departmentPickerView5 = UIPickerView()
        let coursesPickerView5 = UIPickerView()
        let sectionPickerView5 = UIPickerView()
        
        let departmentPickerView6 = UIPickerView()
        let coursesPickerView6 = UIPickerView()
        let sectionPickerView6 = UIPickerView()
        
        let universityPickerView = UIPickerView()
        let termPickerView = UIPickerView()
        
        departmentPickerView1.tag = 0
        coursesPickerView1.tag = 1
        sectionPickerView1.tag = 2
        
        departmentPickerView2.tag = 3
        coursesPickerView2.tag = 4
        sectionPickerView2.tag = 5
        
        departmentPickerView3.tag = 6
        coursesPickerView3.tag = 7
        sectionPickerView3.tag = 8
        
        departmentPickerView4.tag = 9
        coursesPickerView4.tag = 10
        sectionPickerView4.tag = 11
        
        departmentPickerView5.tag = 12
        coursesPickerView5.tag = 13
        sectionPickerView5.tag = 14
        
        departmentPickerView6.tag = 15
        coursesPickerView6.tag = 16
        sectionPickerView6.tag = 17
        
        universityPickerView.tag = 18
        termPickerView.tag = 19
        
        universityPickerView.delegate = self
        termPickerView.delegate = self
        
        departmentPickerView1.delegate = self
        coursesPickerView1.delegate = self
        sectionPickerView1.delegate = self
        
        departmentPickerView2.delegate = self
        coursesPickerView2.delegate = self
        sectionPickerView2.delegate = self
        
        departmentPickerView3.delegate = self
        coursesPickerView3.delegate = self
        sectionPickerView3.delegate = self
        
        departmentPickerView4.delegate = self
        coursesPickerView4.delegate = self
        sectionPickerView4.delegate = self
        
        departmentPickerView5.delegate = self
        coursesPickerView5.delegate = self
        sectionPickerView5.delegate = self
        
        departmentPickerView6.delegate = self
        coursesPickerView6.delegate = self
        sectionPickerView6.delegate = self
        
        universityTextField.inputView = universityPickerView
        termTextField.inputView = termPickerView
        
        departmentTextField1.inputView = departmentPickerView1
        courseTextField1.inputView = coursesPickerView1
        professorTextField1.inputView = sectionPickerView1
        
        departmentTextField2.inputView = departmentPickerView2
        courseTextField2.inputView = coursesPickerView2
        professorTextField2.inputView = sectionPickerView2
        
        departmentTextField3.inputView = departmentPickerView3
        courseTextField3.inputView = coursesPickerView3
        professorTextField3.inputView = sectionPickerView3
        
        departmentTextField4.inputView = departmentPickerView4
        courseTextField4.inputView = coursesPickerView4
        professorTextField4.inputView = sectionPickerView4
        
        departmentTextField5.inputView = departmentPickerView5
        courseTextField5.inputView = coursesPickerView5
        professorTextField5.inputView = sectionPickerView5
        
        departmentTextField6.inputView = departmentPickerView6
        courseTextField6.inputView = coursesPickerView6
        professorTextField6.inputView = sectionPickerView6
    }
    
    func useUserInformation(userData: PFUser?)
    {
        if let user = userData
        {
            self.user = user
            print("USER IS = \(self.user)")
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView.tag
        {
        case 0:
            if let dept = deptCourseProf1
            {
                return dept.departmentArray.count
            }
        case 1:
            if let course = deptCourseProf1
            {
                return course.courseArray.count
            }
        case 2:
            if let prof = deptCourseProf1
            {
                return prof.professorArray.count
            }
        case 3:
            if let dept = deptCourseProf2
            {
                return dept.departmentArray.count
            }
        case 4:
            if let course = deptCourseProf2
            {
                return course.courseArray.count
            }
        case 5:
            if let prof = deptCourseProf2
            {
                return prof.professorArray.count
            }
        case 6:
            if let dept = deptCourseProf3
            {
                return dept.departmentArray.count
            }
        case 7:
            if let course = deptCourseProf3
            {
                return course.courseArray.count
            }
        case 8:
            if let prof = deptCourseProf3
            {
                return prof.professorArray.count
            }
        case 9:
            if let dept = deptCourseProf4
            {
                return dept.departmentArray.count
            }
        case 10:
            if let course = deptCourseProf4
            {
                return course.courseArray.count
            }
        case 11:
            if let prof = deptCourseProf4
            {
                return prof.professorArray.count
            }
        case 12:
            if let dept = deptCourseProf5
            {
                return dept.departmentArray.count
            }
        case 13:
            if let course = deptCourseProf5
            {
                return course.courseArray.count
            }
        case 14:
            if let prof = deptCourseProf5
            {
                return prof.professorArray.count
            }
        case 15:
            if let dept = deptCourseProf6
            {
                return dept.departmentArray.count
            }
        case 16:
            if let course = deptCourseProf6
            {
                return course.courseArray.count
            }
        case 17:
            if let prof = deptCourseProf6
            {
                return prof.professorArray.count
            }
        case 18:
            return 1
        case 19:
            return 1
        default:
            return 1
        }
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView.tag
        {
        case 0:
            if let dept = deptCourseProf1
            {
                return dept.departmentArray[row]
            }
        case 1:
            if let course = deptCourseProf1
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 2:
            if let prof = deptCourseProf1
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 3:
            if let dept = deptCourseProf2
            {
                return dept.departmentArray[row]
            }
        case 4:
            if let course = deptCourseProf2
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 5:
            if let prof = deptCourseProf2
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 6:
            if let dept = deptCourseProf3
            {
                return dept.departmentArray[row]
            }
        case 7:
            if let course = deptCourseProf3
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 8:
            if let prof = deptCourseProf3
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 9:
            if let dept = deptCourseProf4
            {
                return dept.departmentArray[row]
            }
        case 10:
            if let course = deptCourseProf4
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 11:
            if let prof = deptCourseProf4
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 12:
            if let dept = deptCourseProf5
            {
                return dept.departmentArray[row]
            }
        case 13:
            if let course = deptCourseProf5
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 14:
            if let prof = deptCourseProf5
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 15:
            if let dept = deptCourseProf6
            {
                return dept.departmentArray[row]
            }
        case 16:
            if let course = deptCourseProf6
            {
                if course.courseArray.count <= 0
                {
                    return "-- Select Department --"
                }
                else
                {
                    return course.courseArray[row]
                }
            }
        case 17:
            if let prof = deptCourseProf6
            {
                if prof.professorArray.count <= 0
                {
                    return "-- Select Course --"
                }
                else
                {
                    return prof.professorArray[row]
                }
            }
        case 18:
            return "Sonoma State University"
        case 19:
            return "Fall 2016"
        default:
            return ""
        }
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView.tag
        {
        case 0:
            if let dept = deptCourseProf1
            {
                self.departmentTextField1.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 1:
            if let course = deptCourseProf1
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField1.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField1.text!)
                }
                else
                {
                    self.courseTextField1.text = ""
                }
            }
        case 2:
            if let prof = deptCourseProf1
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField1.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField1.text = ""
                }
            }
        case 3:
            if let dept = deptCourseProf2
            {
                self.departmentTextField2.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 4:
            if let course = deptCourseProf2
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField2.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField2.text!)
                }
                else
                {
                    self.courseTextField2.text = ""
                }
            }
        case 5:
            if let prof = deptCourseProf2
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField2.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField2.text = ""
                }
            }
        case 6:
            if let dept = deptCourseProf3
            {
                self.departmentTextField3.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 7:
            if let course = deptCourseProf3
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField3.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField3.text!)
                }
                else
                {
                    self.courseTextField3.text = ""
                }
            }
        case 8:
            if let prof = deptCourseProf3
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField3.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField3.text = ""
                }
            }
        case 9:
            if let dept = deptCourseProf4
            {
                self.departmentTextField4.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 10:
            if let course = deptCourseProf4
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField4.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField4.text!)
                }
                else
                {
                    self.courseTextField4.text = ""
                }
            }
        case 11:
            if let prof = deptCourseProf4
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField4.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField4.text = ""
                }
            }
        case 12:
            if let dept = deptCourseProf5
            {
                self.departmentTextField5.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 13:
            if let course = deptCourseProf5
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField5.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField5.text!)
                }
                else
                {
                    self.courseTextField5.text = ""
                }
            }
        case 14:
            if let prof = deptCourseProf5
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField5.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField5.text = ""
                }
            }
        case 15:
            if let dept = deptCourseProf6
            {
                self.departmentTextField6.text = dept.departmentArray[row]
                dept.courseSkip = 0
                dept.loadCourseData(dept.departmentArray[row])
            }
        case 16:
            if let course = deptCourseProf6
            {
                if course.courseArray.count > 0
                {
                    self.courseTextField6.text = course.courseArray[row]
                    course.professorSkip = 0
                    course.loadProfessorData(course.courseArray[row], department: self.departmentTextField6.text!)
                }
                else
                {
                    self.courseTextField6.text = ""
                }
            }
        case 17:
            if let prof = deptCourseProf6
            {
                if prof.professorArray.count > 0
                {
                    self.professorTextField5.text = prof.professorArray[row]
                }
                else
                {
                    self.professorTextField5.text = ""
                }
            }
        case 18:
            self.universityTextField.text = "Sonoma State University"
        case 19:
            self.termTextField.text = "Fall 2016"
        default:
            print("Error with pickers")
        }
        
        
    }
    
}
