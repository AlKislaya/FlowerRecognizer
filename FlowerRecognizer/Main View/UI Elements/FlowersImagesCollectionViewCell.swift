//
//  FlowersImagesCollectionViewCell.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 19.01.26.
//

import UIKit

class FlowersImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    public func configure(with image: UIImage) {
        imageView.image = image
    }
}
