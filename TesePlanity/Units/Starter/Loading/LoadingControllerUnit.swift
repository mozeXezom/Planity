//
//  ViewController.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 11.01.2024.
//

import UIKit

class LoadingControllerUnit: UIViewController {

    @IBOutlet weak var loadingAppLogo: UIImageView!
    
    private var navigator: LoadingNavigator = LoadingNavigator()
    private var builder: LoadingBuilder = LoadingBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingUnitConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigator.enableNavigationToStartGuideControllerUnit(self, unitTransition: .crossDissolve, unitPresentation: .fullScreen)
        }
    }
    
    private func setLoadingUnitConfiguration() {
        builder.initializeLoadingUnitUI(loadingAppLogo)
    }
}

