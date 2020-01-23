//
//  MoviesDataProvider.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 22/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

class MoviesDataProviderManager : NSObject {

    private var cloudService : MoviesDataProviderService?

    // if we give provision for offline storage then we need to use database here.
    
    init(service : MoviesDataProviderService) {
        cloudService = service;
    }
    
    
    func fetchMoviesList(search: String, completion: @escaping ApiCompletionBlock<MoviesResponseModel>){
        cloudService?.executeFetchMoviesListRequest(search: search, completion: completion)
    }
    
    
    func fetchMoviesDetails(name: String, completion: @escaping ApiCompletionBlock<MoviesDetailsResponseModel>){
        cloudService?.executeFetchMoviesDetailsRequest(name: name, completion: completion)
    }
}
