//
//  Course.swift
//  BookSmart
//
//  Created by Justin Whitmer on 4/21/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit

class Course: NSObject {

    var professorName: String?
    var sectionNo: Int?
    var deptAndCourse: String?
    
    
    init(prof: String, section sectionNo: Int, course wholeClass: String)
    {
        self.professorName = prof
        self.sectionNo = sectionNo
        self.deptAndCourse = wholeClass
        super.init()
    }
    
    func getProfessor() -> String?
    {
        return self.professorName
    }
    
    func getSection() -> Int?
    {
        return self.sectionNo
    }
    
    func getClass() -> String?
    {
        return self.deptAndCourse
    }
}
