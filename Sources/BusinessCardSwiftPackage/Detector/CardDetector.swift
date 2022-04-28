import Foundation
import UIKit
import Vision

public class CardDetector {
    private var image: UIImage? = nil
    
    public var detectionCallback: CardDetectionCallback? = nil
    
    public init() {}
    
    public func detectRectangle(sourceImage: UIImage) {
        if let cgImage = sourceImage.cgImage {
            image = sourceImage
            processCGImage(cgImage)
        } else {
            detectionCallback?(nil, RecognizeException.imageIsNull)
        }
    }
    
    private func processCGImage(_ cgImage: CGImage) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            let request = VNDetectRectanglesRequest(completionHandler: self?.handleDetectedRectangle)
            
            request.minimumAspectRatio = 0.0
            request.maximumAspectRatio = 1.0
            request.maximumObservations = 1
            
            let orientation = CGImagePropertyOrientation.init(self!.image!.imageOrientation)
            let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)
            
            do {
                try imageRequestHandler.perform([request])
            } catch let error {
                self?.detectionCallback?(
                    nil,
                    RecognizeException.detectRectangleRequestError(error.localizedDescription)
                )
            }
        }
    }
    
    func handleDetectedRectangle(request: VNRequest?, error: Error?) {
        if let results = request?.results {
            if let observation = results.first as? VNRectangleObservation {
                let convertedRectangle = observation.boundingBox.fromNormalizedRect(image!.size.width, image!.size.height)
                let scale: CGFloat = 0
                
                UIGraphicsBeginImageContextWithOptions(convertedRectangle.size, false, scale)
                image!.draw(at: CGPoint(x: -convertedRectangle.origin.x, y: -convertedRectangle.origin.y))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                detectionCallback?(newImage, nil)
                
            } else {
                detectionCallback?(nil, RecognizeException.cardRectangleNotFound)
            }
        } else {
            detectionCallback?(nil, RecognizeException.cardReactangleDetectionResultsIsNull)
        }
    }
}
