//
//  EmptyPlanCell.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

class EmptyPlanCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyPlanPicture: UIImageView!
    @IBOutlet weak var planEmpty: UILabel!
    @IBOutlet weak var emptyPlanView: UIView!
    
    func setEmptyPlanCellConfiguration(_ emptyPicture: UIImage, _ titleEmpty: String) {
        emptyPlanPicture.image = emptyPicture
        planEmpty.text = titleEmpty
        emptyPlanView.layer.cornerRadius = 10
    }
}
