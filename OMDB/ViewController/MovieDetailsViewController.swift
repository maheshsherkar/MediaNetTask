//
//  MovieDetailsViewController.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 20/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit

protocol MovieDetailsViewControllerActionProtocol : BaseViewControllerProtocol {
    var onBack: (() -> Void)? { get set }
}

class MovieDetailsViewController: UIViewController, MovieDetailsViewControllerActionProtocol {
    var onBack: (() -> Void)?
    
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDirector: UILabel!
    @IBOutlet weak var lblDirectorName: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    var viewModel : MoviesDetailsViewModel?
    
    var movies : Movies?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        ivPoster.sd_setImage(with: URL(string: movies!.poster!), placeholderImage: nil)
        
        AppUtils.addActivitiIndicaterView()
        viewModel?.fetchMoviesDetails(name: movies!.title!) { [weak self] result in
                       AppUtils.hideActivitiIndicaterView();
                       switch result {
                       case .success(let response) :
                           if (response.response == "True"){
                            self!.initUI(model : response)
                           }else{
                               AlertService().showAlert(message: "Data Not Found", completion: {
                                                      
                                               })
                           }
                       case .failure( _):
                           AlertService().showAlert(message: "Something went wrong", completion: {
                               
                           })
                       }
                   }
        // Do any additional setup after loading the view.
    }
    
    func initUI(model : MoviesDetailsResponseModel) {
        lblDirector.text = "Director"
        lblName.text = model.title;
        lblDirectorName.text = model.director;
        lblRating.text = model.imdbRating;
    }
    
    @IBAction func onBackAction(_ sender: Any) {
         self.onBack?();
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
