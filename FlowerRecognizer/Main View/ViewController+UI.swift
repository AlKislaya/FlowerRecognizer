//
//  Constants.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 19.01.26.
//

import UIKit

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    struct Constants {
        static let smthWentWrong = "Something went wrong:("
        static let unknownSpecies = "Unknown species"
        static let analyzingPhoto = "Analyzing the photo..."
        struct UI {
            static let FlowersImagesCollectionViewCell = "FlowersImagesCollectionViewCell"
            static let FlowersImagesReusableCell = "FlowersImagesReusableCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(UINib(nibName: Constants.UI.FlowersImagesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.UI.FlowersImagesReusableCell)
    }
    
    func showErrorLabels() {
        updatePrediction(with: Constants.smthWentWrong)
        updateTitle(with: Constants.unknownSpecies)
    }
    
    func updatePrediction(with text: String) {
        DispatchQueue.main.async {
            self.predictionLabel.text = text
        }
    }
    
    func updateTitle(with text: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = text
        }
    }
    
    func appendImagesCollection(with image: UIImage) {
        DispatchQueue.main.async {
            self.images.append(image)
        }
    }
    
    func clearImagesCollection() {
        DispatchQueue.main.async {
            self.images.removeAll()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.UI.FlowersImagesReusableCell, for: indexPath) as! FlowersImagesCollectionViewCell
        
        cell.configure(with: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}
