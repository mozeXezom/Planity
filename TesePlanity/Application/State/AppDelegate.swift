//
//  AppDelegate.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 11.01.2024.
//

import UIKit
import Foundation
import AppTrackingTransparency
import IQKeyboardManagerSwift
import OneSignalFramework
import Firebase
import FirebaseCore
import FirebaseAnalytics
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        OneSignal.initialize("7797f71a-0c86-4be4-9a86-cf1f60de1152", withLaunchOptions: launchOptions)
        
        setFacebookSharedConfiguration(with: application)
        setAppLaunchingConfigurationSetup()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.addObserver(self, selector: #selector(setApplicationBecomeActiveObservableState), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc private func setApplicationBecomeActiveObservableState() {
        openUserAppTrackingAuthorizationStatusRequest { (authorizationStatus) in
            print("Authorization status is: \(authorizationStatus)")
        }
    }
}

private extension AppDelegate {
    private func setAppLaunchingConfigurationSetup() {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            FirebaseAnalyticsService.shared.setFirebaseAnalyticsServiceRemoteConfiguration { (_) in
                FirebaseApp.debugDescription()
            }
        }
    }
    
    private func setFacebookSharedConfiguration(with application: UIApplication) {
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: nil
        )
    }
    
    private func openUserAppTrackingAuthorizationStatusRequest(_ completion: @escaping (Bool) -> ()) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (_) in
                OneSignal.Notifications.requestPermission({ (authorizedRequestPermission) in
                    print("Notification authorization request status is: \(authorizedRequestPermission)")
                    completion(authorizedRequestPermission)
                }, fallbackToSettings: false)
                completion(true)
            }
        }
    }
}


