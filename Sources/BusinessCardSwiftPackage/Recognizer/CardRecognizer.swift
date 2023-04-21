import Foundation
import Vision
import SwiftUI
import UIKit

@available(macOS 10.15, *)
public class CardRecognizer {
    public var userDataCompletion: DataRecognitionCallback?
    
    private let cardDetector = CardDetector()
    private let stringsParser = RecognizedStringsParser()
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
        queue.async { [weak self] in
            guard let cgImage = self?.sourceImage?.cgImage else { return }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            guard let recognitionRequest = self?.getTextRecognitionRequest() else {
                self?.userDataCompletion?(nil)
                return
            }

            do {
                try requestHandler.perform([recognitionRequest])
            } catch {
                print(error.localizedDescription)
                self?.userDataCompletion?(nil)
            }
        }
    }
    
    private func getTextRecognitionRequest() -> VNRecognizeTextRequest {
        var tempArrOfStrings = [String]()
        
        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            observations.forEach { observation in
                guard let recognizedText = observation.topCandidates(1).first else { return }
                tempArrOfStrings.append(recognizedText.string)
            }
            print(tempArrOfStrings)
            //var dataResult = UserData.parseFromStrings(array: tempArrOfStrings, scannedImage: self.sourceImage!)
            let dataResult = self.stringsParser.parseStrings(strings: tempArrOfStrings)
            dataResult.image = self.sourceImage!
            self.userDataCompletion?(dataResult)
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        return request
    }
}



