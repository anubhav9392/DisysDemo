//
//  LoginViewController.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit
import KeychainSwift
import RxSwift

class LoginViewController: UIViewController {

    var viewModel: AccountViewModel!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassWord: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AccountViewModel(service: APIService())
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = "Login"
        self.btnLogin.layer.cornerRadius = 10.0;
        self.btnRegister.layer.cornerRadius = 10.0;
    }
    private func bindViewModel() {
           viewModel.showLoader
                .bind(to: loadingIndicator.rx.isAnimating)
                .disposed(by: disposeBag)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = self.txtEmail.text ?? ""
        let password = self.txtPassWord.text ?? ""
        if(email == ""){
            self.showAlert(title: "Demo Project", message: "Please enter email address.")
        }else if(!self.isValidEmail(textStr: email)){
            self.showAlert(title: "Demo Project", message: "Please enter valid email address.")
        }else if(password == ""){
            self.showAlert(title: "Demo Project", message: "Please enter password.")
        }else if(password != "abcd1234"){
            self.showAlert(title: "Demo Project", message: "Please enter valid password.")
        }else{
                viewModel.login(email: email, pwd: password) { (isLoggedIn,message) in
                    if(isLoggedIn == true){
                        let homeVC  = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                        self.navigationController?.pushViewController(homeVC, animated: true);
                    }else{
                         self.showAlert(title: "Demo Project", message: message)
                    }
                }
        }

        
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let registrationVC  = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationViewController
        self.navigationController?.pushViewController(registrationVC, animated: true);
    }

}
