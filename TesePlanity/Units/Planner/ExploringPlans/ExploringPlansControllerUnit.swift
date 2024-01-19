//
//  ExploringPlansUnitController.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

class ExploringPlansControllerUnit: UIViewController {
    
    @IBOutlet weak var backmoveButton: UIButton!
    
    private var builder: ExploringPlansBuilder = ExploringPlansBuilder()
    private var navigator: ExploringPlansNavigator = ExploringPlansNavigator()
    
    var handledPlanTitle: String?
    var handledPlanInformation: String?
    var handledPlanPicture: UIImage?
    var handledPlanSum: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setExploringPlansConfiguration()
    }
    
    private func setExploringPlansConfiguration() {
        
    }
    
    @IBAction func backmoveHandle(_ sender: UIButton) {
        navigator.enableBackmoveNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
}
