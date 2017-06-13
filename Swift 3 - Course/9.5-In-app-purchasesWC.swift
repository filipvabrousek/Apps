//
//  ViewController.swift
//  Gold Digger
//
//  Created by Filip Vabroušek on 06.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//



/*
 REQUIRED!!!!!:
 
 app bundle id,
 Itunes Connect - features - inApp purchases
 xCode  - cababilites - enable IAP
 
 */


import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @IBOutlet var iAPNameLabel: UILabel!
    @IBOutlet var res: UILabel!
    
    var activeProduct: SKProduct!
    
    
    
    /*                          BUY                         */
    @IBAction func buy(_ sender: Any) {
        
        if let activeProduct = activeProduct {
            
            print("Buying \(activeProduct.productIdentifier)")
            
            let payment = SKPayment(product: activeProduct)
            
            SKPaymentQueue.default().add(payment)
            
        } else {
            
            print("No product")
            
        }
    }
    
    
    
    
    /*                                              PRODUCT REQUEST                                 */
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("loaeded products")
        
        for product in response.products{
            
            print("Product \(product.productIdentifier)  \(product.localizedTitle)  \(product.price.floatValue)")
            iAPNameLabel.text = "Buy \(product.localizedTitle)"
            
            activeProduct = product
            
            
            
        }
    }
    
    
    
    /*                                              PAYMENT QUEUE                                 */
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        
        for transaction in transactions {
            
            switch(transaction.transactionState){
                
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Purchased")
                iAPNameLabel.text = "Purchased "
                
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                iAPNameLabel.text = "Failed"
                //apply purchase here and store info in USERDEAFULTS
                
            default:
                break
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SKPaymentQueue.default().add(self)
        
        let productIdentifiers: Set<String> = ["goldnugegt"]
        
        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

