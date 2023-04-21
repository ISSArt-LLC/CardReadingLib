
import Foundation
import SwiftUI


public class UserData {
    
    private var email: [String] = []
    private var website: [String] = []
    private var zipCode: [String] = []
    private var areaCode: [String] = []
    private var phone: [String] = []
    private var expectedName: [String] = []
    private var adress: [String] = []
    private var expectedCompanyName: [String] = []
    private var companyName: [String] = []
    private var findCompanyName: [String] = []
    public var emailSubstring = ""
    public var websiteSubstring = ""
    public var image: UIImage = UIImage()

    public func addCompanyName(newName: String) {
        if !companyName.contains(newName) && !newName.isEmpty {
            companyName.append(newName)
        }
    }

    public func addZipCode(newZip: String) {
        if !zipCode.contains(newZip) && !newZip.isEmpty {
            zipCode.append(newZip)
        }
    }

    public func addAddress(newAddress: String) {
        if !adress.contains(newAddress) && !newAddress.isEmpty {
            adress.append(newAddress)
        }
    }

    public func addPhone(newPhone: String) {
        if !phone.contains(newPhone) && !newPhone.isEmpty {
            phone.append(newPhone)
        }
    }

    public func addAreaCode(newAreaCode: String) {
        if !areaCode.contains(newAreaCode) && !newAreaCode.isEmpty {
            areaCode.append(newAreaCode)
        }
    }

    public func addEmail(newEmail: String) {
        if !email.contains(newEmail) && !newEmail.isEmpty {
            email.append(newEmail)
        }
    }

    public func addWebSite(newWebSite: String) {
        if !website.contains(newWebSite) && !newWebSite.isEmpty {
            website.append(newWebSite)
        }
    }

    public func addName(newName: String) {
        if !expectedName.contains(newName) && !newName.isEmpty {
            expectedName.append(newName)
        }
    }

    public func addAdditionalCompanyNameVariants(newVariant: String) {
        if !findCompanyName.contains(newVariant) && !newVariant.isEmpty {
            findCompanyName.append(newVariant)
        }
    }

    public func getCompanyName() -> String? {
        email.first
    }

    public func getName() -> String? {
        expectedName.first
    }

    public func getWebsite() -> String? {
        website.first
    }

    public func getAddress() -> String? {
        adress.first
    }

    public func getPhone() -> String? {
        phone.first
    }

    public func getEmail() -> String? {
        email.first
    }
}





