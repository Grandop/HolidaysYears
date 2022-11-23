//
//  Holidays.swift
//  Holidays
//
//  Created by Pedro Grando on 22/11/22.
//

import Foundation

struct Holidays: Codable {
    var date: Date
    var name: String
    
    func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self.date)
    }
    
    func getDayOfMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self.date)
    }
    
    func getDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self.date)
    }
    
}
