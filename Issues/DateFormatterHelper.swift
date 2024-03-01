//
//  DateFormatterHelper.swift
//  Issues
//
//  Created by Ryan Zhou on 1/23/24.
//

import Foundation

public class DateFormatterHelper {
    public static func formateDateString(_ dateString: String) -> String? {
        let apiDateFormatter = DateFormatter()
        apiDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        apiDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        apiDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = apiDateFormatter.date(from: dateString) else {
            return nil
        }
        
        let userFriendlyDateFormatter = DateFormatter()
        userFriendlyDateFormatter.dateStyle = .long
        userFriendlyDateFormatter.timeStyle = .none
        
        return userFriendlyDateFormatter.string(from: date)
    }
}
