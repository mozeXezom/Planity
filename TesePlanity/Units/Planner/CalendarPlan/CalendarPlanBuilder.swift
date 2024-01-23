//
//  CalendarPlanBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

final class CalendarPlanBuilder {
    func createCustomCalendar(_ planCalendarView: UICalendarView, _ handleCalendarView: UIView, _ currentUnitController: CalendarPlanControllerUnit, _ calendarIdentifier: String) {
        
        handleCalendarView.layer.cornerRadius = 20
        
        let planGregorianCalendar = Calendar(identifier: .gregorian)
        
        planCalendarView.calendar = planGregorianCalendar
        planCalendarView.locale = Locale(identifier: calendarIdentifier)
        planCalendarView.fontDesign = .rounded
        planCalendarView.translatesAutoresizingMaskIntoConstraints = false
        handleCalendarView.addSubview(planCalendarView)

        NSLayoutConstraint.activate([
            planCalendarView.leadingAnchor.constraint(equalTo: handleCalendarView.leadingAnchor),
            planCalendarView.trailingAnchor.constraint(equalTo: handleCalendarView.trailingAnchor),
            planCalendarView.topAnchor.constraint(equalTo: handleCalendarView.topAnchor),
            planCalendarView.bottomAnchor.constraint(equalTo: handleCalendarView.bottomAnchor),
        ])

        planCalendarView.tintColor = UIColor.systemTeal
        planCalendarView.backgroundColor = .clear

        planCalendarView.availableDateRange = DateInterval(start: Date.now, end: Date.distantFuture)
        
        let multiDatePlanSelection = UICalendarSelectionMultiDate(delegate: currentUnitController as? UICalendarSelectionMultiDateDelegate)
        planCalendarView.selectionBehavior = multiDatePlanSelection
    }
    
    func setCalendarPlanUI(_ forwardButton: UIButton, _ calendarTitle: UILabel, _ textViewCalendar: UITextView, _ saveButton: UIButton, _ calendarInfo: UIView, _ currentController: UIViewController) {
        forwardButton.setImage(UIImage(named: "teseClosing")!, for: .normal)
        calendarTitle.text = "Cele kalendarza"
        textViewCalendar.delegate = currentController.self as? UITextViewDelegate
        saveButton.setTitle("Zapisz informacje", for: .normal)
        saveButton.layer.cornerRadius = 20
        calendarInfo.layer.cornerRadius = 20
    }
    
    func updateCalendarTextView(_ calendarTextView: UITextView) {
        if UserDefaults.standard.value(forKey: "calendarPlanInfo") != nil {
            calendarTextView.text = "\(UserDefaults.standard.value(forKey: "calendarPlanInfo") ?? calendarPlaceHolder)"
        } else {
            calendarTextView.text = calendarPlaceHolder
        }
    }
}

extension CalendarPlanBuilder {
    var calendarPlaceHolder: String {
        return "Tutaj możesz wskazać swoje plany na przyszłe terminy lub zapisać ważne informacje. Planuj mądrze swoje zadania i cele! Zastanów się, jakie kroki możesz podjąć, aby osiągnąć swoje cele w ustalonym czasie. Tworzenie realistycznych planów pomoże Ci skuteczniej dążyć do sukcesu. Ustal priorytety w swoich planach, abyś mógł skoncentrować się na najważniejszych zadaniach."
    }
}
