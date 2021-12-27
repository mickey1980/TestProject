//
//  DemoViewController.swift
//  Instagram Clone
//
//  Created by HSBC on 22/12/2021.
//

import Foundation
import UIKit

struct ProfileHeaderData: Hashable {
    let name: String
    let posts: Int
    let followers: Int
    let following: Int
}

struct Photo {
    let id = UUID()
    let image: UIImage
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Photo {
    static var demoPhotos: [Photo] {
        let names = (1...8).map({ "photo\($0)" })
        return names.map({ Photo(image: UIImage(named: $0)!) })
    }
}

class DemoViewController: UIViewController {
        
    var collectionView: UICollectionView!
    
    private var headerData: ProfileHeaderData {
        return ProfileHeaderData(name: "Taylor Swift", posts: 199, followers: 199, following: 199)
    }
    
    typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    private var datasource: Datasource!
    
    enum Section: Hashable {
        case main
        case header
    }

    enum Item: Hashable {
        case header(ProfileHeaderData)
        case main(Int)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configureDataSource()
    }
    
    
    private func createHeaderSection() -> NSCollectionLayoutSection {
        let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), subitems: [headerItem])
        
        return NSCollectionLayoutSection(group: headerGroup)
    }
     
    private func createMainSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))

        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    
    private func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = datasource.snapshot().sectionIdentifiers[index]
        
        switch section {
        case .header:
            return createHeaderSection()
        case .main:
            return createMainSection()
        }
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: sectionFor(index:environment:))
    }
    
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        
        self.collectionView.register(ProfileHeaderCell.self, forCellWithReuseIdentifier: ProfileHeaderCell.reuseIdentifier)
        self.collectionView.register(ProfileButtonsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileButtonsHeaderView.reuseIdentifier)
        self.collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.reuseIdentifier)
        self.collectionView.register(PostsScreenCell.self, forCellWithReuseIdentifier: PostsScreenCell.reuseIdentifier)
        switch item {
        case .header(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderCell.reuseIdentifier, for: indexPath) as! ProfileHeaderCell
            cell.configure(with: data)
            return cell
        case .main:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsScreenCell.reuseIdentifier, for: indexPath) as! PostsScreenCell
            return cell

        }
    }
       
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileButtonsHeaderView.reuseIdentifier, for: indexPath)
    }
    
    private func configureDataSource() {
        self.datasource = Datasource(collectionView: self.collectionView, cellProvider: self.cell(collectionView:indexPath:item:))
        
        self.datasource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            return self.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        self.datasource.apply(self.snapshot())

    }

    private func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.header, .main])
        snapshot.appendItems([.header(headerData)], toSection: .header)
        snapshot.appendItems(Array(0..<10).map({ Item.main($0)}), toSection: .main)
        return snapshot
    }
    
    private func setup() {
        self.view.backgroundColor = .systemBackground
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .systemBackground
        //self.collectionView.isScrollEnabled = false
        self.view.addSubview(collectionView)
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}


