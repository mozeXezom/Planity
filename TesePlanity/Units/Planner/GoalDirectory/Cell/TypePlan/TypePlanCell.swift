//
//  TypePlanCell.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

class TypePlanCell: UICollectionViewCell {

    @IBOutlet weak var typePlanView: UIView!
    @IBOutlet weak var typePlanTitle: UILabel!
    @IBOutlet weak var typePicture: UIImageView!
    
    func setTypePlanCellConfiguration(_ typePlan: String, _ planPicture: UIImage) {
        typePlanView.layer.cornerRadius = typePlanView.frame.height / 2
        typePlanTitle.text = typePlan
        typePicture.image = planPicture
    }
}
