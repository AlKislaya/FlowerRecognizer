//
//  Constants.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 19.01.26.
//

import UIKit

extension ViewController {
    struct Constants {
        static let smthWentWrong = "Something went wrong:("
        static let unknownSpecies = "Unknown species"
        static let analyzingPhoto = "Analyzing the photo..."
    }
    
    func showErrorLabels() {
        updatePrediction(with: Constants.smthWentWrong)
        updateTitle(with: Constants.unknownSpecies)
    }
    
    func updateImageView(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func updatePrediction(with text: String?) {
        DispatchQueue.main.async {
            self.predictionLabel.text = text ?? "Smth went wrong"
        }
    }
    
    func updateTitle(with text: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = text
        }
    }
}
