import Foundation

public enum RecognizeException: Error {
    case cardReactangleDetectionResultsIsNull
    case cardRectangleNotFound
    case imageIsNull
    case detectRectangleRequestError(String)
}
