//
//  Date+.swift
//  
//
//  Created by Q Trang on 8/1/20.
//

import Foundation

extension Date {
    public var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    public var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    public var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    public static func allYears(from: Date, to: Date) -> [String] {
        var years: [String] = []
        
        for i in stride(from: from.year, to: to.year, by: 1) {
            years.append("\(i)")
        }
        
        return years
    }
}

