//
//  AccountViewModel.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import KeychainSwift

class AccountViewModel {
    
    
    let service: APIService
    
    var isLogin: BehaviorSubject<Bool>
    var showLoader: BehaviorSubject<Bool>
    var issues = [News]()
    
    init(service: APIService) {
        self.service = service
        isLogin = BehaviorSubject(value:false)
        showLoader = BehaviorSubject(value: false)
        
    }
    
    
    func login(email:String,pwd:String,completion: (Bool,String) -> Void)  {
        
        showLoader.onNext(false)
        let keychain = KeychainSwift()
        let userName = keychain.get("Email") ?? "";
        let password = keychain.get("Password") ?? "";
        if(email == userName && pwd == password ){
            completion(true,"Success");
            showLoader.onNext(true)
        }else{
            completion(false,"Please enter valid username password.");
            showLoader.onNext(true)
        }
        
    }
    
    func signUp(params:[String:Any],completion: @escaping ([String:Any]?) -> Void)  {
        showLoader.onNext(true)
        service.registration(param: params) { (response) in
            completion(response);
            self.showLoader.onNext(false)
        }
    }
    
}
