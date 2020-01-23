//
//  WebServicesConstants.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation


struct Base {
    static private let developementURL = "http://www.omdbapi.com/"
    
    static private let qaURL =  ""
    
    static private let productionURL =  ""
    
    // MARK: Base URL
    static var url: String {
        get {
            return developementURL;
        }
    }
}


struct RequestURL {
    static let fetchMovies = Base.url + "?apikey=d062a57d"    
}
