//
//  ShopManager.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 16.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import Foundation
import UIKit

class ShopManager : NSObject{
    
    // Singleton behaviour
    static let Instance : ShopManager = ShopManager()
    
    var productsArray = [product]()
    var currencyPairs = [CurrencyPair]()
    var productsInCartArray = [productInCart]()
    var Total : Float = 0
    
    override init() {
        super.init()
        // dummy products
        self.productsArray = [product(Id :  0, productName :  "beans", productDescription : "per can", productImage : #imageLiteral(resourceName: "bg_beans"), basePriceInUSD : 0.73, price: 0.73, currency: Currency.USD),
                         product(Id :  1, productName :  "peas", productDescription : "lorem ipsum", productImage : #imageLiteral(resourceName: "bg_peas"), basePriceInUSD : 0.95, price: 0.95, currency: Currency.USD),
                         product(Id :  2, productName :  "eggs", productDescription : "per dozen", productImage : #imageLiteral(resourceName: "bg_eggs"), basePriceInUSD : 2.10, price: 2.10, currency: Currency.USD),
                         product(Id :  3, productName :  "milk", productDescription : "per bottle", productImage : #imageLiteral(resourceName: "bg_milk"), basePriceInUSD : 1.30, price: 1.30, currency: Currency.USD)]
        
       RefreshCurrencyPairs()
    }
    
    func GetProducts() -> [product]{
        return self.productsArray
    }
    
    func GetCart() -> [productInCart] {
        return self.productsInCartArray
    }
    
    func GetTotal()->Float{
            self.Total  = 0
            productsInCartArray.forEach({ self.Total += $0.total })
            return self.Total
    }
    
    func addProductToCart(productToAdd : product, amount : Int){
        // If Product is already in Cart -> just increase Amount
        if productsInCartArray.contains(where: { x in x.product.Id == productToAdd.Id }) {
            // Product already exists ---> Increase amount & calculate Subtotal
            productsInCartArray.filter({$0.product.Id == productToAdd.Id}).first?.amount += amount
            productsInCartArray.filter({$0.product.Id == productToAdd.Id}).first?.total += productToAdd.price
        }else{
            // Product doesnt exist ---> simply append
            productsInCartArray.append(productInCart(product: productToAdd, amount: 1, total: productToAdd.price))
        }
    }
    
    func subtractProductFromCart(productId: Int, amount: Int){
        let index = productsInCartArray.index(where: {$0.product.Id == productId })
        
        if productsInCartArray.contains(where: { x in x.product.Id == productsInCartArray[index!].product.Id && productsInCartArray[index!].amount >= 2 }) {
            // Product exists already  ---> subtract amount & calculate Subtotal
            productsInCartArray.filter({$0.product.Id == productId}).first?.amount -= amount
            productsInCartArray.filter({$0.product.Id == productId}).first?.total -= productsInCartArray[index!].product.price
        }else{
            // Product should not exist in this state ---> simply remove
            //productsInCartArray.remove(at:
            productsInCartArray.remove(at: index!)
        }
    }
    
    func removeProductFromCart(at : Int){
        productsInCartArray.remove(at: at)
    }
    
    func removeAllProductsFromCart(){
        productsInCartArray.removeAll()
    }
    
    func updatePricesByCurrenciesInArrays(currency : Currency){
        self.Total = 0
        let quotation =  self.currencyPairs.first(where: {$0.CounterCurrency == currency })?.quotation
        self.productsArray.forEach({
            p in p.price = p.basePriceInUSD * quotation!
            p.currency = currency
        })
        
        self.productsInCartArray.forEach({
            c in c.product.price = self.productsArray[self.productsArray.index(where: { p in p.Id == c.product.Id })!].price
            c.total = c.product.price * Float(c.amount)
            
            self.Total += c.total
            })
        
        
    }
    
    func RefreshCurrencyPairs(){
        CurrencyManager.Instance.getCurrencyPairsFromAPI(callback: {
            //Async: Has to wait until Request has finished
            self.currencyPairs = CurrencyManager.Instance.currencyPairs
            self.productsArray.forEach({product in
                product.price = product.basePriceInUSD * (CurrencyManager.Instance.currencyPairs.first(where: { $0.CounterCurrency == product.currency })?.quotation)!
            })
        })
    }
}

class product {
    let Id : Int!
    let productName: String!
    let productDescription : String!
    let productImage : UIImage!
    let basePriceInUSD : Float
    var price : Float
    var currency : Currency
    
    init(Id: Int, productName: String, productDescription: String, productImage: UIImage, basePriceInUSD: Float, price: Float, currency: Currency) {
        self.Id = Id
        self.productName = productName
        self.productDescription = productDescription
        self.productImage = productImage
        self.basePriceInUSD = basePriceInUSD
        self.price = price
        self.currency = currency
    }
    
    deinit { print("\(self.Id) is being deinitialized") }
}

class productInCart{
    let product : product
    var amount : Int
    var total : Float
    
    init(product: product, amount : Int, total : Float){
        self.product = product
        self.amount = amount
        self.total = total
    }
}

