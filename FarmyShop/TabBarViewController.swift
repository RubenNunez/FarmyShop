//
//  TabBarViewController.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 13.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit
import AudioToolbox

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var popUpIsActive : Bool = false
    var currencyPopUpViewController : UIViewController!
    
    @IBAction func showCurrencyPopUp(_ sender: Any) {
        // Btn Feedback Vibration
        AudioServicesPlaySystemSound(1519)
        
        if popUpIsActive == false{
            // Show PopUp
            currencyPopUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrencyPopUpVC") as! CurrencyPopUpViewController
            self.addChildViewController(currencyPopUpViewController)
            
            currencyPopUpViewController.view.frame = self.view.frame
            
            self.view.addSubview(currencyPopUpViewController.view)
            currencyPopUpViewController.didMove(toParentViewController: self)
            popUpIsActive = true
        }else{
            // Hide PopUp
            currencyPopUpViewController.view.removeFromSuperview()
            // Memory Leak found try removing instance
            (currencyPopUpViewController as! CurrencyPopUpViewController).fadeOut()
            // Wait until animation has finished
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.currencyPopUpViewController.removeFromParentViewController()
            })
        
            // Refresh TableViews  (price)
            ShopManager.Instance.updatePricesByCurrenciesInArrays(currency: CurrencyManager.Instance.activeCurrency)
            (self.viewControllers?[0] as! ProductsViewController).productTableView.reloadData()
            if (self.viewControllers?[1] as! CartViewController).cartTableView != nil{
                (self.viewControllers?[1] as! CartViewController).cartTableView.reloadData()
                (self.viewControllers?[1] as! CartViewController).cartTotal.text = "Total: \(CurrencyManager.Instance.activeCurrency.rawValue) \(String(format: "%.2f", ShopManager.Instance.GetTotal()))"
            }
            popUpIsActive=false
        }

    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Btn Feedback Vibration
        AudioServicesPlaySystemSound(1519)
        
        // Calculate batch number
        var itemscount : Int = 0
        ShopManager.Instance.productsInCartArray.forEach({
            return itemscount += $0.amount
        })
        if(itemscount == 0){
           self.tabBar.items?[1].badgeValue = nil
        }else{
            self.tabBar.items?[1].badgeValue = String(itemscount)
        }
        
        self.navigationItem.title = toVC.title
        return SwipeAnimation(tabBarController: tabBarController, lastIndex: tabBarController.selectedIndex)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationItem.title = self.viewControllers?[0].title
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
