//
//  PostDataSource.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/5/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    private var postID:Int?
    private var postTitle:String?
    private var postPhoto:UIImage?
    private var postDescription:String?
    private var postBook:String?
    private var postPrice:Float?
    private var postCondition:String?
    
    
    init(id: Int, title : String, photo : UIImage, desc : String, book : String, price : Float, condition : String) {
        //posts = dataSource
        postID = id
        postTitle = title
        postPhoto = photo
        postDescription = desc
        postBook = book
        postPrice = price
        postCondition = condition
        super.init()
    }
    
    func getPostID() -> Int?
    {
        let id = postID ?? nil
        return id
    }
    
    func getPhoto () -> UIImage?
    {
        let photo = postPhoto ?? nil
        return photo
    }
    
    func getTitle() -> String?
    {
        let title = postTitle ?? nil
        return title
    }
    
    func getDescription() -> String?
    {
        let description = postDescription ?? nil
        return description
    }
    
    func getBookName() -> String?
    {
        let book = postBook ?? nil
        return book
    }
    
    func getPrice() -> Float?
    {
        let price = postPrice ?? nil
        return price
    }
    
    func getCondition() -> String?
    {
        let condition = postCondition ?? nil
        return condition
    }
    
    
}