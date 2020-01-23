//
//  ApplicationCoordinator.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

class ApplicationCoordinator : BaseCoordinator {
    
    // MARK: - Init
    
    override init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        super.init(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory);
    }
    
    // MARK: - Coordinator
    
    override func start() {
        runSearchFlow()
    }
    
    // MARK: - Private methods
    
    private func runSearchFlow() {
        let coordinator = self.coordinatorFactory.makeSearchCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
