//
//  ViewController+PHPickerController.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 16.01.26.
//

import UIKit
import PhotosUI

extension ViewController : PHPickerViewControllerDelegate {
    var pickerController: PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = PHPickerFilter.images
        config.selectionLimit = 1
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = self
        
        return controller
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let pickedImage = results.first else {
            print("No image selected")
            return
        }
        
        pickedImage.itemProvider.loadObject(ofClass: UIImage.self) { object,error in
            if let error = error {
                print("Photo picker error: \(error)")
                return
            }
            
            guard let image = object as? UIImage else {
                fatalError("The Photo Picker's image isn't a/n \(UIImage.self) instance.")
            }
            
            self.onUserPickedImage(image)
        }
    }
}
