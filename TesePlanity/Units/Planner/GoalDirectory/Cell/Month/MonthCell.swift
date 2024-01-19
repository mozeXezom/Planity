//
//  MonthCell.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

class MonthCell: UICollectionViewCell {

    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var dayTitle: UILabel!
    @IBOutlet weak var numberDay: UILabel!
    
    func setMonthCellConfiguration(_ monthDay: DayMonthModel) {
        numberDay.text = "\(monthDay.daysInMonth)"
        dayTitle.text = monthDay.dayName
        
        if monthDay.currentTrueDay {
            monthView.layer.cornerRadius = 20
            monthView.backgroundColor = #colorLiteral(red: 0.09586340934, green: 0.5055510998, blue: 1, alpha: 1)
        } else {
            monthView.backgroundColor = .clear
        }
    }
}
