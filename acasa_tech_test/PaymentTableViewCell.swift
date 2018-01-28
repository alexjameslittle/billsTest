//
//  PaymentTableViewCell.swift
//  acasa_tech_test
//
//  Created by Alex Little on 28/01/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import AlamofireImage

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var paymentNameLabel: UILabel!
    @IBOutlet weak var paidByLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var acasaModel: AcasaModel? {
        didSet{
            setupCell()
        }
    }
    func setupCell(){
        paymentNameLabel.text = acasaModel?.title
        paidByLabel.text = "\(acasaModel?.payer_name ?? "") paid"
        
        if let pence = acasaModel?.user_share_amount_pence {
            let pounds = pence / 100
            amountLabel.text = "£\(pounds)"
        }
        
        if let url = URL(string: acasaModel?.categoryIcon ?? "") {
            iconImageView.layer.cornerRadius = 5
            iconImageView.sd_setImage(with: url)

        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
