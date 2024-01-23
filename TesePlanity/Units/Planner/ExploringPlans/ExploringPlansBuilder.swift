//
//  ExploringPlansBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

final class ExploringPlansBuilder {
    func setSelectedExploredPlanData(_ exploreView: UIView, _ pictureView: UIImageView, _ pictureOfExplore: UIImage, _ namePlan: UILabel, _ infoPlan: UITextView, _ sumPlan: UILabel, title: String, info: String, sum: String) {
        exploreView.layer.cornerRadius = exploreView.frame.height / 2
        pictureView.image = pictureOfExplore
        namePlan.text = title
        infoPlan.text = info
        sumPlan.text = "$ \(sum)"
    }
    
    func initalizeExploringPlansUI(_ backMove: UIButton, _ exploringTitle: UILabel, _ dltPlan: UIButton, exploringViews: [UIView], sumView: UIView, totalSum: UILabel, addingSumView: UIView) {
        backMove.setImage(UIImage(named: "teseClosing")!, for: .normal)
        exploringTitle.text = "Twój cel"
        dltPlan.setImage(UIImage(named: "deleteUnitPlan")!, for: .normal)
        sumView.layer.cornerRadius = 14
        addingSumView.layer.cornerRadius = 14
        totalSum.text = "$ 0"
        for exploringView in exploringViews {
            exploringView.layer.cornerRadius = 10
        }
    }
    
    func setAdditionalExploringElements(_ infoTitle: UILabel, _ collectibleInfo: UILabel, _ partInfo: UILabel, _ addSum: UIButton, _ sumTxtFld: UITextField, _ currentController: UIViewController) {
        infoTitle.text = "Opis:"
        collectibleInfo.text = "Zebrane:"
        partInfo.text = "Z"
        addSum.setImage(UIImage(named: "updateUnit")!, for: .normal)
        
        sumTxtFld.delegate = currentController.self as? UITextFieldDelegate
        sumTxtFld.attributedPlaceholder = NSAttributedString(
            string: "$10",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4482307434, green: 0.5601338744, blue: 0.70691365, alpha: 1)]
        )
    }
    
    func deleteSelectedExplorePlanFromStorageUnit(_ plan: UnitPlan, _ completion: @escaping () -> ()) {
        StorageUnitService.sharedStorage.deleteUnitPlan(plan)
        StorageUnitService.sharedStorage.setSaveStorageUnitMethod()
        completion()
    }
}
