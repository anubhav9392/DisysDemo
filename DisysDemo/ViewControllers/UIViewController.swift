//
//  UIViewController.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func isValidEmail(textStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: textStr.localizedLowercase)
    }
    func showAlertWithCallBack(title:String, message:String,callBack:@escaping () -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction!) in callBack()}))
            self.present(alert, animated: true, completion: nil)
        }
        
       
    }
    func showAlert(title:String, message:String) {
               let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
               self.present(alert, animated: true, completion: nil)
           }
}
