//
//  BookLookup.swift
//  BookSmart
//
//  Created by Alec Brownlie on 4/28/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit

class BookLookupDataSource: NSObject
{
    var bookDict: [AnyObject]
    
    init(dataSource: [AnyObject]) {
        bookDict = dataSource
        super.init()
    }
    
    func numTitles() -> Int
    {
        return bookDict.count
    }
    
    func titleAt(index: Int) -> BookLookup
    {
        let title = BookLookup(book: bookDict[index])
        return title
    }
    
    
}
