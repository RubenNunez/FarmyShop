//
//  ProductsViewController.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 13.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit


class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productTableView: UITableView!
    
    @IBAction func btnAddToCart(_ sender: Any) {
        ShopManager.Instance.addProductToCart(productToAdd: ShopManager.Instance.GetProducts()[(sender as! UIButton).tag], amount: 1)
        var itemscount : Int = 0
            ShopManager.Instance.productsInCartArray.forEach({
            return itemscount += $0.amount
        })
        if(itemscount == 0){
            self.tabBarController?.tabBar.items?[1].badgeValue = nil
        }else{
             self.tabBarController?.tabBar.items?[1].badgeValue = String(itemscount)
        }
        
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dropShadow()
        self.productTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //productTableView.reloadData()
    }
    
    
    // Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopManager.Instance.GetProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) -> UITableViewCell{
        
        let cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self, options: nil)?.first as! ProductTableViewCell
        
        cell.ProductImage.image = ShopManager.Instance.GetProducts()[cellForRowAt.row] .productImage
        cell.Price.text = "\(ShopManager.Instance.GetProducts()[cellForRowAt.row] .currency) \(String(format: "%.2f", ShopManager.Instance.GetProducts()[cellForRowAt.row] .price))"
        cell.ProductName.text = ShopManager.Instance.GetProducts()[cellForRowAt.row].productName
        cell.ProductDescription.text = ShopManager.Instance.GetProducts()[cellForRowAt.row].productDescription
        cell.AddToCart.tag = ShopManager.Instance.GetProducts()[cellForRowAt.row].Id
        
        //Layout for ProductTaleView
        cell.WrapperView.dropShadow()
        cell.WrapperView.dropShadow(direction: Direction.Top)
        cell.WrapperView.layer.cornerRadius = 1
        cell.backgroundColor = UIColor.clear
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
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
