//
//  DateHelper.swift
//  Homework6
//
//  Created by Максим Бобков on 06.02.2024.
//

import Foundation

final class DateHelper {
    
    static func getDate(date: Date?) -> String {
        
        guard let date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY hh:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: date)
    }
}
