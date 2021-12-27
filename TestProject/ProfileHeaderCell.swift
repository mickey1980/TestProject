//
//  ProfileHeaderCell.swift
//  Instagram Clone
//
//  Created by HSBC on 22/12/2021.
//

import Foundation
import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileHeaderCell"
    
    var titleStack: UIStackView! = nil
    
    private let profileImageView: UIImageView = {
        let control = UIImageView()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.contentMode = .scaleAspectFill
        control.clipsToBounds = true
        control.image = UIImage(named: "taylor")
        return control
    }()
    
    let nameLabel: UILabel = {
        let control = UILabel()
        control.translatesAutoresizingMaskIntoConstraints = false

        control.numberOfLines = 0
        control.textAlignment = .left
        return control
    }()
    
    let postsLabel: UILabel = {
        let control = UILabel()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.textColor = .label
        control.numberOfLines = 0
        control.textAlignment = .center
        return control
    }()

    let followesLabel: UILabel = {
        let control = UILabel()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.textColor = .label
        control.numberOfLines = 0
        control.textAlignment = .center
        return control
    }()

    let followingLabel: UILabel = {
        let control = UILabel()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.textColor = .label
        control.numberOfLines = 0
        control.textAlignment = .center
        return control
    }()
    
    let titleLabel: UILabel = {
        let control = UILabel()
        control.translatesAutoresizingMaskIntoConstraints = false
        var name = AttributedString("taylorswift")
        name.font = .systemFont(ofSize: 16, weight: .bold)
        control.attributedText = NSAttributedString(name)
        control.textColor = .label
        control.textAlignment = .right
        return control
    }()

    
    private let verifiedImage: UIImageView = {
        let control = UIImageView()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.image = UIImage(named: "verified")
        control.contentMode = .scaleAspectFit
        return control
    }()
    
    private let verifiedView: UIView = {
        let control = UIView()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func configure(with data: ProfileHeaderData) {
        var name = AttributedString(data.name)
        name.font = .systemFont(ofSize: 14, weight: .bold)
        self.nameLabel.attributedText = NSAttributedString(name)
        
        
        var postsCount = AttributedString("\(data.posts)\n")
        postsCount.font = .systemFont(ofSize: 16, weight: .bold)
        var posts = AttributedString("Posts")
        posts.font = .systemFont(ofSize: 14)
        postsCount.append(posts)
        self.postsLabel.attributedText = NSAttributedString(postsCount)
        
        
        var followersCount = AttributedString("\(data.followers) M\n")
        followersCount.font = .systemFont(ofSize: 16, weight: .bold)
        var followers = AttributedString("Followers")
        followers.font = .systemFont(ofSize: 14)
        followersCount.append(followers)
        self.followesLabel.attributedText = NSAttributedString(followersCount)
        
        var followingCount = AttributedString("\(data.following)\n")
        followingCount.font = .systemFont(ofSize: 16, weight: .bold)
        var following = AttributedString("Following")
        following.font = .systemFont(ofSize: 14)
        followingCount.append(following)
        self.followingLabel.attributedText = NSAttributedString(followingCount)
    }

    private func setup() {
        //self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.profileImageView)
        self.profileImageView.layer.cornerRadius = 40
        self.profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.layoutMargins.right).isActive = true
        self.profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.addSubview(self.nameLabel)
        self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: self.layoutMargins.top).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.layoutMargins.right).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        let postStats: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [self.postsLabel, self.followesLabel, self.followingLabel,])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 4
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins.top = 0
            stack.layoutMargins.right = 0
            stack.layoutMargins.left = 0
            stack.layoutMargins.bottom = 0
            return stack
        }()
        
        self.addSubview(postStats)
        
        postStats.topAnchor.constraint(equalTo: self.profileImageView.topAnchor).isActive = true
        postStats.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 44).isActive = true
        postStats.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.layoutMargins.right).isActive = true
        postStats.bottomAnchor.constraint(equalTo: self.profileImageView.bottomAnchor).isActive = true
        
        self.verifiedView.addSubview(verifiedImage)
        self.verifiedImage.topAnchor.constraint(equalTo: verifiedView.topAnchor).isActive = true
        self.verifiedImage.leadingAnchor.constraint(equalTo: verifiedView.leadingAnchor).isActive = true
        self.verifiedImage.bottomAnchor.constraint(equalTo: verifiedView.bottomAnchor).isActive = true
        self.verifiedImage.widthAnchor.constraint(equalToConstant: 16).isActive = true

        self.titleStack = {
            let stack = UIStackView(arrangedSubviews: [titleLabel, verifiedView])
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .equalCentering
            stack.spacing = 4
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins.top = 0
            stack.layoutMargins.right = 0
            stack.layoutMargins.left = 0
            stack.layoutMargins.bottom = 0
            return stack
        }()
        
        titleStack.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
