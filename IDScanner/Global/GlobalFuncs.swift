//
//  AAMVAConverter.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 25.09.2024.
//

import Foundation

func parseAAMVAData(_ rawData: String) -> AAMVAData {
    var parsedData = AAMVAData() 
    
    let fields = rawData.components(separatedBy: "\n")
    
    for field in fields {
        if field.hasPrefix("DCS") {
            let lastName = field.replacingOccurrences(of: "DCS", with: "")
            parsedData.lastName = lastName
        } else if field.hasPrefix("DCT") {
            let firstName = field.replacingOccurrences(of: "DCT", with: "")
            parsedData.firstName = firstName
        } else if field.hasPrefix("DCA") {
            let jurisdiction = field.replacingOccurrences(of: "DCA", with: "")
            parsedData.jurisdiction = jurisdiction
        } else if field.hasPrefix("DBB") {
            let birthDate = field.replacingOccurrences(of: "DBB", with: "")
            parsedData.birthDate = birthDate
        } else if field.hasPrefix("DBA") {
            let expirationDate = field.replacingOccurrences(of: "DBA", with: "")
            parsedData.expirationDate = expirationDate
        } else if field.hasPrefix("DBC") {
            let gender = field.replacingOccurrences(of: "DBC", with: "")
            parsedData.gender = gender
        }
    }
    
    return parsedData
}

func calculateAge(from birthDateString: String) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMddyyyy" 
    
    guard let birthDate = dateFormatter.date(from: birthDateString) else {
        return nil
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
    return ageComponents.year
}

func isDocumentExpired(expirationDate: String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMddyyyy"
    if let expDate = dateFormatter.date(from: expirationDate) {
        return expDate < Date()
    }
    return false
}
