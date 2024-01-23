//
//  PlannerMenuControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

class PlannerMenuControllerUnit: UIViewController {
    
    @IBOutlet weak var directoryReturnButton: UIButton!
    @IBOutlet weak var planPrivacyButton: UIButton!
    @IBOutlet weak var contactUsPlanButton: UIButton!
    @IBOutlet weak var plannerMenuTitle: UILabel!
    
    private var navigator: PlannerMenuNavigator = PlannerMenuNavigator()
    private var builder: PlannerMenuBuilder = PlannerMenuBuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
        setPlannerMenuConfiguration()
    }
    
    private func setPlannerMenuConfiguration() {
        builder.initializePlannerMenuUI(planPrivacyButton, contactUsPlanButton, directoryReturnButton, plannerMenuTitle)
    }
    
    @IBAction func directoryReturnHandle(_ sender: UIButton) {
        navigator.enableDirectoryReturnNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
    
    @IBAction func planPrivacyHandle(_ sender: UIButton) {
        builder.presentPlannerMenuInSafari(URL(string: "https://teseplanity.info/")!, self, true)
    }
    
    @IBAction func contactUsPlanHandle(_ sender: UIButton) {
        builder.presentPlannerMenuInSafari(URL(string: "https://support.teseplanity.info/")!, self, false)
    }
}
