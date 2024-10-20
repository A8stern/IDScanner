//
//  DriverIDHistory+CoreDataProperties.swift
//  
//
//  Created by Kovalev Gleb on 01.10.2024.
//
//

import Foundation
import CoreData


extension DriverIDHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DriverIDHistory> {
        return NSFetchRequest<DriverIDHistory>(entityName: "DriverIDHistory")
    }

    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var jurisdiction: String?
    @NSManaged public var birthDate: String?
    @NSManaged public var expirationDate: String?
    @NSManaged public var gender: String?
    @NSManaged public var date: Date?

}
