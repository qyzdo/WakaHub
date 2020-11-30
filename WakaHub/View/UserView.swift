//
//  UserView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit

final class UserView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        let safeArea = self.layoutMarginsGuide

        addSubview(avatarView)
        avatarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        avatarView.heightAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        let image = UIImage(named: "Logo")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        imageView.image = tintedImage
        imageView.tintColor = UIColor(named: "LogoColor")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
