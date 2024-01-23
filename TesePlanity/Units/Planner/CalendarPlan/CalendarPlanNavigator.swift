//
//  CalendarPlanNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

final class CalendarPlanNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableTurnOutNavigationToDirectoryControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let turnOutDirectoryControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .directoryUnit) as? DirectoryControllerUnit {
            turnOutDirectoryControllerUnit.modalTransitionStyle = unitTransition
            turnOutDirectoryControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(turnOutDirectoryControllerUnit, animated: true)
        }
    }
}
