# BusinessCardSwiftPackage

CardReaderLib reads data from a business card and identifies fields:

- name
- email
- website
- company name
- phone number
- zip code
- area code
- address



 #### Detect text on card ####
    
    import BusinessCardSwiftPackage

    cardReader = CardRecognizer()
    cardReader.recognizeTextOnCard(scannedImage: UIImage)

    
 #### Get detected fields ####

     cardReader.userDataCompletion = {userData in
               email = userData?.email
               website = userData?.website
               areaCode = userData?.areaCode
               phone = userData?.phone
               personName = userData?.expectedName
               zipCode = userData?.zipCode
               address = userData?.adress
               companyName = userData?.findCompanyName
        }
    
    
    
