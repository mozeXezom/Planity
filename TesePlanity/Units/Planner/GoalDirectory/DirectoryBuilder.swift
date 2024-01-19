//
//  DirectoryBuilder.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

final class DirectoryBuilder {
    func initializeShadowView(_ topView: UIView) {
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOffset = CGSize(width: 0, height: 5)
        topView.layer.shadowOpacity = 0.5
        topView.layer.shadowRadius = 5
        topView.layer.masksToBounds = false
    }
    
    func drawDirectoryStatisticsView(_ statisticsView: UIView, _ statsPreview: UIImageView, greenStat: UIImageView, _ greenType: UILabel, yellowStat: UIImageView, _ yellowType: UILabel) {
        statisticsView.layer.cornerRadius = 10
        statsPreview.image = UIImage(named: "directoryStatistics")!
        greenStat.image = UIImage(named: "oneGreen")!
        greenType.text = "Tworzenie celów"
        yellowStat.image = UIImage(named: "twoYellow")!
        yellowType.text = "Wykonanie"
    }
    
    func createCustomDirectoryCollectionView(_ collectionView: UICollectionView, _ currentUnitController: UIViewController, _ cellName: String, _ cellIdentifier: String) {
        collectionView.backgroundColor = .clear
        collectionView.delegate = currentUnitController.self as? UICollectionViewDelegate
        collectionView.dataSource = currentUnitController.self as? UICollectionViewDataSource
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func filterDayMonthFromModel(_ completion: @escaping ([DayMonthModel]) -> ()) {
        let filteredDayMonth = (1...31).map { day in
            
            let dayName = getMonthDayName(day)
            let currentTrueDay = day == fetchCurrentTrueDay()
            
            return DayMonthModel(daysInMonth: day, dayName: dayName, currentTrueDay: currentTrueDay)
        }
        
        completion(filteredDayMonth)
    }
    
    func fetchUnitPlansFromStorage(_ completion: @escaping ([UnitPlan]) -> ()) {
        let fetchedUnitPlans = StorageUnitService.sharedStorage.setUnitPlansFetching()
        completion(fetchedUnitPlans)
    }

    private func fetchCurrentTrueDay() -> Int {
        let currentTrueDate = Date()
        let fetchCalendar = Calendar.current
        return fetchCalendar.component(.day, from: currentTrueDate)
    }

    private func getMonthDayName(_ nameOfDay: Int) -> String {
        let monthDate = Date()
        let dayCalendar = Calendar.current
        let dateComponents = DateComponents(year: dayCalendar.component(.year, from: monthDate),
                                            month: dayCalendar.component(.month, from: monthDate),
                                            day: nameOfDay)
        if let date = dayCalendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
