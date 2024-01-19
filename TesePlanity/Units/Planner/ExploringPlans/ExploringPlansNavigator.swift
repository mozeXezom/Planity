//
//  ExploringPlansNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

final class ExploringPlansNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableBackmoveNavigationToDirectoryControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let backmoveDirectoryControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .directoryUnit) as? DirectoryControllerUnit {
            backmoveDirectoryControllerUnit.modalTransitionStyle = unitTransition
            backmoveDirectoryControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(backmoveDirectoryControllerUnit, animated: true)
        }
    }
}
