//
//  PlannerMenuBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit
import SafariServices

final class PlannerMenuBuilder {
    func initializePlannerMenuUI(_ privacyButton: UIButton, _ contactUsButton: UIButton, _ returnButton: UIButton, _ plannerMenuTitle: UILabel) {
        privacyButton.layer.cornerRadius = 20
        contactUsButton.layer.cornerRadius = 20
        
        privacyButton.setTitle("Polityka prywatności", for: .normal)
        contactUsButton.setTitle("Połącz się z nami", for: .normal)
        
        returnButton.setImage(UIImage(named: "teseClosing")!, for: .normal)
        plannerMenuTitle.text = "Ustawienia"
    }
    
    func presentPlannerMenuInSafari(_ url: URL, _ currentUnitController: UIViewController, _ typeOfPlanner: Bool) {
        if typeOfPlanner {
            let plannerPrivacySafariUnitController = SFSafariViewController(url: url)
            currentUnitController.present(plannerPrivacySafariUnitController, animated: true, completion: nil)
        } else {
            let plannerContactUsSafariUnitController = SFSafariViewController(url: url)
            currentUnitController.present(plannerContactUsSafariUnitController, animated: true, completion: nil)
        }
    }
}
