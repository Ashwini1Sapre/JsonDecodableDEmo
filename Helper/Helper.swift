//
//  Helper.swift
//  JsonDecodableDEmo
//
//  Created by Knoxpo MacBook Pro on 05/04/21.
//

import Foundation
import SwiftUI

extension DateFormatter {
    
    static let fullISO8601: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
   }()
}

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
extension Int {
    var formatted: String {
        let sign = self >= 0 ? "+" : ""
     return "T" + sign + "\(self)"
    }
}


extension Bool {
    var formatted: String {
        return self ? "Succeeded" : "Failed"
    }
}














