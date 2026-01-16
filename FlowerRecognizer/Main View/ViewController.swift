//
//  ViewController.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 15.01.26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    func onUserPickedImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    @IBAction func onCameraTapped(_ sender: UIBarButtonItem) {
        present(pickerController, animated: true)
    }
}
