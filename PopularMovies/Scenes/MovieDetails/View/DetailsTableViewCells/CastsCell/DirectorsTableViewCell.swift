//
//  DirectorsTableViewCell.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import UIKit

class DirectorsTableViewCell: UITableViewCell {
    static let identifier = "directors"
    var directors = [MovieCrew](){
        didSet{
            collectionView.items = directors.compactMap { director in
                guard let title = director.name, let image = director.profilePath else {
                    return nil
                }
                return CollectionViewItem(image: image, title: title)
            }
        }
    }

    var collectionView:HorizontalCollectionView!
    func setupCollectionView(){
        collectionView = HorizontalCollectionView()
        addSubview(collectionView)
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
        setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
