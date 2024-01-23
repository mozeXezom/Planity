//
//  CalendarPlanControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

class CalendarPlanControllerUnit: UIViewController {
    
    @IBOutlet weak var planCalendarView: UIView!
    @IBOutlet weak var turnOutButton: UIButton!
    @IBOutlet weak var calendarPlanTextView: UITextView!
    @IBOutlet weak var infoCalendarSaveButton: UIButton!
    @IBOutlet weak var titleOfPlanCalendar: UILabel!
    
    @IBOutlet weak var calendarInfoView: UIView!
    
    private var builder: CalendarPlanBuilder = CalendarPlanBuilder()
    private var navigator: CalendarPlanNavigator = CalendarPlanNavigator()
    private let unitCalendarView = UICalendarView()
    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarPlanConfiguration()
    }
    
    private func setCalendarPlanConfiguration() {
        builder.createCustomCalendar(unitCalendarView, planCalendarView, self, "pl_PL")
        builder.setCalendarPlanUI(turnOutButton, titleOfPlanCalendar, calendarPlanTextView, infoCalendarSaveButton, calendarInfoView, self)
        builder.updateCalendarTextView(calendarPlanTextView)
    }
    
    @IBAction func turnOutHandle(_ sender: UIButton) {
        navigator.enableTurnOutNavigationToDirectoryControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
    
    @IBAction func infoCalendarSaveHandle(_ sender: UIButton) {
        if calendarPlanTextView.text.isEmpty || calendarPlanTextView.text == builder.calendarPlaceHolder {
            setCalendarPlanControllerUnitAlert("Uwaga!", "Aby zapisać informację o Twoich planach musisz wypełnić powyższe pole!", "Cienki")
        } else {
            setCalendarPlanControllerUnitAlert("Świetnie!", "Informacje o Twoich planach kalendarza zostały zapisane.", "Ok")
            userDefaults.setValue(calendarPlanTextView.text, forKey: "calendarPlanInfo")
        }
    }
}

extension CalendarPlanControllerUnit: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == builder.calendarPlaceHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = builder.calendarPlaceHolder
            textView.textColor = #colorLiteral(red: 0.4482307434, green: 0.5601338744, blue: 0.70691365, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

private extension CalendarPlanControllerUnit {
    private func setCalendarPlanControllerUnitAlert(
        _ unitAlertTitle: String?,
        _ unitMessage: String?,
        _ confirmMessage: String?,
        _ exploringTrueCompletion: (() -> Void)? = nil
    ) {
        let controllerUnitAlert = UIAlertController(title: unitAlertTitle, message: unitMessage, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmMessage, style: .default) { _ in
            exploringTrueCompletion?()
        }
        
        controllerUnitAlert.addAction(confirmAction)
 
        present(controllerUnitAlert, animated: true, completion: nil)
    }
}
