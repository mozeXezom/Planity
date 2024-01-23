//
//  FirebasePropertiesService.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 22.01.2024.
//

import UIKit
import Firebase
import FirebaseAnalytics
import Foundation

enum FirebaseAnalyticsFilteredStatus {
    case info(URL?)
    case analyticsError
    case typeAnalytics
}

final class FirebasePropertiesService: NSObject, URLSessionTaskDelegate {
    static let shared = FirebasePropertiesService()
    
    private var firebaseState = FirebaseApp.app()
    private var filteredFirebaseProperties: Bool = false
    private var firebaseRemoteServiceUrl: URL?
    private var type = "HEAD"
    
    private override init() {
        super.init()
    }
    
    private func setFirebaseFilteringPropertiesResponse(_ firebaseResponse: HTTPURLResponse?) {
        filteredFirebaseProperties = true
        firebaseRemoteServiceUrl = firebaseResponse?.url
    }

    func initializeFirebaseRemotePropertiesFilterState(_ firebaseUrl: URL, _ remoteFirebaseCompletion: @escaping ((firebaseStatus: Bool, firebaseServiceUrl: URL?, firebaseError: Error?)) -> Void) {
        let firebaseRemoteConfigurationSession = URLSessionConfiguration.default
        firebaseRemoteConfigurationSession.timeoutIntervalForRequest = 10

        let remoteSessionConfiguration = URLSession(configuration: firebaseRemoteConfigurationSession, delegate: self, delegateQueue: nil)
        var firebaseFetchRequest = URLRequest(url: firebaseUrl)
        firebaseFetchRequest.httpMethod = type

        let dataFirebaseTask = remoteSessionConfiguration.dataTask(with: firebaseFetchRequest) { [weak self] _, firebasePropertiesResponse, firebaseResponseError in
            guard let strongSelf = self else { return }

            DispatchQueue.main.async {
                if let firebaseError = firebaseResponseError {
                    remoteFirebaseCompletion((false, nil, firebaseError))
                    return
                }

                if let httpPropertiesResponse = firebasePropertiesResponse as? HTTPURLResponse,
                   (300...399).contains(httpPropertiesResponse.statusCode) {
                    strongSelf.setFirebaseFilteringPropertiesResponse(httpPropertiesResponse)
                    remoteFirebaseCompletion((true, strongSelf.firebaseRemoteServiceUrl, nil))
                } else {
                    remoteFirebaseCompletion((false, nil, nil))
                }
            }
        }
        dataFirebaseTask.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        setFirebaseFilteringPropertiesResponse(response)
        completionHandler(nil)
    }
}


