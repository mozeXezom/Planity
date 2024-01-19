//
//  TypePlanModel.swift
//  TesePlanity
//
//  Created by Yurii Derzhylo on 18.01.2024.
//

import UIKit

struct TypePlanModel {
    let planTypeTitle: String
    let typePlanPicture: UIImage
}

var fullTypePlanObjects = [
    TypePlanModel(planTypeTitle: "Żywność", typePlanPicture: UIImage(named: "teseFood")!),
    TypePlanModel(planTypeTitle: "Kawa", typePlanPicture: UIImage(named: "teseCofe")!),
    TypePlanModel(planTypeTitle: "Samochód", typePlanPicture: UIImage(named: "teseCar")!),
    TypePlanModel(planTypeTitle: "Książki", typePlanPicture: UIImage(named: "teseBooks")!),
    TypePlanModel(planTypeTitle: "Rower", typePlanPicture: UIImage(named: "teseBicycle")!),
    TypePlanModel(planTypeTitle: "Komputer", typePlanPicture: UIImage(named: "teseComputer")!),
    
    TypePlanModel(planTypeTitle: "Owoce", typePlanPicture: UIImage(named: "teseFruit")!),
    TypePlanModel(planTypeTitle: "Meble", typePlanPicture: UIImage(named: "teseFurniture")!),
    TypePlanModel(planTypeTitle: "Gracz", typePlanPicture: UIImage(named: "teseGaming")!),
    TypePlanModel(planTypeTitle: "Siłownia", typePlanPicture: UIImage(named: "teseGym")!),
    TypePlanModel(planTypeTitle: "Internet", typePlanPicture: UIImage(named: "teseInternet")!),
    TypePlanModel(planTypeTitle: "Medytacja", typePlanPicture: UIImage(named: "teseMind")!),
    TypePlanModel(planTypeTitle: "Muzyka", typePlanPicture: UIImage(named: "teseMusic")!),
    TypePlanModel(planTypeTitle: "Czas", typePlanPicture: UIImage(named: "teseTime")!),
    TypePlanModel(planTypeTitle: "Telewizja", typePlanPicture: UIImage(named: "teseTv")!),
    
    TypePlanModel(planTypeTitle: "Kwiaty", typePlanPicture: UIImage(named: "teseFlowers")!),
    TypePlanModel(planTypeTitle: "Kuchnia", typePlanPicture: UIImage(named: "teseKitchen")!),
    TypePlanModel(planTypeTitle: "Światło", typePlanPicture: UIImage(named: "teseLight")!),
    TypePlanModel(planTypeTitle: "Telefon", typePlanPicture: UIImage(named: "tesePhone")!),
    TypePlanModel(planTypeTitle: "Obecny", typePlanPicture: UIImage(named: "tesePresent")!),
    TypePlanModel(planTypeTitle: "Naprawa", typePlanPicture: UIImage(named: "teseRepair")!),
    TypePlanModel(planTypeTitle: "Zabawka", typePlanPicture: UIImage(named: "teseToy")!)
]
