import Foundation


public extension String {
    
    func isStringName(string: String){
        let numericCharSet = CharacterSet.init(charactersIn: "1234567890")
        let newCharSet = CharacterSet.init(charactersIn: "~`@#$%^&*(){}[]<>?_")
        
        
        if string.contains(" ") && string.count > 1
            && !(string.rangeOfCharacter(from: numericCharSet) != nil)
            && !(string.rangeOfCharacter(from: newCharSet) != nil)
            && !string.lowercased().contains("inc.")  && !string.lowercased().contains("corp.") && !string.lowercased().contains("inc")  && !string.lowercased().contains("llc") && !string.lowercased().contains("Inc.")  && !string.lowercased().contains("service") && !string.lowercased().contains("business") && !string.lowercased().contains("president") && !string.lowercased().contains("manager")  && !string.lowercased().contains("sales") && !string.lowercased().contains("office") && !string.lowercased().contains("group")
            && !string.lowercased().contains("advanced")
            && !string.lowercased().contains("center")
            && !string.lowercased().contains("city")
            && !string.lowercased().contains("college")
            && !string.lowercased().contains("specialist")
            && !string.lowercased().contains("associates")
            && !string.lowercased().contains("product")
            && !string.lowercased().contains("senior")
            && !string.lowercased().contains("manufacturer")
            && !string.lowercased().contains("co.")
            && !string.lowercased().contains("department")
            && !string.lowercased().contains("desinger")
            && !string.lowercased().contains("designer")
            && !string.lowercased().contains("director")
            && !string.lowercased().contains("division")
            && !string.lowercased().contains("electric")
            && !string.lowercased().contains("suply")
            && !string.lowercased().contains("fund")
            && !string.lowercased().contains("done")
            && !string.lowercased().contains("light")
            && !string.lowercased().contains("wholesale")
            && !string.lowercased().contains("consultant")
            && !string.lowercased().contains(".com")
            && !string.lowercased().contains("www.")
            && !string.lowercased().contains("save")
            && !string.lowercased().contains("state")
            && !string.lowercased().contains("states")
            && !string.lowercased().contains("southern")
            && !string.lowercased().contains("global")
            
        {
            userD.expectedName.append(string)
            userD.expectedCompanyName.append(string)
            
        }
    }
    func isStringWebsite(string: String){
        if string.starts(with: "www") || string.hasSuffix(".COM") || string.starts(with: "https") || string.starts(with: "http") || string.hasSuffix(".com") && !string.contains("@") && !string.contains("Email:") && !string.contains("email:")    || string.hasSuffix(".net") && !string.contains("@") || string.hasSuffix(".edu") && !string.contains("@")
        {
            
            userD.website.append(string)
            userD.expectedCompanyName.append(string)
            
            userD.websiteSubstring = string.between(".", ".") ?? ""
            print("userD.websiteSubstring")
            print(userD.websiteSubstring)
        }
        
    }
    func isStringEmail(string: String) {
        if string.contains("@") && !string.contains("www") || string.lowercased().contains("email")   {
            userD.email.append(string)
            userD.expectedCompanyName.append(string)
            userD.emailSubstring = string.between("@", ".") ?? ""
            print("userD.emailSubstring")
            print(userD.emailSubstring)
            
        }
        
    }
    func isStringAddress(_ string: String, zipTemp: String) {
        
        if string.contains(zipTemp)
            || string.lowercased().contains("ave")
            || string.lowercased().contains("suite")
            || string.lowercased().contains("street")
            || string.lowercased().contains("bvld")
            || string.lowercased().contains("unit")
            || string.lowercased().contains("circle")
            || string.lowercased().contains("citu")
            || string.lowercased().contains("gate")
            || string.lowercased().contains("coast")
            || string.lowercased().contains("highway")
            || string.lowercased().contains("avenue")
            || string.lowercased().contains("road")
            || string.lowercased().contains("rd")
            || string.lowercased().contains("place")
            || string.lowercased().contains(" usa")
            || string.lowercased().contains("hwy")
            || string.lowercased().contains("floor")
            || string.lowercased().contains("box")
            
            
            || String(string.suffix(3)).lowercased() == " ca"
            || String(string.suffix(3)).lowercased() == " id"
            || String(string.suffix(3)).lowercased() == " ia"
            || String(string.suffix(3)).lowercased() == " al"
            || String(string.suffix(3)).lowercased() == " ak"
            || String(string.suffix(3)).lowercased() == " az"
            || String(string.suffix(3)).lowercased() == " ar"
            || String(string.suffix(3)).lowercased() == " wy"
            || String(string.suffix(3)).lowercased() == " wa"
            || String(string.suffix(3)).lowercased() == " dc"
            || String(string.suffix(3)).lowercased() == " vt"
            || String(string.suffix(3)).lowercased() == " va"
            || String(string.suffix(3)).lowercased() == " wi"
            || String(string.suffix(3)).lowercased() == " hi"
            || String(string.suffix(3)).lowercased() == " de"
            || String(string.suffix(3)).lowercased() == " ga"
            || String(string.suffix(3)).lowercased() == " wv"
            || String(string.suffix(3)).lowercased() == " il"
            || String(string.suffix(3)).lowercased() == " in"
            || String(string.suffix(3)).lowercased() == " ks"
            || String(string.suffix(3)).lowercased() == " ky"
            || String(string.suffix(3)).lowercased() == " co"
            || String(string.suffix(3)).lowercased() == " ct"
            || String(string.suffix(3)).lowercased() == " la"
            || String(string.suffix(3)).lowercased() == " ma"
            || String(string.suffix(3)).lowercased() == " mn"
            || String(string.suffix(3)).lowercased() == " ms"
            || String(string.suffix(3)).lowercased() == " mo"
            || String(string.suffix(3)).lowercased() == " mi"
            || String(string.suffix(3)).lowercased() == " mt"
            || String(string.suffix(3)).lowercased() == " me"
            || String(string.suffix(3)).lowercased() == " md"
            || String(string.suffix(3)).lowercased() == " ne"
            || String(string.suffix(3)).lowercased() == " nv"
            || String(string.suffix(3)).lowercased() == " nh"
            || String(string.suffix(3)).lowercased() == " nj"
            || String(string.suffix(3)).lowercased() == " ny"
            || String(string.suffix(3)).lowercased() == " nm"
            || String(string.suffix(3)).lowercased() == " oh"
            || String(string.suffix(3)).lowercased() == " ok"
            || String(string.suffix(3)).lowercased() == " or"
            || String(string.suffix(3)).lowercased() == " pa"
            || String(string.suffix(3)).lowercased() == " ri"
            || String(string.suffix(3)).lowercased() == " nd"
            || String(string.suffix(3)).lowercased() == " nc"
            || String(string.suffix(3)).lowercased() == " tn"
            || String(string.suffix(3)).lowercased() == " tx"
            || String(string.suffix(3)).lowercased() == " fl"
            || String(string.suffix(3)).lowercased() == " sd"
            || String(string.suffix(3)).lowercased() == " sc"
            || String(string.suffix(3)).lowercased() == " ut"
            
            
            
            
            || string.lowercased() == "new york"
            || string.lowercased() == "los angeles"
            || string.lowercased() == "chicago"
            || string.lowercased() == "houston"
            || string.lowercased() == "philadelphia"
            || string.lowercased() == "phoenix"
            || string.lowercased() == "san antonio"
            || string.lowercased() == "san diego"
            || string.lowercased() == "dallas"
            || string.lowercased() == "san jose"
            || string.lowercased() == "honolulu"
            || string.lowercased() == "austin"
            || string.lowercased() == "indianapolis"
            || string.lowercased() == "jacksonville"
            || string.lowercased() == "san francisco"
            || string.lowercased() == "columbus"
            || string.lowercased() == "charlotte"
            || string.lowercased() == "fort worth"
            || string.lowercased() == "detroit"
            || string.lowercased() == "el passo"
        {
            
            userD.adress.append(string)
            userD.expectedCompanyName.append(string)
        }
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
    
    
    func findZip(string: NSString) -> String {
        let regex = try! NSRegularExpression(pattern: "\\b\\d{5}(?:[ -]\\d{4})?\\b")
        var zipCode = ""
        let nsString: NSString = string
        let matches = regex.matches(in: nsString as String, options: [], range: NSMakeRange(0, nsString.length))
        for match in matches {
            
            zipCode = nsString.substring(with: match.range)
        }
        
        return zipCode
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
    
    func findPhone(string: String,  tempArea: String)  {
        
        if string.starts(with: "F.") || string.starts(with: "f.")  || string.starts(with: "Fax") || string.starts(with: "Fax:") || string.starts(with: "fax.") || string.starts(with: "FAX") || string.starts(with: "fax") {
            
            userD.expectedCompanyName.append(string)
        } else {
            
            if let result = string.extractPhoneNumber() {
                userD.phone.append(result.1)
                userD.expectedCompanyName.append(string)
                
                let tempArea2 = String(String(result.1).prefix(3))
                userD.areaCode.append(tempArea2)
                userD.areaCode = Array(Set(userD.areaCode))
            }
        }
    }
}



extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}


extension Character {
    // Given a list of allowed characters, try to convert self to those in list
    // if not already in it. This handles some common misclassifications for
    // characters that are visually similar and can only be correctly recognized
    // with more context and/or domain knowledge. Some examples (should be read
    // in Menlo or some other font that has different symbols for all characters):
    // 1 and l are the same character in Times New Roman
    // I and l are the same character in Helvetica
    // 0 and O are extremely similar in many fonts
    // oO, wW, cC, sS, pP and others only differ by size in many fonts
    func getSimilarCharacterIfNotIn(allowedChars: String) -> Character {
        let conversionTable = [
            "s": "S",
            "S": "5",
            "5": "S",
            "o": "O",
            "Q": "O",
            "O": "0",
            "0": "O",
            "l": "I",
            "I": "1",
            "1": "I",
            "B": "8",
            "8": "B"
        ]
        // Allow a maximum of two substitutions to handle 's' -> 'S' -> '5'.
        let maxSubstitutions = 2
        var current = String(self)
        var counter = 0
        while !allowedChars.contains(current) && counter < maxSubstitutions {
            if let altChar = conversionTable[current] {
                current = altChar
                counter += 1
            } else {
                break
            }
        }
        return current.first!
    }
}
