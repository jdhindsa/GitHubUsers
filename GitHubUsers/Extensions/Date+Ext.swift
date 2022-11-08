//
//  Date+Ext.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-11.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
