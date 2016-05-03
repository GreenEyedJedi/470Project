//
//  DeptCourseProfLookup.swift
//  BookSmart
//
//  Created by Alec Brownlie on 5/3/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse

class DeptCourseProfLookup
{
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
    
    func findCourseID(department: String, course: String, profLastName: String) -> NSNumber
    {
        do{
            var sectionQuery = PFQuery(className: "Courses")
            
            sectionQuery.whereKey("CourseNo", equalTo: course)
            sectionQuery.whereKey("Department", equalTo: department)
            sectionQuery.whereKey("PLName", equalTo: profLastName)
            sectionQuery.limit = limit
            //courseQuery.skip = skip
            let courseObject = try sectionQuery.getFirstObject()
            
            let id = courseObject["CourseID"] as! NSNumber
            return id
            
        }
        catch
        {
            return 0
        }
        
    }

}
