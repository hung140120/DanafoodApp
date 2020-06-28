//
//  Date+.swift
//  XoSo
//
//  Created by Dinh Hung on 5/15/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
extension Date {
    public static var fm_ddmmyyy                    = "dd/MM/yyyy"
    public static var fm_ddmmyyy2                   = "yyyy-MM-dd"
    public static var fm_ddmmyyy3                   = "dd-MM-yyyy"
    public static var fm_ddmmyy                     = "dd/MM/yy"
    public static var fm_mmyy                       = "MM/yy"
    public static var fm_mmyyyy                     = "MM/yyyy"
    
    public init(str: String, format: String, localized: Bool) {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        fmt.timeZone = localized ? TimeZone.current : TimeZone(abbreviation: "UTC")
        if let date = fmt.date(from: str) {
            self.init(timeInterval: 0, since: date)
        } else {
            self.init(timeInterval: 0, since: Date())
        }
    }
    
    public func toString(format: String, localized: Bool = false) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = format
        fmt.timeZone = localized ? TimeZone.current : TimeZone(abbreviation: "UTC")
        return fmt.string(from: self)
    }
    
    public func days(to dateB: Date) -> Int? {
        let diffInDays = Calendar.current.dateComponents([.day], from: self, to: dateB).day
        return diffInDays
    }

    
    func format(to format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func getLastDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let nowDay = Date()
        let lastTime: TimeInterval = -(24*60*60)
        
        let lastDate = nowDay.addingTimeInterval(lastTime)
        let lastDay = dateFormatter.string(from: lastDate)
        return lastDay
    }
    
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
//        let year = components.year
//        let month = components.month
//        let day = components.day
        let hour = components.hour
        let minute = components.minute
        //let second = components.second
        
        let today_string = String(hour!)  + "." + String(minute!%60)
        
        return today_string
    }
}
