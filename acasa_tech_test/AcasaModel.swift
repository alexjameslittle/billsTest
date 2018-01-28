//
//  AcasaModel.swift
//  acasa_tech_test
//
//  Created by Alex Little on 28/01/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation

class AcasaModel {
    var id: String?
    var title: String?
    var created_at: Date?
    var disabled: Bool?
    var category: String?
    var upcoming: Bool?
    var recur_freq_days: Int?
    var recur_freq_months: Int?
    var recur_freq_num: Int?
    var amount_pence: Int?
    var due_date: Date?
    var house_name: String?
    var payer_name: String?
    var categoryIcon: String?
    var user_share_amount_pence: Int?
}
extension AcasaModel {
    static func transformAcasa(dict: [String:Any]) -> AcasaModel {
        let acasa = AcasaModel()
        acasa.id = dict["id"] as? String
        acasa.title = dict["title"] as? String
        
        if let date = dict["created_at"] as? String {
            acasa.created_at = SharedDateFormatter.sharedInstance.dateFormatter.date(from: date)
        }
        acasa.disabled = dict["disabled"] as? Bool
        acasa.category = dict["category"] as? String
        acasa.upcoming = dict["upcoming"] as? Bool
        acasa.recur_freq_days = dict["recur_freq_days"] as? Int
        acasa.recur_freq_months = dict["recur_freq_months"] as? Int
        acasa.recur_freq_num = dict["recur_freq_num"] as? Int
        acasa.amount_pence = dict["amount_pence"] as? Int
        if let dueDate = dict["due_date"] as? String {
            acasa.due_date = SharedDateFormatter.sharedInstance.dateFormatter.date(from: dueDate)
        }
        acasa.house_name = dict["house_name"] as? String
        acasa.payer_name = dict["payer_name"] as? String
        if let url = dict["category_icon"] as? String{
            acasa.categoryIcon = url
        }
        acasa.user_share_amount_pence = dict["user_share_amount_pence"] as? Int
        return acasa
    }
    
}


/*
 
 {"id":"R6WPrv","title":"Utilities bill","category":"Utilities","created_at":"2018-01-05T00:58:34.496+00:00","disabled":false,"upcoming":false,"recur_freq_days":0,"recur_freq_months":1,"recur_day_num":5,"amount_pence":9018,"due_date":"2018-01-01","house_name":"acasa test house","payer_name":"Alice","category_icon":"http://www.helloacasa.com/wp-content/uploads/2017/08/TVL.png","user_share_amount_pence":3006}
 
 */
