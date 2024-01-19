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
}
