//
//  Constants.swift
//  Conari
//
//  Created by Philipp Preiner on 04.05.16.
//  Copyright © 2016 Markus Friedl. All rights reserved.
//

import Foundation

struct Tutorial {
    var title: String
    var category: Int
    var difficulty: String
    var duration: String
    var text: String
}

let categories = ["Arts and Entertainment",
                  "Cars & Other Vehicles",
                  "Computers and Electronics",
                  "Conari",
                  "Education and Communications",
                  "Finance and Business",
                  "Food and Entertaining",
                  "Health",
                  "Hobbies and Crafts",
                  "Holidays and Traditions",
                  "Home and Garden",
                  "Personal Care and Style",
                  "Pets and Animals",
                  "Philosophy and Religion",
                  "Relationships",
                  "Sports and Fitness",
                  "Travel",
                  "Work World",
                  "Youth"]

let difficulty: [String : String] = [
    "1" : "very easy",
    "2" : "easy",
    "3" : "medium",
    "4" : "hard",
    "5" : "very hard"
]