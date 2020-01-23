//
//  ViewController.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

extension UIViewController {
    
        static var identifier: String {
            return String(describing: self)
        }
    
        func toPresent() -> UIViewController? {
            return self;
        }
    
    
}
