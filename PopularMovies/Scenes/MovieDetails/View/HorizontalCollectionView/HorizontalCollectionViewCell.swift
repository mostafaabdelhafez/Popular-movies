//
//  HorizontalCollectionViewCell.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    static let identifier = "HorizontalCollectionViewCell"

    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!

    func configureUI(item:CollectionViewItem){
        if let url = URL(string: item.image){
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url)
            titleLabel.text = item.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
