//
//  DirectoryControllerUnit.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 17.01.2024.
//

import UIKit

class DirectoryControllerUnit: UIViewController {
    
    @IBOutlet weak var topDirectoryView: UIView!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var planCollectionView: UICollectionView!
    @IBOutlet weak var typePlanCollectionView: UICollectionView!
    @IBOutlet weak var plannerMenuButton: UIButton!
    @IBOutlet weak var calendarPlanButton: UIButton!
    
    @IBOutlet weak var userPlans: UILabel!
    @IBOutlet weak var allPlansTypes: UILabel!
    @IBOutlet weak var plansStats: UILabel!
    @IBOutlet weak var userWelcomeNickname: UITextField!
    
    //Directory statistics
    @IBOutlet weak var statisticsDirectoryView: UIView!
    @IBOutlet weak var previewStatistics: UIImageView!
    @IBOutlet weak var creationStats: UIImageView!
    @IBOutlet weak var creationStatsType: UILabel!
    @IBOutlet weak var doneStats: UIImageView!
    @IBOutlet weak var doneStatsType: UILabel!
    
    private var builder: DirectoryBuilder = DirectoryBuilder()
    private var navigator: DirectoryNavigator = DirectoryNavigator()
    private var monthDays: [DayMonthModel] = []
    private var handledUnitPlans: [UnitPlan] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setDirectoryUnitConfiguration()
        setDirectoriesCollectionViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToCurrentTrueDay()
    }
    
    private func setDirectoryUnitConfiguration() {
        builder.initializeShadowView(topDirectoryView)
        builder.drawDirectoryStatisticsView(statisticsDirectoryView, previewStatistics, greenStat: creationStats, creationStatsType, yellowStat: doneStats, doneStatsType)
        builder.initalizeDirectoryUI(calendarPlanButton, userPlans, allPlansTypes, plansStats, plannerMenuButton)
        builder.setWelcomeUserNicknameTextField(userWelcomeNickname, self)
        builder.filterDayMonthFromModel { (filteredDayMonth) in
            self.monthDays = filteredDayMonth
        }
        
        loadFetchedUnitPlans()
    }
    
    private func setDirectoriesCollectionViews() {
        builder.createCustomDirectoryCollectionView(monthCollectionView, self, "MonthCell", "monthCellIdentifier")
        builder.createCustomDirectoryCollectionView(planCollectionView, self, "PlanCell", "planCellIdentifier")
        builder.createCustomDirectoryCollectionView(planCollectionView, self, "EmptyPlanCell", "emptyPlanCellIdentifier")
        builder.createCustomDirectoryCollectionView(typePlanCollectionView, self, "TypePlanCell", "typePlanCellIdentifier")
    }
    
    private func indexPathForToday() -> IndexPath? {
        let today = Calendar.current.component(.day, from: Date())
        guard let index = monthDays.firstIndex(where: { $0.daysInMonth == today }) else {
            return nil
        }
        return IndexPath(item: index, section: 0)
    }
    
    private func scrollToCurrentTrueDay() {
        if let todayIndexPath = indexPathForToday() {
            monthCollectionView.scrollToItem(at: todayIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    @IBAction func directoryStatsHandle(_ sender: UIButton) {
        
    }
    
    @IBAction func plannerMenuHandle(_ sender: UIButton) {
        navigator.enableNavigationToPlannerMenuControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
    
    @IBAction func calendarPlanHundle(_ sender: UIButton) {
        navigator.enableNavigationToCalendarPlanControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
    }
}

extension DirectoryControllerUnit: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == monthCollectionView {
            return monthDays.count
        } else if collectionView == planCollectionView {
            if section == 0 {
                // Section 0 should have only one item (EmptyPlanCell)
                return 1
            } else if section == 1 {
                // Section 1 should have the count of handledUnitPlans
                return handledUnitPlans.count
            }
        } else if collectionView == typePlanCollectionView {
            return fullTypePlanObjects.count
        }
        
        return 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == monthCollectionView {
            return 1
        } else if collectionView == planCollectionView {
            return 2
        } else if collectionView == typePlanCollectionView {
            return 1
        }
        
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == monthCollectionView {
            guard let monthCell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCellIdentifier", for: indexPath) as? MonthCell else {
                return UICollectionViewCell()
            }
            let dayMonthData = monthDays[indexPath.row]
            monthCell.setMonthCellConfiguration(dayMonthData)
            
            return monthCell
            
        } else if collectionView == planCollectionView {
            if indexPath.section == 0 {
                guard let emptyPlanCell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyPlanCellIdentifier", for: indexPath) as? EmptyPlanCell else {
                    return UICollectionViewCell()
                }
                
                emptyPlanCell.setEmptyPlanCellConfiguration(UIImage(named: "newPlan")!, "Dodaj plan")
                
                return emptyPlanCell
            } else if indexPath.section == 1 {

                guard let planCell = collectionView.dequeueReusableCell(withReuseIdentifier: "planCellIdentifier", for: indexPath) as? PlanCell else {
                    return UICollectionViewCell()
                }
                
                let fetchedPlanData = handledUnitPlans[indexPath.row]
                let fetchedPicture = UIImage(data: fetchedPlanData.unitPlanPicture!)
                
                planCell.setPlanCellConfiguration(fetchedPicture!, fetchedPlanData.unitPlanTitle ?? "", fetchedPlanData.unitDate ?? "")
                
                return planCell
            }
        } else if collectionView == typePlanCollectionView {
            guard let typePlanCell = collectionView.dequeueReusableCell(withReuseIdentifier: "typePlanCellIdentifier", for: indexPath) as? TypePlanCell else {
                return UICollectionViewCell()
            }
            
            let allTypeOfPlanObjects = fullTypePlanObjects[indexPath.row]
            
            typePlanCell.setTypePlanCellConfiguration(allTypeOfPlanObjects.planTypeTitle, allTypeOfPlanObjects.typePlanPicture)
            
            return typePlanCell
        }
        
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == planCollectionView {
            if indexPath.section == 0 {
                navigator.enableNavigationToPlanAddingControllerUnit(self, unitPresentation: .fullScreen, unitTransition: .flipHorizontal)
            } else if indexPath.section == 1 {
                let sendPlanData = handledUnitPlans[indexPath.row]
                let sendPlanPicture = UIImage(data: sendPlanData.unitPlanPicture!)
                
                navigator.enableNavigationToExploringPlansControllerUnit(sendPlanData.unitPlanTitle ?? "", sendPlanData.unitPlanInform ?? "", sendPlanPicture!, sendPlanData.unitSum ?? "", sendPlanData, self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
            }
        } else if collectionView == typePlanCollectionView {
            let planObjectsType = fullTypePlanObjects[indexPath.row]
            
            navigator.enableNavigationToPlanAddingControllerUnitWithPlanTypeInfo(true, planObjectsType.planTypeTitle, planObjectsType.typePlanPicture, self, unitPresentation: .fullScreen, unitTransition: .crossDissolve)
        }
    }
}

extension DirectoryControllerUnit: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let planNicknameToSave = textField.text {
            UserDefaults.standard.set(planNicknameToSave, forKey: "planUserNickname")
        }
    }
}

private extension DirectoryControllerUnit {
    private func loadFetchedUnitPlans() {
        builder.fetchUnitPlansFromStorage { (unitPlans) in
            if unitPlans.isEmpty {
                print("No unit plans")
            } else {
                self.handledUnitPlans = unitPlans
                self.planCollectionView.reloadData()
            }
        }
    }
}
