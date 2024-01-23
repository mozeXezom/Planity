//
//  ViewController.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 11.01.2024.
//

import UIKit
import Foundation
import Firebase

final class LoadingControllerUnit: UIViewController {

    @IBOutlet weak var loadingAppLogo: UIImageView!
    
    private var navigator: LoadingNavigator = LoadingNavigator()
    private var builder: LoadingBuilder = LoadingBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingUnitConfiguration()
    }
    
    private func setLoadingUnitConfiguration() {
        builder.initializeLoadingUnitUI(loadingAppLogo)
        configureFirebaseAnalyticsState()
    }
    
    private func configureFirebaseAnalyticsState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.builder.setFirebaseAnalyticsFilteringSetup(self.builder.appInformation) { analytics in
                switch analytics {
                case .typeAnalytics, .analyticsError:
                    self.navigator.enableNavigationToStartGuideControllerUnit(self, unitTransition: .flipHorizontal, unitPresentation: .fullScreen)
                case .info(let information):
                    self.builder.setAppInformationPresented(self.view, self.builder.appInformation)
                }
            }
        }
    }
}

