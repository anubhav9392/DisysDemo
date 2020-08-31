//
//  NewsListViewModel.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import Foundation
import RxSwift

class NewsListViewModel {
    
    
    let service: APIService
   
    var newsList: BehaviorSubject<[News]>
    var showLoader: BehaviorSubject<Bool>
    var issues = [News]()
    
    init(service: APIService) {
        self.service = service
        newsList = BehaviorSubject(value: [])
        showLoader = BehaviorSubject(value: false)
        self.fetchNews()
    }
    
    func fetchNews() {
        newsList.onNext([])
        showLoader.onNext(true)
        service.fetchNews { [weak self] (result) in
            self?.showLoader.onNext(false)
            if let arrData = result {
                let newsList = arrData.map({
                    News(
                        title: $0.title ?? "",
                        description: $0.description ?? "",
                        date: $0.date ?? "",
                        image: $0.image ?? ""
                    )
                })
                self?.newsList.onNext(newsList)
            }
        }
    }
}

