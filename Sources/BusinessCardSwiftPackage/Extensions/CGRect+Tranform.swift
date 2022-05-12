import Foundation
import UIKit

extension CGRect {
    public func fromNormalizedRect(_ imageWidth: CGFloat, _ imageHeight: CGFloat) -> CGRect {
        let w = self.width * imageWidth
        let h = self.height * imageHeight
        
        let x = self.origin.x * imageWidth
        let y = imageHeight * (1 - self.origin.y) - h
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
