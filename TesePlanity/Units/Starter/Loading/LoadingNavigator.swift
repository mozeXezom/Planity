//
//  LoadingNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

final class LoadingNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableNavigationToStartGuideControllerUnit(_ currentControllerUnit: UIViewController, unitTransition: UIModalTransitionStyle, unitPresentation: UIModalPresentationStyle) {
        if let startGuideControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .StarterUnit, .startGuideUnit) as? StartGuideControllerUnit {
            startGuideControllerUnit.modalPresentationStyle = unitPresentation
            startGuideControllerUnit.modalTransitionStyle = unitTransition
            currentControllerUnit.present(startGuideControllerUnit, animated: true)
        }
    }
}
