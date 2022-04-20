
import Foundation
import Vision
import SwiftUI
import UIKit


@available(macOS 10.15, *)
public class CardReader  {
    
    
    @ObservedObject var recognizedContent = RecognizedContent()
    
    public var isSuccess: ((_ text : String) -> ())?
    public var userDataCompletion: ((_ email: [String], _ website: [String], _ areaCode: [String], _ phone: [String], _ expName: [String], _ zipCode: [String], _ adress: [String], _ companyName: String ) -> ())?
    
    
    public func recognizeText(scannedImages: UIImage) {
        let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
        queue.async {
            guard let cgImage = scannedImages.cgImage else { return }
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            do {
                let textItem = TextItem()
                try requestHandler.perform([self.getTextRecognitionRequest(with: textItem)])
                
                DispatchQueue.main.async {
                    self.recognizedContent.items.text = textItem.text
                    
                }
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
                
                self.isSuccess!(textItem.text)
                
                tempArrOfStrings.append(recognizedText.string)
            }
            self.userDataCompletion?(UserData.parseFromStrings(array: tempArrOfStrings).email, UserData.parseFromStrings(array: tempArrOfStrings).website,
                                     UserData.parseFromStrings(array: tempArrOfStrings).areaCode, UserData.parseFromStrings(array: tempArrOfStrings).phone, UserData.parseFromStrings(array: tempArrOfStrings).expectedName, UserData.parseFromStrings(array: tempArrOfStrings).zipCode, UserData.parseFromStrings(array: tempArrOfStrings).adress,
                                     self.findCompanyName(array: tempArrOfStrings))
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        return request
    }
    
    
    public func findCompanyName( array: [String] ) -> String {
        let stringEmail = UserData.parseFromStrings(array: array).email.joined(separator: " ")
        let stringWebsite = UserData.parseFromStrings(array: array).website.joined(separator: " ")
        
        let companyNameMail = stringEmail.between("@", ".") ?? "NO company name"
        let companyNameWeb = stringWebsite.between(".", ".") ?? "NO company name"
        var expCompanies = [String]()
        
        for string in array {
            if string.lowercased().contains(".inc")
                || string.lowercased().contains(" inc") || string.lowercased().contains("company") || string.lowercased().contains(" llc") || string.lowercased().contains("college")
            {
                expCompanies.append((string))
                expCompanies = Array(Set(expCompanies.filter{$0 != ""}))
                print("expCompanies.count")
                print(expCompanies.count)
                print("HERE1")
                
            }
            
            if expCompanies.count == 0 && string.lowercased().contains(companyNameMail) && !string.contains("@") && !string.contains("www.") && !string.contains(".com"){
                expCompanies.append((string))
                expCompanies = Array(Set(expCompanies.filter{$0 != ""}))
                print("HERE2")
            }
            
            
            if  expCompanies.count == 0 && string.lowercased().contains(companyNameWeb)    {
                print("HERE3")
                expCompanies.append((companyNameWeb))
                expCompanies = Array(Set(expCompanies.filter{$0 != ""}))
                print(expCompanies.count)
            }
        }
        return expCompanies.joined(separator: " ").capitalized
    }
}



