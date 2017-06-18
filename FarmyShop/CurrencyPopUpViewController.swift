//
//  CurrencyPopUpViewController.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 15.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import UIKit

class CurrencyPopUpViewController: UIViewController {

    @IBOutlet weak var PopUpView: UIView!
    
    @IBOutlet weak var SwitchUSD: UISwitch!
    @IBOutlet weak var SwitchEUR: UISwitch!
    @IBOutlet weak var SwitchCHF: UISwitch!
    @IBOutlet weak var SwitchAUD: UISwitch!
    
    @IBAction func SwitchUSD(_ sender: UISwitch) {
        SwitchUSD.setOn(true, animated: false)
        SwitchEUR.setOn(false, animated: true)
        SwitchCHF.setOn(false, animated: true)
        SwitchAUD.setOn(false, animated: true)
        
        CurrencyManager.Instance.activeCurrency = Currency.USD
    }
    
    @IBAction func SwitchEUR(_ sender: UISwitch) {
        SwitchEUR.setOn(true, animated: false)
        SwitchUSD.setOn(false, animated: true)
        SwitchCHF.setOn(false, animated: true)
        SwitchAUD.setOn(false, animated: true)
        
        CurrencyManager.Instance.activeCurrency = Currency.EUR
    }
    
    @IBAction func SwitchCHF(_ sender: UISwitch) {
        SwitchCHF.setOn(true, animated: false)
        SwitchEUR.setOn(false, animated: true)
        SwitchUSD.setOn(false, animated: true)
        SwitchAUD.setOn(false, animated: true)
        
        CurrencyManager.Instance.activeCurrency = Currency.CHF
    }
    
    @IBAction func SwitchAUD(_ sender: UISwitch) {
        SwitchAUD.setOn(true, animated: false)
        SwitchEUR.setOn(false, animated: true)
        SwitchCHF.setOn(false, animated: true)
        SwitchUSD.setOn(false, animated: true)
        
        CurrencyManager.Instance.activeCurrency = Currency.AUD
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PopUpView.layer.opacity = 0
        self.view.layer.opacity  = 0
        self.PopUpView.dropShadow()
        self.fadeIn()
        toggleSwitchByCurrencySetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toggleSwitchByCurrencySetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleSwitchByCurrencySetting(){
        switch  CurrencyManager.Instance.activeCurrency {
        case Currency.USD:
            SwitchUSD.setOn(true, animated: false)
            SwitchEUR.setOn(false, animated: false)
            SwitchCHF.setOn(false, animated: false)
            SwitchAUD.setOn(false, animated: false)
        case Currency.EUR:
            SwitchEUR.setOn(true, animated: false)
            SwitchUSD.setOn(false, animated: false)
            SwitchCHF.setOn(false, animated: false)
            SwitchAUD.setOn(false, animated: false)
        case Currency.CHF:
            SwitchCHF.setOn(true, animated: false)
            SwitchEUR.setOn(false, animated: false)
            SwitchUSD.setOn(false, animated: false)
            SwitchAUD.setOn(false, animated: false)
        case Currency.AUD:
            SwitchAUD.setOn(true, animated: false)
            SwitchEUR.setOn(false, animated: false)
            SwitchCHF.setOn(false, animated: false)
            SwitchUSD.setOn(false, animated: false)
        }

    }
    
    func fadeIn(){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layer.opacity  = 1
            UIView.animate(withDuration: 0.1, animations: {
                self.PopUpView.layer.opacity = 1
            })
        })
    }
    
    func fadeOut(){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layer.opacity  = 0
            UIView.animate(withDuration: 0.1, animations: {
                self.PopUpView.layer.opacity = 0
            })
        })
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
