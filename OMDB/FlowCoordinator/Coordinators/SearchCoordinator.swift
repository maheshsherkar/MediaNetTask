//
//  AuthCoordinator.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

class SearchCoordinator: BaseCoordinator {

    
    // MARK: - Private methods
    
    private func showIntialViewController() {
        let initialVC : ViewController = self.viewControllerFactory.instantiateInitialViewController()
        initialVC.viewModel = InitialViewModel(dataProvider : MoviesDataProviderManager(service: MoviesApiClient(session: URLSession.shared)));
        initialVC.onGotoMovieListPage = { [unowned self] list in
            self.showMoviesListViewController(list: list!)
        }
        self.router.setRootModule(initialVC, hideBar: true)
    }
    
    private func showMoviesListViewController(list : [Movies]) {
        let vc = self.viewControllerFactory.instantiateMoviesListViewController()
        vc.viewModel = MoviesListViewModel();
        vc.moviesList = list;
        vc.onGotoDetailPage = { [unowned self] movies in
            self.showMoviesDetailsViewController(movies: movies)
        }
        self.router.push(vc)
    }
    
    private func showMoviesDetailsViewController(movies : Movies) {
        let vc = self.viewControllerFactory.instantiateMoviesDetailsViewController()
        vc.movies = movies;
        vc.viewModel = MoviesDetailsViewModel(dataProvider : MoviesDataProviderManager(service: MoviesApiClient(session: URLSession.shared)));
        vc.onBack = {[unowned self] in
            self.router.popModule()
        }
        self.router.push(vc)
    }
    
    
    // MARK: - Coordinator
    
    override func start() {
        self.showIntialViewController()
    }
    
    // MARK: - Init
    
    override init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        super.init(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory);
    }
}
