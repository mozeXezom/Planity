//
//  StorageUnitService.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit
import CoreData

final class StorageUnitService {
    static let sharedStorage = StorageUnitService()

    lazy var storageContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "StorageUnitModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failure storage: \(error), \(error.userInfo)")
            }
        }
        return persistentContainer
    }()
    
    func setUnitPlansFetching() -> [UnitPlan] {
        let unitFetchRequest: NSFetchRequest<UnitPlan> = UnitPlan.fetchRequest()
        do {
            return try storageContainer.viewContext.fetch(unitFetchRequest)
        } catch {
            print("Failure settings unit plans fetching\(error)")
            return []
        }
    }
}

extension StorageUnitService {
    func setUpNewUnitPlan(_ unitPlanPicture: Data?, _ unitPlanTitle: String, _ unitPlanInform: String, _ unitDate: String, _ unitSum: String) -> UnitPlan {
        
        let newUnitPlan = UnitPlan(context: storageContainer.viewContext)
        newUnitPlan.unitPlanPicture = unitPlanPicture
        newUnitPlan.unitPlanTitle = unitPlanTitle
        newUnitPlan.unitPlanInform = unitPlanInform
        newUnitPlan.unitDate = unitDate
        newUnitPlan.unitSum = unitSum
        
        return newUnitPlan
    }
    
    func deleteUnitPlan(_ unitPlan: UnitPlan) {
        let unitContext = unitPlan.managedObjectContext
        unitContext?.delete(unitPlan)
        
        do {
            try unitContext?.save()
            print("Unit plan was deleted")
        } catch {
            print("Failure delete unit plan: \(error)")
        }
    }
}

extension StorageUnitService {
    func setSaveStorageUnitMethod() {
        let containerViewContext = storageContainer.viewContext
        
        if containerViewContext.hasChanges {
            do {
                try containerViewContext.save()
            } catch {
                let failureError = error as NSError
                fatalError("Container and viewContext error: \(failureError.userInfo)")
            }
        }
    }

    func setDeleteStorageUnitMethod(_ unitEntityName: String) {
        let deletionFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: unitEntityName)
        let storageDeleteRequest = NSBatchDeleteRequest(fetchRequest: deletionFetchRequest)
        
        do {
            try storageContainer.viewContext.execute(storageDeleteRequest)
            setSaveStorageUnitMethod()
        } catch {
            print("Entity was not deleted: \(error)")
        }
    }
}

