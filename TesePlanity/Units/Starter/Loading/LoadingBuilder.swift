//
//  LoadingBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

final class LoadingBuilder: NSObject {
    func initializeLoadingUnitUI(_ appLogo: UIImageView) {
        appLogo.image = UIImage(named: "planityLogo")!
    }
}
