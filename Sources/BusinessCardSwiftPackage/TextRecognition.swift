import SwiftUI
import Vision
import UIKit

@available(iOS 13.0, *)
@available(macOS 10.15, *)

public struct TextRecognition {
    public var scannedImages: [UIImage]
    @ObservedObject var recognizedContent: RecognizedContent
    public var didFinishRecognition: () -> Void
   
    public init(scannedImages: [UIImage], recognizedContent: RecognizedContent, didFinishRecognition: @escaping ()-> Void ){
        self.scannedImages = scannedImages
        self.recognizedContent = recognizedContent
        self.didFinishRecognition = didFinishRecognition
    }
    
//   public func recognizeText() {
//        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
//        queue.async {
//            for image in scannedImages {
//                guard let cgImage = image.cgImage else { return }
//                
//                let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//                
//                do {
//                    let textItem = TextItem()
//                    try requestHandler.perform([getTextRecognitionRequest(with: textItem)])
//                    
//                    DispatchQueue.main.async {
//                        recognizedContent.items.text = textItem.text
//                    }
//                } catch {
//                    print(error.localizedDescription)
//                }
//                
//                DispatchQueue.main.async {
//                    didFinishRecognition()
//                }
//            }
//        }
//    }
//    
//    
//    private func getTextRecognitionRequest(with textItem: TextItem) -> VNRecognizeTextRequest {
//        var tempArrOfStrings = [String]()
//        
//        let request = VNRecognizeTextRequest { request, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            
//            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
//            
//            observations.forEach { observation in
//                guard let recognizedText = observation.topCandidates(1).first else { return }
//                textItem.text += recognizedText.string
//                textItem.text += "\n"
//                
//                tempArrOfStrings.append(recognizedText.string)
//            }
//        }
//        
//        
//        request.recognitionLevel = .accurate
//        request.usesLanguageCorrection = true
//        
//        return request
//    }
}
