//
//  Date+Format.swift
//  AzowoScratchCards
//
//  Created by Marek Baláž on 22/07/2023.
//

import Foundation

extension Date {
    
    /// MMM d, yyyy, HH:mm
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMM d, yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
    
    static func serverDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: dateString)
    }
    
}
