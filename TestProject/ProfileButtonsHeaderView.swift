//
//  ProfilePhotosHeaderView.swift
//  Instagram Clone
//
//  Created by HSBC on 22/12/2021.
//

import Foundation
import UIKit

class ProfileButtonsHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "ProfilePhotosHeaderView"
    
    let buttons: [UIButton] = [UIButton.setImage(with: UIImage(systemName: "squareshape.split.3x3")),
                               UIButton.setImage(with: UIImage(named: "reels")),
                               UIButton.setImage(with: UIImage(systemName: "play")),
                               UIButton.setImage(with: UIImage(systemName: "music.note")),
                               UIButton.setImage(with: UIImage(named: "sparkle")),
                               UIButton.setImage(with: UIImage(systemName: "person.crop.circle"))]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.setup()
    }
    
    private func setup() {
        let mainStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: buttons)
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 8
            stack.isLayoutMarginsRelativeArrangement = true
            stack.layoutMargins.top = 0
            stack.layoutMargins.right = 0
            stack.layoutMargins.left = 0
            stack.layoutMargins.bottom = 0
            return stack
        }()
        
        self.addSubview(mainStack)
        mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
