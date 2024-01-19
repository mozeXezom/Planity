//
//  StartGuideBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

final class StartGuideBuilder {
    func initializeStartGuideUnitUI(_ guidePreview: UIImageView,  _ adviceGuide: UILabel, _ guideInformation: UILabel, _ navButton: UIButton) {
        guidePreview.image = UIImage(named: "startGuideLogo")!
        adviceGuide.text = "Śledź plany na następny rok"
        guideInformation.text = "Ustal terminy realizacji zadań, aby poprawić swoją organizację."
        navButton.layer.cornerRadius = 20
        navButton.setTitle("Zacznij planować!", for: .normal)
    }
}
