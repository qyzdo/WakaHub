//
//  CreateAttributedString.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/12/2020.
//

import UIKit

extension String {
    func createTwoPartsAttributedString(secondPart: String) -> NSMutableAttributedString {
        let firstPartFont = UIFont.systemFont(ofSize: 15)
        let firstPartAttributes = [NSAttributedString.Key.font: firstPartFont]
        let firstPartAttributed = NSAttributedString(string: self, attributes: firstPartAttributes)

        let secondPartFont = UIFont.boldSystemFont(ofSize: 16)
        let secondPartAttributes = [NSAttributedString.Key.font: secondPartFont]
        let secondPartAttributed = NSAttributedString(string: secondPart, attributes: secondPartAttributes)

        let combinedStrings = NSMutableAttributedString()
        combinedStrings.append(firstPartAttributed)
        combinedStrings.append(NSAttributedString(string: " "))
        combinedStrings.append(secondPartAttributed)

        return combinedStrings
    }

    func setupLabelWithImage(imageName: String) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)

        let imageOffsetY: CGFloat = -5.0
        if let image = imageAttachment.image {
            imageAttachment.bounds = CGRect(x: -1, y: imageOffsetY, width: image.size.width, height: image.size.height)
        }

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: self)
        completeText.append(textAfterIcon)

        return completeText
    }
}
