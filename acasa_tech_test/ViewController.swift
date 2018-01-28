//
//  ViewController.swift
//  acasa_tech_test
//
//  Created by Alex Little on 26/01/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var objects = [AcasaModel]()
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchData()
    }
    func fetchData(){
        //fetchdata
        Alamofire.request("https://api.myjson.com/bins/107b4d").responseJSON { response in
            if let json = response.result.value as? [[String:Any]]{
                print("JSON: \(json)") // serialized json response
                for obj in json {
                    let model = AcasaModel.transformAcasa(dict: obj)
                    self.objects.append(model)
//                    if !self.categories.contains(model.category ?? "Uncategorised"){
//                        self.categories.append(model.category ?? "Uncategorised")
//                    }
                    
                    let date = Calendar.current.startOfDay(for: model.due_date ?? Date())
                    let dateString = SharedDateFormatter.sharedInstance.dateFormatterUk.string(from: date)
                    if !self.dates.contains(dateString){
                        self.dates.append(dateString)
                    }
                    
                    
//                    self.tableView.reloadData()
                }
                
                let filteredObjs = self.objects.sorted(by: {$0.due_date ?? Date() > $1.due_date ?? Date()})
                self.objects = filteredObjs
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "detailPayment" {
            let vc = segue.destination as? PaymentDetailViewController
            
            if let array = sender as? [Any]{
                if let payment = array[0] as? AcasaModel {
                    vc?.payment = payment
                }
                if let objects = array[1] as? [AcasaModel]{
                    vc?.objects = objects
                }
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentTableViewCell
        
        
        let date = dates[indexPath.section]
        let filteredObjects = objects.filter {SharedDateFormatter.sharedInstance.dateFormatterUk.string(from: Calendar.current.startOfDay(for: $0.due_date ?? Date())) ?? "" == date}
        let object = filteredObjects[indexPath.row]
        
        cell.acasaModel = object
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        let objectsSection = objects.filter({SharedDateFormatter.sharedInstance.dateFormatterUk.string(from: Calendar.current.startOfDay(for: $0.due_date ?? Date())) ?? "" == date})
        return objectsSection.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = dates[indexPath.section]
        let objectsSection = objects.filter({SharedDateFormatter.sharedInstance.dateFormatterUk.string(from: Calendar.current.startOfDay(for: $0.due_date ?? Date())) ?? "" == date})
        let model = objectsSection[indexPath.row]
        let array = [model, objects] as [Any]
        performSegue(withIdentifier: "detailPayment", sender: array)
    }
    
    
}
