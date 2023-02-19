//
//  VisionClassifier.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//

import Foundation
import CoreML
import Vision
import UIKit

class VisionClassifier {
    
    private let model: VNCoreMLModel
    private var completion: (String) -> Void = { _ in}
    
    private lazy var requsets: [VNCoreMLRequest] = {
        
        let requset = VNCoreMLRequest(model: model) { (requset, error) in
        
        guard let results = requset.results as? [VNClassificationObservation] else {
            return
        }
        
        if !results.isEmpty {
            if let result = results.first {
                self.completion(result.identifier)
            }
        }
    }
    
        requset.imageCropAndScaleOption = .centerCrop
        return [requset]
    
}()

    init?(mlModel:MLModel){
        if let model = try? VNCoreMLModel(for: mlModel){
            self.model = model
        } else {
            return nil
        }
    }
    
    func classify(_ image:UIImage, completion: @escaping (String) -> Void){
        
        self.completion = completion
        
        DispatchQueue.global().async {
            
            guard let cjImage = image.cgImage else {
                return
            }
            
            let handler = VNImageRequestHandler(cgImage: cjImage, options: [:])
            
            do {
                try handler.perform(self.requsets)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
