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
        
        var departmentPickerView1 = UIPickerView()
        var coursesPickerView1 = UIPickerView()
        var sectionPickerView1 = UIPickerView()
        
        var departmentPickerView2 = UIPickerView()
        var coursesPickerView2 = UIPickerView()
        var sectionPickerView2 = UIPickerView()
        
        var departmentPickerView3 = UIPickerView()
        var coursesPickerView3 = UIPickerView()
        var sectionPickerView3 = UIPickerView()
        
        var departmentPickerView4 = UIPickerView()
        var coursesPickerView4 = UIPickerView()
        var sectionPickerView4 = UIPickerView()
        
        var departmentPickerView5 = UIPickerView()
        var coursesPickerView5 = UIPickerView()
        var sectionPickerView5 = UIPickerView()
        
        var departmentPickerView6 = UIPickerView()
        var coursesPickerView6 = UIPickerView()
        var sectionPickerView6 = UIPickerView()
        
        var universityPickerView = UIPickerView()
        var termPickerView = UIPickerView()
        
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
            return "Spring 2016"
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
        default:
            print("Error with pickers")
        }

        
    }
    
}
