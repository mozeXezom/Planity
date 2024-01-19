//
//  PlanAddingBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

final class PlanAddingBuilder {
    func createPlanAddingCollectionView(_ collectionView: UICollectionView, _ currentUnitController: PlanAddingControllerUnit, _ cellName: String, _ cellIdentifier: String) {
        collectionView.backgroundColor = .clear
        collectionView.delegate = currentUnitController
        collectionView.dataSource = currentUnitController
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func initializePlanAddingUnitUI(_ planTitle: UILabel, _ closingButton: UIButton, _ planPicture: UILabel, _ titlePlan: UILabel, _ describePlan: UILabel, _ sumOfPlan: UILabel, _ datePlan: UILabel, _ addingButton: UIButton) {
        planTitle.text = "Tworzenie celów"
        closingButton.setImage(UIImage(named: "teseClosing")!, for: .normal)
        planPicture.text = "Ikona:"
        titlePlan.text = "Tytuł:"
        describePlan.text = "Opis:"
        sumOfPlan.text = "Kwota:"
        datePlan.text = "Dni do ukończenia:"
        addingButton.setTitle("Tworzenie planu", for: .normal)
    }
    
    func setAddingPlanTextFields(_ titleField: UITextField, _ describeField: UITextField, _ sumField: UITextField, _ currentUnitController: UIViewController) {
        titleField.delegate = currentUnitController.self as? UITextFieldDelegate
        describeField.delegate = currentUnitController.self as? UITextFieldDelegate
        sumField.delegate = currentUnitController.self as? UITextFieldDelegate
        
        titleField.attributedPlaceholder = NSAttributedString(
            string: "Stwórz plan na...",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4482307434, green: 0.5601338744, blue: 0.70691365, alpha: 1)]
        )
        describeField.attributedPlaceholder = NSAttributedString(
            string: "Opis Twojego planu",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4482307434, green: 0.5601338744, blue: 0.70691365, alpha: 1)]
        )
        sumField.attributedPlaceholder = NSAttributedString(
            string: "$ 0",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4482307434, green: 0.5601338744, blue: 0.70691365, alpha: 1)]
        )
    }
    
    func setUpViews(_ planViews: [UIView], _ colView: UIView) {
        colView.layer.cornerRadius = 10
        for planView in planViews {
            planView.layer.cornerRadius = 20
        }
    }
    
    func configureCustomDateFormat(_ handledDate: Date, _ textField: UITextField) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d.MM.yyyy"
        textField.text = dateFormatter.string(from: handledDate)
    }
    
    func setTypeOfPlanState(_ typeView: UIView, _ typePicture: UIImage, _ typeImageView: UIImageView, _ typeTextField: UITextField, _ planOfType: String) {
        typeView.layer.cornerRadius = typeView.layer.frame.height / 2
        typeImageView.image = typePicture
        typeTextField.text = planOfType
    }
    
    func finishAddingNewUnitPlan(unitPicture: Data?, unitTitle: String, unitInform: String, unitDate: String, unitSum: String, _ completion: @escaping (UnitPlan) -> ()) {
        let newUnitPlan = StorageUnitService.sharedStorage.setUpNewUnitPlan(unitPicture, unitTitle, unitInform, unitDate, unitSum)
        StorageUnitService.sharedStorage.setSaveStorageUnitMethod()
        completion(newUnitPlan)
    }
}
