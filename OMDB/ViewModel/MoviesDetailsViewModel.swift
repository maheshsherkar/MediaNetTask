//
//  MoviesDetailsViewModel.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 21/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

class MoviesDetailsViewModel: NSObject {
    let moviesDataProvider : MoviesDataProviderManager
     
     init(dataProvider : MoviesDataProviderManager) {
         moviesDataProvider = dataProvider;
     }

     
     func fetchMoviesDetails(name : String , completion: @escaping ApiCompletionBlock<MoviesDetailsResponseModel>){
         moviesDataProvider.fetchMoviesDetails(name: name, completion: completion);
     }
}
