//
//  StartGuideNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

final class StartGuideNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableNavigationToStartGuideControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let directoryControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .directoryUnit) as? DirectoryControllerUnit {
            directoryControllerUnit.modalTransitionStyle = unitTransition
            directoryControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(directoryControllerUnit, animated: true)
        }
    }
}
