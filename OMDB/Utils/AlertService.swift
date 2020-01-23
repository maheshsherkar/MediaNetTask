//
//  AlertService.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

class AlertService: NSObject {

    // MARK:- Internal Properties
    
    fileprivate var rootViewController: UIViewController? {
        get {
            return (UIApplication.shared.keyWindow?.rootViewController)
        }
    }
    
    typealias AlertCompletionClosure = ()->Swift.Void
    
    func showAlert(_ title: String = "Telematics", message: String, completion: AlertCompletionClosure?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion?()
        }))
        DispatchQueue.main.async {
            self.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}
