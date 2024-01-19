//
//  PlanAddingNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

final class PlanAddingNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableClosingNavigationToDirectoryControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let closingDirectoryControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .directoryUnit) as? DirectoryControllerUnit {
            closingDirectoryControllerUnit.modalTransitionStyle = unitTransition
            closingDirectoryControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(closingDirectoryControllerUnit, animated: true)
        }
    }
}
