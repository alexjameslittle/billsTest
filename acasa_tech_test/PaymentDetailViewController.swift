//
//  PaymentDetailViewController.swift
//  acasa_tech_test
//
//  Created by Alex Little on 28/01/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit
import SDWebImage

class PaymentDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var whoPaidLabel: UILabel!
    
    var payment: AcasaModel?
    var objects = [AcasaModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        setupTableView()
        
        
        
    }
    func setupTableView(){
//        for (index, object) in objects.enumerated(){
////            if object.id == payment?.id {
////                objects.remove(at: index)
////            }
//            if object.category != payment?.category {
//                objects.remov
//            }
//        }
        let objectsNew = objects.filter({$0.category == payment?.category})
        let finalObjects = objectsNew.filter({$0.id != payment?.id})
        objects = finalObjects
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .never
        setupView()
        self.title = payment?.category
    }
    
    func setupView(){
        if let url = URL(string: payment?.categoryIcon ?? "") {
            iconImageView.sd_setImage(with: url)
        }
        titleLabel.text = payment?.title
        if let pence = payment?.user_share_amount_pence {
            let pounds = pence / 100
            amountLabel.text = "£\(pounds)"
        }
        whoPaidLabel.text = payment?.payer_name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PaymentDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentTableViewCell
        cell.acasaModel = model
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects.count
    }
    
}
