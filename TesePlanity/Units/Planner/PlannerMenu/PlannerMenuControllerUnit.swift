//
//  PlannerMenuControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

class PlannerMenuControllerUnit: UIViewController {
    
    @IBOutlet weak var directoryReturnButton: UIButton!
    
    private var navigator: PlannerMenuNavigator = PlannerMenuNavigator()
    private var builder: PlanAddingBuilder = PlanAddingBuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
        setPlannerMenuConfiguration()
    }
    
    private func setPlannerMenuConfiguration() {
        
    }
    
    @IBAction func directoryReturnHandle(_ sender: UIButton) {
        navigator.enableDirectoryReturnNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
}
