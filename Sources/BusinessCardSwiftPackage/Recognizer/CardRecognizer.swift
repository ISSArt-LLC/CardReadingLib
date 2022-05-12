import Foundation
import Vision
import SwiftUI
import UIKit

@available(macOS 10.15, *)
public class CardRecognizer {
    public var userDataCompletion: DataRecognitionCallback?
    
    private let cardDetector = CardDetector()
    private var sourceImage: UIImage? = nil
    
    public init() {
        cardDetector.detectionCallback = onCardDetectionResult
    }
    
    public func recognizeTextOnImage(scannedImage: UIImage) {
        sourceImage = scannedImage
        cardDetector.detectRectangle(sourceImage: scannedImage)
    }
    
    public func recognizeTextOnCard(scannedImage: UIImage) {
        sourceImage = scannedImage
        recognizeText()
    }

    private func onCardDetectionResult(cardImage: UIImage?, error: RecognizeException?) {
        if cardImage != nil {
            sourceImage = cardImage
        }
        recognizeText()
    }
    
    private func recognizeText() {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            guard let cgImage = self.sourceImage?.cgImage else { return }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            do {
                let textItem = TextItem()
                try requestHandler.perform([self.getTextRecognitionRequest(with: textItem)])
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getTextRecognitionRequest(with textItem: TextItem) -> VNRecognizeTextRequest {
        var tempArrOfStrings = [String]()
        
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            observations.forEach { observation in
                guard let recognizedText = observation.topCandidates(1).first else { return }
                textItem.text += recognizedText.string
                textItem.text += "\n"
                                                
                tempArrOfStrings.append(recognizedText.string)
            }
            
            var dataResult = UserData.parseFromStrings(array: tempArrOfStrings, scannedImage: self.sourceImage!)
            self.userDataCompletion?(dataResult)
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        return request
    }
}



