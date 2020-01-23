//
//  CoordinatorFactory.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation


protocol CoordinatorFactoryProtocol {
    func makeSearchCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> SearchCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - CoordinatorFactoryProtocol
    
     func makeSearchCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> SearchCoordinator {
        let coordinator = SearchCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
}
