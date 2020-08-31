//
//  ApiService.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    

    func fetchNews(completion: @escaping ([News]?) -> Void) {
        let url = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api/public/v1/news?local=en"
        let headers: HTTPHeaders = ["consumer-secret": "20891a1b4504ddc33d42501f9c8d2215fbe85008","consumer-key":"mobile_dev_temp"]
        AF.request(url, parameters: nil,headers: headers).responseJSON { response in
            debugPrint(response)
            let dictData = response.value as? [String:Any] ?? [:]
            let arrNews = dictData["payload"] as? [[String:Any]] ?? []
            var newsList : [News] = []
            for dictNews in arrNews{
                let newsObj = News(
                    title: dictNews["title"] as? String ?? "",
                    description: dictNews["description"] as? String ?? "",
                    date: dictNews["date"] as? String ?? "",
                    image: dictNews["image"] as? String ?? ""
                )
                newsList.append(newsObj)
            }
            completion(newsList)
        }
    }
    
    func registration(param:[String:Any], completion: @escaping ([String:Any]?) -> Void) {
        let url = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api/iskan/v1/certificates/towhomitmayconcern"
        let headers: HTTPHeaders = ["consumer-secret": "20891a1b4504ddc33d42501f9c8d2215fbe85008","consumer-key":"mobile_dev_temp"]
        AF.request(url,method: .post, parameters: param,headers: headers).responseJSON { response in
            debugPrint(response)
            let dictData = response.value as? [String:Any] ?? [:]
            completion(dictData)
        }
    }
}

