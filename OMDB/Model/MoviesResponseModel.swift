//
//  MoviesResponseModel.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

struct MoviesResponseModel : Decodable {
  let search : [Movies]?
  let totalResults : String?
  let response : String?

  enum CodingKeys: String, CodingKey {
      case search = "Search"
      case totalResults = "totalResults"
      case response = "Response"
  }
}

