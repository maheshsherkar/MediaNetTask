//
//  MoviesDataProviderService.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 22/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation


protocol MoviesDataProviderService {
    func executeFetchMoviesListRequest(search: String, completion: @escaping ApiCompletionBlock<MoviesResponseModel>)
    func executeFetchMoviesDetailsRequest(name: String,completion: @escaping ApiCompletionBlock<MoviesDetailsResponseModel>) 
}
