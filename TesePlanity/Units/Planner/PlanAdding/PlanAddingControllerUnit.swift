//
//  PlanAddingControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

class PlanAddingControllerUnit: UIViewController {
    
    @IBOutlet weak var planAddingCollectionView: UICollectionView!
    @IBOutlet weak var topPlan: UILabel!
    @IBOutlet weak var picturePlan: UILabel!
    @IBOutlet weak var describePlan: UILabel!
    @IBOutlet weak var fullInfoPlan: UILabel!
    @IBOutlet weak var sumOfPlan: UILabel!
    @IBOutlet weak var finishAddingPlanButton: UIButton!
    @IBOutlet weak var closingPlanButton: UIButton!
    @IBOutlet weak var planDate: UILabel!
    
    @IBOutlet weak var titlePlanTextField: UITextField!
    @IBOutlet weak var describePlanTextField: UITextField!
    @IBOutlet weak var sumPlanTextField: UITextField!
    @IBOutlet weak var planDateTextField: UITextField!
    @IBOutlet weak var planColView: UIView!
    @IBOutlet var planAddingViews: [UIView]!
    
    @IBOutlet weak var typePlanView: UIView!
    @IBOutlet weak var planTypePicture: UIImageView!
    @IBOutlet weak var typeExtraView: UIView!
    
    private var navigator: PlanAddingNavigator = PlanAddingNavigator()
    private var builder: PlanAddingBuilder = PlanAddingBuilder()
    private var handledPlanPicture = UIImage(named: "teseFood")!
    private var selectedIndexPath: IndexPath?
    
    var planState: Bool = false
    var typeOfPlan: String?
    var pictureOfTypePlan: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        verifyPlanState()
        setPlanAddingConfiguration()
    }
    
    private func setPlanAddingConfiguration() {
        builder.createPlanAddingCollectionView(planAddingCollectionView, self, "PlanAddingCell", "planAddingCellIdentifier")
        builder.initializePlanAddingUnitUI(topPlan, closingPlanButton, picturePlan, describePlan, fullInfoPlan, sumOfPlan, planDate, finishAddingPlanButton)
        builder.setAddingPlanTextFields(titlePlanTextField, describePlanTextField, sumPlanTextField, self)
        builder.setUpViews(planAddingViews, planColView)
        
        setUpCustomDatePicker(planDateTextField)
        setCustomGesture()
    }
    
    @objc func genPickerValueChanged(_ sender: UIDatePicker) {
        builder.configureCustomDateFormat(sender.date, planDateTextField)
    }
    
    @objc func resignFirstResponderFromPlanAdding() {
        view.endEditing(true)
    }
    
    @IBAction func finishAddingPlanHandle(_ sender: UIButton) {
        if titlePlanTextField.text!.isEmpty || describePlanTextField.text!.isEmpty || sumPlanTextField.text!.isEmpty {
            
        } else {
            builder.finishAddingNewUnitPlan(unitPicture: handledPlanPicture.pngData(), unitTitle: titlePlanTextField.text ?? "", unitInform: describePlanTextField.text ?? "", unitDate: planDateTextField.text ?? "", unitSum: sumPlanTextField.text ?? "") { (finishedUnitPlan) in
                self.navigator.enableClosingNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .flipHorizontal)
            }
        }
    }
    
    @IBAction func closingPlanHandle(_ sender: UIButton) {
        navigator.enableClosingNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .flipHorizontal)
    }
}

extension PlanAddingControllerUnit: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fullTypePlanObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let planAddingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "planAddingCellIdentifier", for: indexPath) as! PlanAddingCell
        
        let planAddingData = fullTypePlanObjects[indexPath.row]
        
        planAddingCell.setPlanAddingConfiguration(planAddingData.typePlanPicture)
        
        return planAddingCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if let previousSelectedIndexPath = selectedIndexPath {
            collectionView.deselectItem(at: previousSelectedIndexPath, animated: true)
            
            if let cell = collectionView.cellForItem(at: previousSelectedIndexPath) as? PlanAddingCell {
                cell.planAddingView.layer.borderWidth = 0
                cell.planAddingView.layer.cornerRadius = cell.planAddingView.frame.height / 2
            }
        }
        
        let planAddingData = fullTypePlanObjects[indexPath.row]
        
        handledPlanPicture = planAddingData.typePlanPicture
        
        selectedIndexPath = indexPath
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
     
        if let cell = collectionView.cellForItem(at: indexPath) as? PlanAddingCell {
            cell.planAddingView.layer.borderWidth = 2.0
            cell.planAddingView.layer.borderColor = #colorLiteral(red: 0.02575353161, green: 0.02872331068, blue: 0.6562663913, alpha: 1)
            cell.planAddingView.layer.cornerRadius = 30.0
            cell.planAddingView.layer.masksToBounds = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PlanAddingCell {
            cell.planAddingView.layer.borderWidth = 0
            cell.planAddingView.layer.cornerRadius = cell.planAddingView.frame.height / 2
        }
    }
}

extension PlanAddingControllerUnit: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

private extension PlanAddingControllerUnit {
    private func setUpCustomDatePicker(_ textField: UITextField) {
        let customDatePicker = UIDatePicker()

        customDatePicker.datePickerMode = .date
        customDatePicker.preferredDatePickerStyle = .wheels
        customDatePicker.addTarget(self, action: #selector(genPickerValueChanged(_:)), for: .valueChanged)
        
        textField.inputView = customDatePicker
        
        let currentDate = Date(timeIntervalSinceReferenceDate: 0)
        builder.configureCustomDateFormat(currentDate, textField)
    }
    
    private func setCustomGesture() {
        let resignResponderGesture = UITapGestureRecognizer(target: self, action: #selector(resignFirstResponderFromPlanAdding))
        view.addGestureRecognizer(resignResponderGesture)
        resignResponderGesture.cancelsTouchesInView = false
    }
    
    private func verifyPlanState() {
        if planState {
            planColView.backgroundColor = .clear
            typeExtraView.isHidden = false
            typeExtraView.layer.cornerRadius = 10
            planAddingCollectionView.isHidden = true
            typePlanView.isHidden = false
            planTypePicture.isHidden = false
            
            handledPlanPicture = pictureOfTypePlan!
            builder.setTypeOfPlanState(typePlanView, pictureOfTypePlan!, planTypePicture, titlePlanTextField, typeOfPlan ?? "")
        } else {
            typeExtraView.isHidden = true
            planAddingCollectionView.isHidden = false
            typePlanView.isHidden = true
            planTypePicture.isHidden = true
        }
    }
}
