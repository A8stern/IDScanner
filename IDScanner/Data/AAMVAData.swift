//
//  AAMVAData.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 27.09.2024.
//

import Foundation

struct AAMVAData {
    var lastName: String = ""
    var firstName: String = ""
    var jurisdiction: String = ""
    var birthDate: String = ""
    var expirationDate: String = ""
    var gender: String = ""
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMddyyyy"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
    func display() -> String {
        return """
        Last Name: \(lastName)
        First Name: \(firstName)
        Jurisdiction: \(jurisdiction)
        Date of Birth: \(formatDate(birthDate))
        Expiration Date: \(formatDate(expirationDate))
        Gender: \(gender == "1" ? "Male" : "Female")
        """
    }
}
