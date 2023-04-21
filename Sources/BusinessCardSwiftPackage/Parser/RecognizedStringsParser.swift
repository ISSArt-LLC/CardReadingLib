//
//  File.swift
//  
//
//  Created by Nikolai Baklanov on 20.04.2023.
//

import Foundation

struct RecognizedStringsParser {
    func parseStrings(strings: [String]) -> UserData {
        let resultData = UserData()
        var alreadyParsedWords: [String] = []

        for string in strings {
            let zipTemp = string.findZip()
            if zipTemp != "" {
                resultData.addZipCode(newZip: zipTemp)
                alreadyParsedWords.append(string)
            }

            if string.isStringAddress(zipCode: zipTemp) {
                resultData.addAddress(newAddress: string)
                alreadyParsedWords.append(string)
            }

            if string.isFax() {
                alreadyParsedWords.append(string)
            } else {
                if let result = string.extractPhoneNumber() {
                    resultData.addPhone(newPhone: result.1)
                    alreadyParsedWords.append(string)

                    let areaCode = String(String(result.1).prefix(3))
                    resultData.addAreaCode(newAreaCode: areaCode)
                }
            }

            if string.isStringEmail() {
                resultData.addEmail(newEmail: string)
                resultData.emailSubstring = string.between("@", ".") ?? ""
                alreadyParsedWords.append(string)
            }

            if string.isStringWebsite() {
                resultData.addWebSite(newWebSite: string)
                resultData.websiteSubstring = string.between(".", ".") ?? ""
                alreadyParsedWords.append(string)
            }

            if string.isStringName() {
                resultData.addName(newName: string)
                alreadyParsedWords.append(string)
            }
        }

        let notParsedWords = strings.difference(from: alreadyParsedWords)
        if resultData.emailSubstring == resultData.websiteSubstring {
            resultData.addAdditionalCompanyNameVariants(newVariant: resultData.websiteSubstring)
        } else {
            for currentString in notParsedWords {
                if currentString.lowercased().contains(resultData.emailSubstring.lowercased())
                || currentString.lowercased().contains(resultData.websiteSubstring.lowercased())
                {
                    resultData.addAdditionalCompanyNameVariants(newVariant: currentString)
                }
            }

        }

        //Mine
        for index in 0..<notParsedWords.count {
            if notParsedWords[index].isCompanyName() {
                resultData.addCompanyName(newName: strings[index])
                return resultData
            }
        }

        if resultData.emailSubstring != "" {
            for searchString in strings {
                if searchString.contains(resultData.emailSubstring) {
                    resultData.addCompanyName(newName: searchString)
                    return resultData
                }
            }
        }

        return resultData
    }
}
