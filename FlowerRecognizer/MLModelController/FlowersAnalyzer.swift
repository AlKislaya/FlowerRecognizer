//
//  ImagePredictor.swift
//  FlowerRecognizer
//
//  Created by Alexandra on 16.01.26.
//

import Vision
import UIKit

class FlowersAnalyzer {
    typealias RequestHandler = (_ category: String?, _ error: Error?) -> Void
    
    private var requestHandlers = [VNRequest: RequestHandler]()
    
    private static func createVNModel() -> VNCoreMLModel {
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("Could not create model")
        }
        
        return model
    }
    
    private static let vnModel = createVNModel()
    
    public func analyze(for image: UIImage, completionHandler: @escaping RequestHandler) throws {
        guard let cgUserImage = image.cgImage else {
            fatalError("Image doesn't have underlying CGImage.")
        }
        
        let request = VNCoreMLRequest(model: FlowersAnalyzer.vnModel, completionHandler: onRequestCompleted)
        requestHandlers[request] = completionHandler
        
        let handler = VNImageRequestHandler(cgImage: cgUserImage)
        try handler.perform([request])
    }
    
    private func onRequestCompleted(_ request: VNRequest, error: Error?) {
        guard let completionHandler = requestHandlers.removeValue(forKey: request) else {
            return
        }
        
        if let error = error {
            completionHandler(nil, error)
            return
        }
        
        if let result = request.results?.first as? VNClassificationObservation {
            completionHandler(result.identifier, nil)
        } else {
            let noResultError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Model didn't return any result, please try another image"])
            
            completionHandler(nil, noResultError)
        }
    }
}
