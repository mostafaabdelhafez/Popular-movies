//
//  SimilarMoviesTableViewCell.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import UIKit

class SimilarMoviesTableViewCell: UITableViewCell {
    static let identifier = "similar"
    
    var headlineTitle = ""{
        didSet{
            headline.text = headlineTitle
        }
    }
    var movies = [Movie](){
        didSet{
            collectionView.movies = movies
        }
    }

    @IBOutlet weak var headline:UILabel!
    @IBOutlet weak var container:UIView!{
        didSet{
            setupCollectionView()
        }
    }

    var collectionView:HorizontalCollectionView!
    func setupCollectionView(){
        collectionView = HorizontalCollectionView()
        container.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])

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
