//
//  ViewControllerFactory.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit


enum Storyboard: String {
    case Main
}

extension Storyboard {
    private func object() -> UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func instantiateViewController(with identifier: String) -> UIViewController {
        return self.object().instantiateViewController(withIdentifier: identifier)
    }
}

class ViewControllerFactory {
    
    func instantiateInitialViewController() -> ViewController {
        let vc : ViewController =  Storyboard.Main.instantiateViewController(with: ViewController.identifier) as! ViewController
        return vc;
    }
    
    func instantiateMoviesListViewController() -> MoviesListViewController {
        let vc : MoviesListViewController =  Storyboard.Main.instantiateViewController(with: MoviesListViewController.identifier) as! MoviesListViewController
        return vc;
    }
    
    func instantiateMoviesDetailsViewController() -> MovieDetailsViewController {
        let vc : MovieDetailsViewController =  Storyboard.Main.instantiateViewController(with: MovieDetailsViewController.identifier) as! MovieDetailsViewController
        return vc;
    }
}
