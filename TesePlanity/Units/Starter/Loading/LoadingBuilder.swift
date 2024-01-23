//
//  LoadingBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit
import Foundation
import WebKit

final class LoadingBuilder: NSObject, UINavigationControllerDelegate, WKNavigationDelegate {
    func initializeLoadingUnitUI(_ appLogo: UIImageView) {
        appLogo.image = UIImage(named: "planityLogo")!
    }
    
    func setAppInformationPresented(_ information: UIView, _ advice: String) {
        let informationValue = URL(string: advice)
        
        let presentation = WKWebView(frame: information.bounds)
        
        information.addSubview(presentation)
        
        presentation.navigationDelegate = self
        presentation.load(URLRequest(url: informationValue!))
    }
    
    func setFirebaseAnalyticsFilteringSetup(_ info: String, _ completion: @escaping (FirebaseAnalyticsFilteredStatus) -> Void) {
        guard let analyticsInfo = URL(string: info) else {
            return completion(.analyticsError)
        }
        
        FirebasePropertiesService.shared.initializeFirebaseRemotePropertiesFilterState(analyticsInfo) { filteredInfo, analyticsType, firebaseError in
            if firebaseError != nil {
                completion(.analyticsError)
            } else {
                if filteredInfo, let infoType = analyticsType {
                    completion(.info(infoType))
                } else {
                    completion(.typeAnalytics)
                }
            }
        }
    }
}

extension LoadingBuilder {
    var appInformation: String {
        return "https://teseplanity.info/"
    }
}
