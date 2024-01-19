//
//  NavigatorService.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

final class NavigatorUnitService {
    static let shared = NavigatorUnitService()

    private init() {}

    enum UnitTag: String {
        case StarterUnit
        case PlannerUnit
    }
    
    enum ControllerUnitId: String {
        case startGuideUnit
        case directoryUnit
        case planAddingUnit
        case exploringPlansUnit
        case plannerMenuUnit
    }

    func setControllerUnitInstantiation<T: UIViewController>(fromUnitTag unitTag: UnitTag, _ controllerUnit: ControllerUnitId) -> T {
        let unit = UIStoryboard(name: unitTag.rawValue, bundle: nil)
        guard let viewController = unit.instantiateViewController(withIdentifier: controllerUnit.rawValue) as? T else {
            fatalError("Failed to instantiate controller from unit \(unitTag.rawValue) with unit id \(controllerUnit)")
        }
        return viewController
    }
}
