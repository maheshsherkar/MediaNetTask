//
//  MoviesListViewController.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 20/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit




protocol MoviesListViewControllerActionProtocol : BaseViewControllerProtocol {
    var onGotoDetailPage : ((Movies) -> Void)? { get set }
}

class MoviesListViewController: UIViewController, MoviesListViewControllerActionProtocol {
    var onGotoDetailPage: ((Movies) -> Void)?

    var viewModel : MoviesListViewModel?
    
    @IBOutlet weak var moviesTableVIew: UITableView!
    var moviesList : [Movies]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesTableVIew.delegate = self;
        self.moviesTableVIew.dataSource = self;
        self.moviesTableVIew.tableFooterView = UIView (frame: .zero)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MoviesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Notes : Here i unwrapped moviesList variable forcefully.
        return moviesList!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as! MovieListTableViewCell
        cell.configureCell(model: moviesList![indexPath.row])
        return cell
    }
    
    
}


extension MoviesListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onGotoDetailPage?(moviesList![indexPath.row])
    }
}


