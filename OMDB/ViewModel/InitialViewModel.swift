//
//  InitialViewModel.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 21/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

class InitialViewModel: NSObject {
    
    let moviesDataProvider : MoviesDataProviderManager
    
    init(dataProvider : MoviesDataProviderManager) {
        moviesDataProvider = dataProvider;
    }

    
    func fetchMoviesList(search : String , completion: @escaping ApiCompletionBlock<MoviesResponseModel>){
        moviesDataProvider.fetchMoviesList(search: search, completion: completion);
    }
}
