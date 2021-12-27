//
//  PostsContentCell.swift
//  Instagram Clone
//
//  Created by HSBC on 14/12/2021.
//
import UIKit

class PostsContentCell: UICollectionViewCell {

    private let contentImage: UIImageView = {
        let control = UIImageView()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.contentMode = .scaleAspectFill
        control.clipsToBounds = true
        control.layer.borderWidth = 0.2
        control.layer.borderColor = UIColor.black.cgColor
        control.image = UIImage(named: "f1")
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }

}

extension PostsContentCell {
    func configure() {
        self.backgroundColor = .systemBackground
        self.contentView.addSubview(self.contentImage)
        self.contentImage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.contentImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.contentImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.contentImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
}
