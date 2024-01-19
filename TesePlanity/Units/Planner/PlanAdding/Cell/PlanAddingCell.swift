//
//  PlanAddingCell.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

class PlanAddingCell: UICollectionViewCell {

    @IBOutlet weak var planAddingView: UIView!
    @IBOutlet weak var pictureOfAdding: UIImageView!

    func setPlanAddingConfiguration(_ addingPicture: UIImage) {
        planAddingView.layer.cornerRadius = planAddingView.frame.height / 2
        pictureOfAdding.image = addingPicture
    }
    
    func applySelectionAppearance() {
        planAddingView.layer.borderWidth = 2.0
        planAddingView.layer.borderColor = UIColor.green.cgColor
        planAddingView.layer.cornerRadius = 30.0
        planAddingView.layer.masksToBounds = true
    }
    
    func resetAppearance() {
        planAddingView.layer.borderWidth = 0
        planAddingView.layer.cornerRadius = planAddingView.frame.height / 2
    }
}
