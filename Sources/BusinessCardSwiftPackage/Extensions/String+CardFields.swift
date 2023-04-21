import Foundation


public extension String {
    func isCompanyName() -> Bool {
        return companyNameMarkerWords.filter { word in
            self.lowercased().contains(word)
        }.count > 0
    }

    func isContainsProfessionPosition() -> Bool {
        return professionsNameMarkerWords.filter { word in
            self.lowercased().contains(word.lowercased())
        }.count > 0
    }

    func findZip() -> String {
        var zipCode = ""

        let regex = try! NSRegularExpression(pattern: "\\b\\d{5}(?:[ -]\\d{4})?\\b")
        let nsString: NSString = self as NSString
        let matches = regex.matches(in: nsString as String, options: [], range: NSMakeRange(0, nsString.length))
        for match in matches {
            zipCode = nsString.substring(with: match.range)
        }
        return zipCode
    }

    func isStringAddress(zipCode: String) -> Bool {
        let containPlaces = addressPlacesMarkerWords.filter { word in
            self.lowercased().contains(word.lowercased())
        }.count > 0

        let containAbbrevations = addressAbbrevationsMarkerWords.filter { word in
            self.suffix(3).lowercased().contains(word.lowercased())
        }.count > 0

        let containTowns = townsAbbrevationsMarkerWords.filter { word in
            self.lowercased().contains(word.lowercased())
        }.count > 0

        return self.contains(zipCode) || containTowns || containAbbrevations || containPlaces
    }

    func isStringWebsite() -> Bool {
        return self.starts(with: "www")
        || self.hasSuffix(".COM")
        || self.starts(with: "https")
        || self.starts(with: "http")
        || self.hasSuffix(".com")
        && !self.contains("@")
        && !self.contains("Email:")
        && !self.contains("email:")
        || self.hasSuffix(".net")
        && !self.contains("@")
        || self.hasSuffix(".edu")
        && !self.contains("@")
    }

    func isFax() -> Bool  {
        return self.starts(with: "F.")
        || self.starts(with: "f.")
        || self.starts(with: "Fax")
        || self.starts(with: "Fax:")
        || self.starts(with: "fax.")
        || self.starts(with: "FAX")
        || self.starts(with: "fax")
    }

    func isStringEmail() -> Bool {
        return self.contains("@")
        && !self.contains("www")
        || self.lowercased().contains("email")
    }

    func isStringName() -> Bool {
        let containCompanyName = self.isCompanyName()
        let containsNumberic = self.rangeOfCharacter(from: numericCharSet) != nil
        let containsSpecialChars = self.rangeOfCharacter(from: newCharSet) != nil
        let containsProfessions = professionsNameMarkerWords.filter { word in
            word.lowercased() == self.lowercased()
        }.count > 0
        let containsUtilWords = utilsMarkerWords.filter { word in
            word.lowercased() == self.lowercased()
        }.count > 1

        return self.contains(" ")
        && self.count > 1
        && !containsNumberic
        && !containsProfessions
        && !containsUtilWords
        && !containsSpecialChars
        && !containCompanyName
    }

    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
                , leftRange.upperBound <= rightRange.lowerBound
        else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }

    func extractPhoneNumber() -> (Range<String.Index>, String)? {
        // Do a first pass to find any substring that could be a US phone
        // number. This will match the following common patterns and more:
        // xxx-xxx-xxxx
        // xxx xxx xxxx
        // (xxx) xxx-xxxx
        // (xxx)xxx-xxxx
        // xxx.xxx.xxxx
        // xxx xxx-xxxx
        // xxx/xxx.xxxx
        // +1-xxx-xxx-xxxx
        // Note that this doesn't only look for digits since some digits look
        // very similar to letters. This is handled later.
        let pattern = #"""
        (?x)                    # Verbose regex, allows comments
        (?:\+1-?)?                # Potential international prefix, may have -
        [(]?                    # Potential opening (
        \b(\w{3})                # Capture xxx
        [)]?                    # Potential closing )
        [\ -./]?                # Potential separator
        (\w{3})                    # Capture xxx
        [\ -./]?                # Potential separator
        (\w{4})\b                # Capture xxxx
        """#
        guard let range = self.range(of: pattern, options: .regularExpression, range: nil, locale: nil) else {
            // No phone number found.
            return nil
        }
        
        // Potential number found. Strip out punctuation, whitespace and country
        // prefix.
        var phoneNumberDigits = ""
        let substring = String(self[range])
        let nsrange = NSRange(substring.startIndex..., in: substring)
        do {
            // Extract the characters from the substring.
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if let match = regex.firstMatch(in: substring, options: [], range: nsrange) {
                for rangeInd in 1 ..< match.numberOfRanges {
                    let range = match.range(at: rangeInd)
                    let matchString = (substring as NSString).substring(with: range)
                    phoneNumberDigits += matchString as String
                }
            }
        } catch {
            print("Error \(error) when creating pattern")
        }
        
        // Must be exactly 10 digits.
        guard phoneNumberDigits.count == 10 else {
            return nil
        }
        
        // Substitute commonly misrecognized characters, for example: 'S' -> '5' or 'l' -> '1'
        var result = ""
        let allowedChars = "0123456789"
        for var char in phoneNumberDigits {
            char = char.getSimilarCharacterIfNotIn(allowedChars: allowedChars)
            guard allowedChars.contains(char) else {
                return nil
            }
            result.append(char)
        }
        return (range, result)
    }
}
