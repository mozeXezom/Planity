//
//  CalendarPlanControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 20.01.2024.
//

import UIKit

class CalendarPlanControllerUnit: UIViewController {
    
    @IBOutlet weak var planCalendarView: UIView!
    
    private var builder: CalendarPlanBuilder = CalendarPlanBuilder()
    private var navigator: CalendarPlanNavigator = CalendarPlanNavigator()
    private let unitCalendarView = UICalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarPlanConfiguration()
    }
    
    private func setCalendarPlanConfiguration() {
        builder.createCustomCalendar(unitCalendarView, planCalendarView, self, "ru_RU")
    }
}
