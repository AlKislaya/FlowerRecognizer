//
//  ViewController.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 15.01.26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let flowersAnalyzer = FlowersAnalyzer()
    
    func onUserPickedImage(_ image: UIImage) {
        updateImageView(image)
        updatePrediction("Making predictions for the photo...")
        
        do {
            try flowersAnalyzer.analyze(for: image, completionHandler: onImageAnalyzed)
        } catch {
            updatePrediction("Smth went wrong")
        }
    }
    
    func onImageAnalyzed(category: String?, error: Error?) {
        if let error = error {
            updatePrediction(error.localizedDescription)
            return
        }
        
        updatePrediction(category ?? "Smth went wrong")
    }
    
    func updateImageView(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func updatePrediction(_ text: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = text
        }
    }

    @IBAction func onCameraTapped(_ sender: UIBarButtonItem) {
        present(pickerController, animated: true)
    }
}
