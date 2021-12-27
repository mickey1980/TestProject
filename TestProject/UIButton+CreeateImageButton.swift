//
//  NextButton.swift
//  Instagram Clone
//
//  Created by Development on 04/12/2021.
//

import Foundation
import UIKit

public var NextButtonHeight: CGFloat = 40

extension UIButton {
    class func createButton(title: String) -> UIButton {
        let control = UIButton(type: .system)
        control.configuration = .filled()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.setTitle(title, for: .normal)
        return control
    }
    class func setImage(with image: UIImage?) -> UIButton {
        let control = UIButton(type: .system)
        control.setImage(image, for: .normal)
        control.tintColor = .label
        control.imageView?.contentMode = .scaleAspectFit
        control.clipsToBounds = true
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
}

