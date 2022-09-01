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
    
    Just create instance of CardRecognizer.
    
    import BusinessCardSwiftPackage

    cardReader = CardRecognizer()
    
 #### Set callback to get detected fields ####
 
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

  #### Call recognition method ####
    
    cardReader.recognizeTextOnCard(scannedImage: UIImage)


    
    
    
