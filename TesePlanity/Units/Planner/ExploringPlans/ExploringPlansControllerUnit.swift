//
//  ExploringPlansUnitController.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 19.01.2024.
//

import UIKit

class ExploringPlansControllerUnit: UIViewController {
    
    @IBOutlet weak var backmoveButton: UIButton!
    @IBOutlet weak var exploringView: UIView!
    @IBOutlet weak var explorePicture: UIImageView!
    @IBOutlet weak var planNameExplore: UILabel!
    @IBOutlet weak var fullPlanInfo: UITextView!
    @IBOutlet weak var savedSumPlan: UILabel!
    @IBOutlet var exploringNaviteViews: [UIView]!
    @IBOutlet weak var sumExploreView: UIView!
    @IBOutlet weak var titleOfExploringPlan: UILabel!
    @IBOutlet weak var dltPlanButton: UIButton!
    
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var collectibleInfo: UILabel!
    @IBOutlet weak var partInfo: UILabel!
    @IBOutlet weak var planSumAddButton: UIButton!
    @IBOutlet weak var sumPlanTextField: UITextField!
    @IBOutlet weak var totalPlanSum: UILabel!
    @IBOutlet weak var sumView: UIView!
    @IBOutlet weak var planSumProgressView: UIProgressView!
    
    private var builder: ExploringPlansBuilder = ExploringPlansBuilder()
    private var navigator: ExploringPlansNavigator = ExploringPlansNavigator()
    private var exploringTotalSum = 0
    
    var handledPlanTitle: String?
    var handledPlanInformation: String?
    var handledPlanPicture: UIImage?
    var handledPlanSum: String?
    var handledUnitPlan: UnitPlan?

    override func viewDidLoad() {
        super.viewDidLoad()
        setExploringPlansConfiguration()
    }
    
    private func setExploringPlansConfiguration() {
        builder.setSelectedExploredPlanData(exploringView, explorePicture, handledPlanPicture!, planNameExplore, fullPlanInfo, savedSumPlan, title: handledPlanTitle ?? "", info: handledPlanInformation ?? "", sum: handledPlanSum ?? "")
        builder.initalizeExploringPlansUI(backmoveButton, titleOfExploringPlan, dltPlanButton, exploringViews: exploringNaviteViews, sumView: sumExploreView, totalSum: totalPlanSum, addingSumView: sumView)
        builder.setAdditionalExploringElements(infoTitle, collectibleInfo, partInfo, planSumAddButton, sumPlanTextField, self)
        
        planSumProgressView.progress = 0
    }
    
    @IBAction func backmoveHandle(_ sender: UIButton) {
        navigator.enableBackmoveNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
    
    @IBAction func dltPlanHandle(_ sender: UIButton) {
        setExploringControllerUnitAlert("Drogi Użytkowniku!", unitMessage: "Czy na pewno chcesz usunąć wybrany plan?", trueMessage: "Tak, usuń wybrany plan.", true) {
            self.builder.deleteSelectedExplorePlanFromStorageUnit(self.handledUnitPlan!) {
                self.navigator.enableBackmoveNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
            }
            print("Selected plan deleted successfully!")
        } _: {
            print("Delete plan action cancelled!")
        }
    }
    
    @IBAction func planSumAddHandle(_ sender: UIButton) {
        updateHandledPlanSum(totalPlanSum, sumPlanTextField)
    }
}

extension ExploringPlansControllerUnit: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

private extension ExploringPlansControllerUnit {
    private func updateHandledPlanSum(_ sumLbl: UILabel, _ sumTxtFld: UITextField) {
        if let enteredPlanSum = Int(sumTxtFld.text ?? "") {
            exploringTotalSum += enteredPlanSum

            if let handledSumString = handledPlanSum, let handledSumDouble = Double(handledSumString) {
                exploringTotalSum = min(exploringTotalSum, Int(handledSumDouble))
                
                sumLbl.text = "$ \(exploringTotalSum)"
                
                let progressRatio = Float(exploringTotalSum) / Float(handledSumDouble)
                planSumProgressView.progress = progressRatio
            } else {
                setExploringControllerUnitAlert("Oh!", unitMessage: "Nieprawidłowa wpisana suma. Sprawdź wartość.", trueMessage: "Ok, rozumiem!", false) {
                    print("trueAction!")
                } _: {
                    print("no false action!")
                }
            }
        } else {
            setExploringControllerUnitAlert("Oh!", unitMessage: "Nieprawidłowe dane wejściowe. Proszę wprowadzić prawidłową kwotę.", trueMessage: "Ok, rozumiem!", false) {
                print("trueAction active!")
            } _: {
                print("no false action presented!")
            }
        }
    }
    
    private func setExploringControllerUnitAlert(
        _ unitAlertTitle: String?,
        unitMessage: String?,
        trueMessage: String?,
        _ showFalseAction: Bool = true,
        _ exploringTrueCompletion: (() -> Void)? = nil,
        _ falseExploringCompletion: (() -> Void)? = nil
    ) {
        let controllerUnitAlert = UIAlertController(title: unitAlertTitle, message: unitMessage, preferredStyle: .alert)
        
        let trueAction = UIAlertAction(title: trueMessage, style: .default) { _ in
            exploringTrueCompletion?()
        }
        
        controllerUnitAlert.addAction(trueAction)
        
        if showFalseAction {
            let falseAction = UIAlertAction(title: "Anuluj akcję", style: .cancel) { _ in
                falseExploringCompletion?()
            }
            controllerUnitAlert.addAction(falseAction)
        }
        
        present(controllerUnitAlert, animated: true, completion: nil)
    }
}
