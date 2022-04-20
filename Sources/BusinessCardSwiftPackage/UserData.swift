
import Foundation
import SwiftUI


struct UserData {
    
    var email = [""]
    var website = [""]
    var zipCode = [""]
    var areaCode = [""]
    var phone = [""]
    var expectedName = [""]
    var adress = [""]
    var expectedCompanyName = [""]
    var companyName = [""]
    var findCompanyName = [""]
    var emailSubstring = ""
    var websiteSubstring = ""
    
    var tempArr = [String]()
    
    
    static func parseFromStrings(array: [String]) -> UserData {
        
        var tempArea = ""
        
        
        userD.email.removeAll()
        userD.website.removeAll()
        userD.zipCode.removeAll()
        userD.areaCode.removeAll()
        userD.phone.removeAll()
        userD.companyName.removeAll()
        userD.expectedName.removeAll()
        userD.adress.removeAll()
        
        userD.expectedCompanyName =  [String]()
        
        
        
        for string in array {
            let zipTemp = string.findZip(string: string as NSString)
            userD.zipCode.append(zipTemp)
            
            
            string.isStringAddress(string, zipTemp: zipTemp)
            string.findPhone(string: string, tempArea: tempArea)
            string.isStringEmail(string: string)
            string.isStringWebsite(string: string)
            string.isStringName(string: string)
            
        }
        
        userD.companyName = array.difference(from: userD.expectedCompanyName)
        print(" userD.companyName")
        
        print(userD.companyName)
        
        if userD.emailSubstring == userD.websiteSubstring
        {
            userD.findCompanyName.append(userD.websiteSubstring)
            userD.findCompanyName = userD.findCompanyName.filter{$0 != ""}
        } else {
            
            
            for string in userD.companyName {
                
                if string.lowercased().contains(userD.emailSubstring.lowercased())
                    || string.lowercased().contains(userD.websiteSubstring.lowercased())
                {
                    userD.findCompanyName.append(string)
                    userD.findCompanyName = userD.findCompanyName.filter{$0 != ""}
                }
            }
            
        }
        return userD
    }
}

var userD = UserData()





