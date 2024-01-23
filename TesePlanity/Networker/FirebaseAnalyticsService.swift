//
//  FirebaseAnalyticsService.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 22.01.2024.
//

import UIKit
import Foundation
import FirebaseRemoteConfig
import FirebaseAnalytics
import FBSDKCoreKit

final class FirebaseAnalyticsService {
    static let shared = FirebaseAnalyticsService()
    private let analyticsRemoteConfiguration = RemoteConfig.remoteConfig()
    private let settingsOfFacebookSDK = Settings.shared
    private var firebaseAnalyticsRemoteProperties: [String: String]?

    private init() { }

    func setFirebaseAnalyticsServiceRemoteConfiguration(_ completion: @escaping (Result<[String: String], Error>) -> Void) {
        initalizeFirebasePropertiesFromRemoteStorage()
        
        setRemoteFirebaseFetchingStateWithProperties { [weak self] (firebaseResult) in
            guard let self = self else { return }
            switch firebaseResult {
            case .success(let fetchedFirebaseAnalyticsValues):
                self.firebaseAnalyticsRemoteProperties = fetchedFirebaseAnalyticsValues
                completion(.success(fetchedFirebaseAnalyticsValues))
            case .failure(let analyticsError):
                completion(.failure(analyticsError))
            }
        }
    }

    private func initalizeFirebasePropertiesFromRemoteStorage() {
        let propertiesFromRemoteStorage: [String: String] = [
            "appId": "",
            "clientToken": "",
            "displayName": ""
        ]
        analyticsRemoteConfiguration.configSettings.minimumFetchInterval = 9
        analyticsRemoteConfiguration.setDefaults(propertiesFromRemoteStorage as [String: NSObject])
        
        settingsOfFacebookSDK.isAdvertiserIDCollectionEnabled = true
        settingsOfFacebookSDK.isAutoLogAppEventsEnabled = true
        Settings.initialize()
    }

    private func setRemoteFirebaseFetchingStateWithProperties(_ completion: @escaping (Result<[String: String], Error>) -> Void) {
        analyticsRemoteConfiguration.fetchAndActivate { [weak self] (remoteStatus, remoteError) in
            guard let self = self else { return }
            if let configurationError = remoteError {
                completion(.failure(configurationError))
            } else if remoteStatus == .error {
                completion(.failure(NSError(domain: "RemoteFetchError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Remote fetching error"])))
            } else {
                let dictionaryFetchedValues: [String: String] = [
                    "appId": self.analyticsRemoteConfiguration.configValue(forKey: "appId").stringValue ?? "appId",
                    "clientToken": self.analyticsRemoteConfiguration.configValue(forKey: "clientToken").stringValue ?? "clientToken",
                    "displayName": self.analyticsRemoteConfiguration.configValue(forKey: "displayName").stringValue ?? "displayName"
                ]
                completion(.success(dictionaryFetchedValues))
            }
        }
    }
}
