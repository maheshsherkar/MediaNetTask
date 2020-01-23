//
//  Search.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 22/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

struct Movies : Decodable {
    let title : String?
    let year : String?
    let imdbID : String?
    let type : String?
    let poster : String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
