//
//  PlanCell.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

class PlanCell: UICollectionViewCell {

    @IBOutlet weak var planView: UIView!
    @IBOutlet weak var picturePlanView: UIView!
    @IBOutlet weak var datePlan: UILabel!
    @IBOutlet weak var titlePlan: UILabel!
    @IBOutlet weak var picturePlan: UIImageView!
    
    func setPlanCellConfiguration(_ fetchedPicture: UIImage, _ fetchedTitle: String, _ fetchedDate: String) {
        planView.layer.cornerRadius = 10
        picturePlanView.layer.cornerRadius = picturePlanView.frame.height / 2
        picturePlan.image = fetchedPicture
        titlePlan.text = fetchedTitle
        datePlan.text = fetchedDate
    }
}
