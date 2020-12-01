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

        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 5).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(joinedDateLabel)
        stackView.addArrangedSubview(hireableLabel)

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()

    public var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var joinedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var hireableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hireable"
        label.isHidden = true
        return label
    }()
}
