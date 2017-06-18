//
//  CurrencyManager.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 16.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import Foundation

class CurrencyManager: NSObject {
    
    // Singleton behaviour
    static let Instance : CurrencyManager = CurrencyManager()
    
    private let API_KEY = "01efe28c9df2b493f0015747f0f09b5e"
    private let sourceCurrency : Currency = Currency.USD
    private var baseURL = "http://apilayer.net/api/live?"
    private let currencies = [Currency.EUR, Currency.USD, Currency.AUD, Currency.CHF]
    var currencyPairs : [CurrencyPair] = [CurrencyPair]()
    var activeCurrency : Currency = Currency.USD

    override init() {
        super.init()
    }
    
    func getCurrencyPairsFromAPI(callback: @escaping ()-> Void){
        self.makeHTTPrequest(todoEndpoint: CurrencyManager.Instance.prepareURLforRequest(sourceCurrency: Currency.USD), callback: callback)
    }
    
    // returns API URL
    private func prepareURLforRequest(sourceCurrency : Currency) -> String{
        return self.baseURL + "access_key=\(API_KEY)" + "&source=\(sourceCurrency)&currencies=\(currencies.map({"\($0)"}).joined(separator: ","))"
    }
    
    private func makeHTTPrequest(todoEndpoint : String, callback: @escaping () -> Void){
        guard let url = NSURL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url as URL)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    // SUCCSESS API CALL
                    for (key, value) in (json?["quotes"] as? [String: Any])!{
                        //print("\(key) : \(value)")
                        
                        let baseIndex = key.startIndex..<key.index(key.endIndex, offsetBy: -3)
                        let counterIndex = key.index(key.startIndex, offsetBy: 3)..<key.endIndex
                        
                        // Add pairs to Array
                        self.currencyPairs.append(CurrencyPair(BaseCurrency: Currency(rawValue: key[baseIndex])!, CounterCurrency: Currency(rawValue: key[counterIndex])!, quotation: value as! Float))
                    }
                    callback()
                    // prints the whole JSON
                    // --> print(String(describing: json))
                } else {
                    print("Error: Could not make request")
                }
            }
        })
        task.resume()
    }
}

// ENUM is used for easy ACCSESS
enum Currency : String {
    case EUR = "EUR", USD = "USD", AUD = "AUD", CHF = "CHF"
    static let Currencies = [EUR, USD, AUD, CHF]
}

// This Struct is made of a pair of two currencies EXAMPLE consider EUR/USD currency pair traded at a quotation of 1.33
// In our case the BaseCurrency is always USD
struct CurrencyPair{
    let BaseCurrency : Currency
    let CounterCurrency : Currency
    var quotation :  Float
}


