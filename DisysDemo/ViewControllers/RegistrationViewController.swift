//
//  RegistrationViewController.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit
import RxSwift
import KeychainSwift

class RegistrationViewController: UIViewController {

    @IBOutlet var txtEid: UITextField!
       @IBOutlet var txtName: UITextField!
       @IBOutlet var txtidbarahno: UITextField!
       @IBOutlet var txtemailaddress: UITextField!
       @IBOutlet var txtUnifiedNumber: UITextField!
       @IBOutlet var txtMobileNumber: UITextField!
       @IBOutlet var btnSignUp: UIButton!
       @IBOutlet var loadingIndicator: UIActivityIndicatorView!
       let disposeBag = DisposeBag()
       var viewModel: AccountViewModel!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.title = "Register"
           viewModel = AccountViewModel(service: APIService())
           
           self.btnSignUp.layer.cornerRadius = 10.0;
           // Do any additional setup after loading the view.
       }
       private func bindViewModel() {
              viewModel.showLoader
                   .bind(to: loadingIndicator.rx.isAnimating)
                   .disposed(by: disposeBag)
       }

       @IBAction func btnSignUp(_ sender: Any) {
           let eid = self.txtEid.text ?? ""
           let name = self.txtName.text ?? ""
           let idbarahno = self.txtidbarahno.text ?? ""
           let emailAddress = self.txtemailaddress.text ?? ""
           let unifiedNumber = self.txtUnifiedNumber.text ?? ""
           let mobileNumber = self.txtMobileNumber.text ?? ""
           if(eid == ""){
               self.showAlert(title: "Demo Project", message: "Please enter user id.")
           }else if(name == ""){
               self.showAlert(title: "Demo Project", message: "Please enter name.")
           }else if(idbarahno == ""){
               self.showAlert(title: "Demo Project", message: "Please enter idbarah number.")
           }else if(emailAddress == ""){
               self.showAlert(title: "Demo Project", message: "Please enter email address.")
           }else if(!self.isValidEmail(textStr: emailAddress)){
               self.showAlert(title: "Demo Project", message: "Please enter valid email address.")
           }else if(unifiedNumber == ""){
               self.showAlert(title: "Demo Project", message: "Please enter unified number.")
           }else if(mobileNumber == ""){
               self.showAlert(title: "Demo Project", message: "Please enter mobile number")
           }else{
               let params : [String:Any] = ["eid":Int(eid) ?? 0,"name":name,"idbarahno":Int(idbarahno) ?? 0,"emailaddress":emailAddress,"unifiednumber":unifiedNumber,"mobileno":mobileNumber]
               viewModel.signUp(params: params) { (response) in
                   DispatchQueue.main.async {
                    let dictData = response ?? [:]
                       let success = dictData["success"] as? Bool ?? false
                       let message = dictData["message"] as? String ?? ""
                       if(success){
                           let keyChain = KeychainSwift()
                           keyChain.set(emailAddress, forKey: "Email")
                           keyChain.set("abcd1234", forKey: "Password")
                           self.showAlertWithCallBack(title: "Demo Project", message: message) {
                               
                               self.navigationController?.popViewController(animated: true)
                           }
                       }else{
                           self.showAlert(title: "Demo Project", message: message)
                       }
                   }
               }
           }
           
           

       }
}
