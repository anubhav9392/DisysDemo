//
//  News.swift
//  DisysDemo
//
//  Created by Vinculum on 31/8/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import Foundation

struct News: Codable {
    let title: String?
    let description: String?
    let date: String?
    let image: String?
    

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case date = "date"
        case image = "image"
    }
}
