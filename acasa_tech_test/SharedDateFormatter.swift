//
//  SharedDateFormatter.swift
//  acasa_tech_test
//
//  Created by Alex Little on 28/01/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation

class SharedDateFormatter {
    
    static let sharedInstance = SharedDateFormatter()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    lazy var timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        return timeFormatter
    }()
    
    lazy var dateTimeFormatter: DateFormatter = {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateTimeFormatter
    }()
    lazy var dateFormatterUk: DateFormatter = {
        let dateFormatterUk = DateFormatter()
        dateFormatterUk.dateFormat = "dd-MM-yyyy"
        return dateFormatterUk
    }()
    lazy var dateTimeFormatterUk: DateFormatter = {
        let dateTimeFormatterUk = DateFormatter()
        dateTimeFormatterUk.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateTimeFormatterUk
    }()
}

