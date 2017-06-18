//
//  CartTableViewCell.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 15.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var priceTotal: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var productStepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func productStepperChange(_ sender: Any) {
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
