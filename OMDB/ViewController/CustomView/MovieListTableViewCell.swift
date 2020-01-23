//
//  MovieListTableViewCell.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 22/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var ivPoster: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model : Movies) {
        lblTitle.text = model.title
        lblSubTitle.text = model.year
        if let temp = model.poster {
            ivPoster.sd_setImage(with: URL(string: temp), placeholderImage: nil)

        }else{
        // you can set placeholder here
        }
    }
}
