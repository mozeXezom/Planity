//
//  StartGuideControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 16.01.2024.
//

import UIKit

class StartGuideControllerUnit: UIViewController {
    
    @IBOutlet weak var guideNavButton: UIButton!
    @IBOutlet weak var startGuidePreview: UIImageView!
    @IBOutlet weak var guideUnitInformation: UILabel!
    @IBOutlet weak var adviceUnitGuide: UILabel!
    
    private var navigator: StartGuideNavigator = StartGuideNavigator()
    private var builder: StartGuideBuilder = StartGuideBuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
        setStartGuideUnitConfiguration()
    }
    
    private func setStartGuideUnitConfiguration() {
        builder.initializeStartGuideUnitUI(startGuidePreview, adviceUnitGuide, guideUnitInformation, guideNavButton)
    }
    
    @IBAction func guideNavHandle(_ sender: UIButton) {
        navigator.enableNavigationToStartGuideControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
}
