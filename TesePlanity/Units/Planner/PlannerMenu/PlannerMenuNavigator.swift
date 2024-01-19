//
//  PlannerMenuNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

final class PlannerMenuNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableDirectoryReturnNavigationToDirectoryControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let returnDirectoryControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .directoryUnit) as? DirectoryControllerUnit {
            returnDirectoryControllerUnit.modalTransitionStyle = unitTransition
            returnDirectoryControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(returnDirectoryControllerUnit, animated: true)
        }
    }
}
