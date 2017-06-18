//
//  ProductTableViewCell.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 15.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit
import AudioToolbox

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var ProductDescription: UILabel!
    @IBOutlet weak var WrapperView: UIView!
    @IBOutlet weak var AddToCart: UIButton!

    var isCartBtnPressed : Bool!
    var startColor : UIColor!
    
    override func awakeFromNib() {
        self.startColor = AddToCart.backgroundColor
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        animateOnClick()
        // Btn Feedback Vibration
        AudioServicesPlaySystemSound(1519)
    }
    
    
    func animateOnClick(){
        UIView.animate(withDuration: 0.1, animations: {
            self.AddToCart.backgroundColor = UIColor.gray
        })
        UIView.animate(withDuration: 0.2, animations: {
            self.AddToCart.backgroundColor = self.startColor
        })
    }
    

}
