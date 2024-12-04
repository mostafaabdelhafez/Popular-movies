//
//  MovieDetailsTableViewCell.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import UIKit
import Kingfisher
class MovieDetailsTableViewCell: UITableViewCell {
    
    static var identifier = "details"
    @IBOutlet weak var movieImage:UIImageView!
    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var movieDate:UILabel!
    @IBOutlet weak var movieStatus:UILabel!
    @IBOutlet weak var movieTagline:UILabel!
    @IBOutlet weak var movieOverview:UILabel!
    @IBOutlet weak var movieRevenue:UILabel!
    
    var details:MovieDetails!{
        didSet{
            setupUI(details: details)
        }
    }
    func setupUI(details:MovieDetails){
        if let url = URL(string:"https://api.themoviedb.org/3\(details.posterPath ?? "")"){
            
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: url)
        }
        movieTitle.text = details.title ?? ""
        movieDate.text = details.releaseDate ?? ""
        movieStatus.text = details.status ?? ""
        movieTagline.text = details.tagline ?? ""
        movieOverview.text = details.overview ?? ""
        movieRevenue.text = "\(details.revenue ?? 0)"

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
