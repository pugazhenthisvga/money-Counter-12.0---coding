//
//  Money+CoreDataProperties.swift
//  Money Counter
//
//  Created by PUGAZHENTHI VENKATACHALAM on 21/06/18.
//  Copyright © 2018 PUGAZHENTHI VENKATACHALAM. All rights reserved.
//
//

import Foundation
import CoreData


extension Money {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Money> {
        return NSFetchRequest<Money>(entityName: "Money")
    }

    @NSManaged public var cent1: String?
    @NSManaged public var cent2: String?
    @NSManaged public var cent5: String?
    @NSManaged public var cent10: String?
    @NSManaged public var cent20: String?
    @NSManaged public var cent25: String?
    @NSManaged public var cent50: String?
    @NSManaged public var cent100: String?
    
    @NSManaged public var dollarQuarter: String?
    @NSManaged public var dollarHalf: String?
    @NSManaged public var dollar1: String?
    @NSManaged public var dollar2: String?
    @NSManaged public var dollar3: String?
    @NSManaged public var dollar5: String?
    @NSManaged public var dollar10: String?
    @NSManaged public var dollar20: String?
    @NSManaged public var dollar25: String?
    @NSManaged public var dollar50: String?
    @NSManaged public var dollar100: String?
    @NSManaged public var dollar150: String?
    @NSManaged public var dollar200: String?
    @NSManaged public var dollar500: String?
    @NSManaged public var dollar1000: String?
    @NSManaged public var dollar2000: String?
    @NSManaged public var dollar5000: String?
    @NSManaged public var dollar10000: String?
    @NSManaged public var dollar20000: String?
    @NSManaged public var dollar50000: String?
    @NSManaged public var dollar100000: String?
    @NSManaged public var total: String?
    @NSManaged public var currencyCode: String?

}
