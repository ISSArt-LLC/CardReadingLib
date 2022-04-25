
import Foundation
import Vision
import UIKit

class DetectClassRectangle {
    
    var image: UIImage?
    var cgIm: CGImage?
    
    private func completedVisionRequest(_ request: VNRequest?, error: Error?) {
        guard let rectangles = request?.results as? [VNRectangleObservation] else {
            guard let error = error else { return }
            print("Error: Rectangle detection failed - Vision request returned an error. \(error.localizedDescription)")
            return
        }
        
        
        guard let rectangle = rectangles.first else {
            print("Not read")
            return}
        
//        self.completion?(rectangle.boundingBox.minX, rectangle.boundingBox.minY, rectangle.boundingBox.width, rectangle.boundingBox.height)
//
//        recognizeText(from: cgIm, x: rectangle.boundingBox.minX, y: rectangle.boundingBox.minY, width: rectangle.boundingBox.width, height: rectangle.boundingBox.height )
            
    }

    
    func detectRectangle() {
       guard  let inputImage = image else {return}
       
        let cg =  (CIImage(image: inputImage))
       guard let cgImage = cg else {
           print("No photo")
           return}
        cgIm = cgImage.cgImage
        
        
       let request = VNDetectRectanglesRequest(
           completionHandler: completedVisionRequest(_:error:))
       let requestHandler = VNImageRequestHandler(
           ciImage: cgImage,
           orientation: CGImagePropertyOrientation(inputImage.imageOrientation),
           options: [:])
       
        request.minimumSize = 0.4
        request.minimumAspectRatio = 0.5
       
       
       DispatchQueue.global().async {
           do {
               try requestHandler.perform([request])
           } catch {
               print("Error: Rectangle detection failed - vision requesr failed")
           }
       }
   }
   
}

