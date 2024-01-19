//
//  DirectoryNavigator.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

final class DirectoryNavigator {
    private let navigatorUnitService = NavigatorUnitService.shared
    
    func enableNavigationToPlanAddingControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let planAddingControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .planAddingUnit) as? PlanAddingControllerUnit {
            planAddingControllerUnit.modalTransitionStyle = unitTransition
            planAddingControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(planAddingControllerUnit, animated: true)
        }
    }
    
    func enableNavigationToExploringPlansControllerUnit(_ planTitle: String, _ planInformation: String, _ planPicture: UIImage, _ planSum: String,  _ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let exploringPlansControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .exploringPlansUnit) as? ExploringPlansControllerUnit {
            exploringPlansControllerUnit.handledPlanTitle = planTitle
            exploringPlansControllerUnit.handledPlanInformation = planInformation
            exploringPlansControllerUnit.handledPlanPicture = planPicture
            exploringPlansControllerUnit.handledPlanSum = planSum
            exploringPlansControllerUnit.modalTransitionStyle = unitTransition
            exploringPlansControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(exploringPlansControllerUnit, animated: true)
        }
    }
    
    func enableNavigationToPlanAddingControllerUnitWithPlanTypeInfo(_ stateOfPlan: Bool, _ planType: String, _ planTypePicture: UIImage, _ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let planAddingControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .planAddingUnit) as? PlanAddingControllerUnit {
            planAddingControllerUnit.planState = stateOfPlan
            planAddingControllerUnit.typeOfPlan = planType
            planAddingControllerUnit.pictureOfTypePlan = planTypePicture
            planAddingControllerUnit.modalTransitionStyle = unitTransition
            planAddingControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(planAddingControllerUnit, animated: true)
        }
    }
    
    func enableNavigationToPlannerMenuControllerUnit(_ currentControllerUnit: UIViewController, unitPresentation: UIModalPresentationStyle, unitTransition: UIModalTransitionStyle) {
        if let plannerMenuControllerUnit = navigatorUnitService.setControllerUnitInstantiation(fromUnitTag: .PlannerUnit, .plannerMenuUnit) as? PlannerMenuControllerUnit {
            plannerMenuControllerUnit.modalTransitionStyle = unitTransition
            plannerMenuControllerUnit.modalPresentationStyle = unitPresentation
            currentControllerUnit.present(plannerMenuControllerUnit, animated: true)
        }
    }
}
