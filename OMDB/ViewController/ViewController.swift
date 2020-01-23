//
//  ViewController.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

protocol ViewControllerActionProtocol : BaseViewControllerProtocol {
    var onGotoMovieListPage : (([Movies]?) -> Void)? { get set }

}

class ViewController: UIViewController , ViewControllerActionProtocol {
    var onGotoMovieListPage : (([Movies]?) -> Void)?
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var baseViewheightConstriant: NSLayoutConstraint!

    
    var viewModel : InitialViewModel?
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification , object: nil)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    
  

    @IBAction func onSearchClick(_ sender: Any) {
        txtFieldSearch.resignFirstResponder()
        AppUtils.addActivitiIndicaterView()
        if let temp = txtFieldSearch.text{
            viewModel?.fetchMoviesList(search: temp) { [weak self] result in
                AppUtils.hideActivitiIndicaterView();
                switch result {
                case .success(let response) :
                    if (response.response == "True"){
                        if response.search != nil && response.search!.count > 0 {
                            self?.onGotoMovieListPage?(response.search!)
                        }else{
                            AlertService().showAlert(message: "Data Not Found", completion: {
                                
                            })
                        }
                    }else{
                        AlertService().showAlert(message: "Data Not Found", completion: {
                                               
                                        })
                    }
                case .failure( _):
                    AlertService().showAlert(message: "Something went wrong", completion: {
                        
                    })
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        if show {
            let yConstraint = NSLayoutConstraint(item: baseView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.6, constant: 0)
            self.view.removeConstraint(baseViewheightConstriant)
            baseViewheightConstriant = yConstraint
            NSLayoutConstraint.activate([baseViewheightConstriant])
            
        }else {
            let yConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: baseView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
            self.view.removeConstraint(baseViewheightConstriant)
            baseViewheightConstriant = yConstraint
            NSLayoutConstraint.activate([baseViewheightConstriant])
        }
    }
    
}

