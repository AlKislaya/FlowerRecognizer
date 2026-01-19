//
//  ViewController.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 15.01.26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let flowersAnalyzer = FlowersAnalyzer()
    let wikiArticleService = WikiArticleService()
    
    func onUserPickedImage(_ image: UIImage) {
        updateImageView(with: image)
        updatePrediction(with: Constants.analyzingPhoto)
        updateTitle(with: "")
        
        do {
            try flowersAnalyzer.analyze(for: image, completionHandler: onImageAnalyzed)
        } catch {
            print(error)
            showErrorLabels()
        }
    }
    
    func onImageAnalyzed(category: String?, error: Error?) {
        guard let category = category, category != "" else {
            if let error = error {
                print(error)
            }
            showErrorLabels()
            return
        }
        
        updateTitle(with: category)
        
        Task.detached {
            do {
                let (result, wikiError) = try await self.wikiArticleService.fetchArticle(title: category)
                if let article = result {
                    await self.updatePrediction(with: article)
                } else {
                    if let wikiError = wikiError {
                        print(wikiError)
                    }
                    await self.updatePrediction(with: Constants.smthWentWrong)
                }
            } catch {
                print(error)
                await self.updatePrediction(with: Constants.smthWentWrong)
            }
        }
    }

    @IBAction func onCameraTapped(_ sender: UIBarButtonItem) {
        present(pickerController, animated: true)
    }
}
