//
//  CartViewController.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 13.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate   {

    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartTotal: UILabel!
    
    @IBAction func productStepperChange(_ sender: UIStepper!) {
            let stepper = sender
        
            if Int((stepper?.value)!) > 0{
                //increment
                ShopManager.Instance.addProductToCart(productToAdd: ShopManager.Instance.GetProducts()[(stepper?.tag)!], amount: Int((stepper?.stepValue)!))
            }else{
                //decrement
                ShopManager.Instance.subtractProductFromCart(productId: (stepper?.tag)!, amount: Int((stepper?.stepValue)!))
            }
            cartTableView.reloadData()
            self.cartTotal.text = "Total: \(CurrencyManager.Instance.activeCurrency.rawValue) \(String(format: "%.2f", ShopManager.Instance.GetTotal()))"
        
        //Calc cart batch number
        var itemscount : Int = 0
        ShopManager.Instance.productsInCartArray.forEach({
            return itemscount += $0.amount
        })
        if(itemscount == 0){
            self.tabBarItem.badgeValue = nil
        }else{
            self.tabBarItem.badgeValue = String(itemscount);
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropShadow()
        self.cartTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartTableView.reloadData()
        self.cartTotal.text = "Total: \(CurrencyManager.Instance.activeCurrency.rawValue) \(String(format: "%.2f", ShopManager.Instance.GetTotal()))"
    }
    
    // Tabe View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopManager.Instance.GetCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell{
        
        let cell = Bundle.main.loadNibNamed("CartTableViewCell", owner: self, options: nil)?.first as! CartTableViewCell
        cell.productName.text = ShopManager.Instance.GetCart()[cellForRowAt.row].product.productName
        cell.productDescription.text = ShopManager.Instance.GetCart()[cellForRowAt.row].product.productDescription
        cell.amount.text = "\(ShopManager.Instance.GetCart()[cellForRowAt.row].amount)x"
        cell.priceTotal.text = "Total: \(String(format: "%.2f", ShopManager.Instance.GetCart()[cellForRowAt.row].total)) \(ShopManager.Instance.GetCart()[cellForRowAt.row].product.currency.rawValue)"
        cell.productPrice.text = " \(ShopManager.Instance.GetCart()[cellForRowAt.row].product.currency.rawValue) \(String(format: "%.2f", ShopManager.Instance.GetCart()[cellForRowAt.row].product.price))"
        cell.productStepper.tag = ShopManager.Instance.GetCart()[cellForRowAt.row].product.Id
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deteteAction : UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler: {_,indexPath in
            ShopManager.Instance.removeProductFromCart(at: indexPath.row)
            self.cartTableView.reloadData()
            self.cartTotal.text = "Total: \(CurrencyManager.Instance.activeCurrency.rawValue) \(String(format: "%.2f", ShopManager.Instance.GetTotal()))"
            
            //Calc cart batch number
            var itemscount : Int = 0
            ShopManager.Instance.productsInCartArray.forEach({
                return itemscount += $0.amount
            })
            if(itemscount == 0){
                self.tabBarItem.badgeValue = nil
            }else{
                self.tabBarItem.badgeValue = String(itemscount);
            }
            
        })
        deteteAction.backgroundColor = UIColor.red
        return [deteteAction]
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
