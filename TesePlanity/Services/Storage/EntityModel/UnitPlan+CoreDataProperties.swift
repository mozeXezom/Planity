//
//  UnitPlan+CoreDataProperties.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//
//

import Foundation
import CoreData


extension UnitPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UnitPlan> {
        return NSFetchRequest<UnitPlan>(entityName: "UnitPlan")
    }

    @NSManaged public var unitPlanPicture: Data?
    @NSManaged public var unitPlanTitle: String?
    @NSManaged public var unitPlanInform: String?
    @NSManaged public var unitSum: String?
    @NSManaged public var unitDate: String?

}

extension UnitPlan : Identifiable {

}
