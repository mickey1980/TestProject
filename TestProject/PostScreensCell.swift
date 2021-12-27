//
//  PostsScreenContainerCell.swift
//  Instagram Clone
//
//  Created by HSBC on 14/12/2021.
//

import UIKit

class PostsScreenCell: UICollectionViewCell {
    static let reuseIdentifier = "PostsScreenCell"

    enum Section: CaseIterable {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.configureDataSource()
    
    }

    func configure() {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .blue
        //self.collectionView.isScrollEnabled = false
        self.addSubview(collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //self.collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureDataSource() {
        
        let postsScreenContentCell = UICollectionView.CellRegistration<PostsContentCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
                return collectionView.dequeueConfiguredReusableCell(using: postsScreenContentCell, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<32))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
}
