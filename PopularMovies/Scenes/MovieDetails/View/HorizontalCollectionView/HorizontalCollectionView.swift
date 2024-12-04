//
//  HorizontalCollectionView.swift
//  PopularMovies
//
//  Created by jobzella on 12/4/24.
//

import UIKit

import UIKit

class HorizontalCollectionView: UIView {
    
    var collectionView: UICollectionView!
    
    var items = [CollectionViewItem](){
        didSet{
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    // Setup collection view layout and appearance
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 120, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        
        let horizontalCollection = UINib(nibName: "HorizontalCollectionViewCell", bundle: nil)

        collectionView.register(horizontalCollection.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
}
extension HorizontalCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as! HorizontalCollectionViewCell
        cell.configureUI(item: CollectionViewItem(image:items[indexPath.item].image, title: items[indexPath.item].title ))
        
        return cell
    }
}
