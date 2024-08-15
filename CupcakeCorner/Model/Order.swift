//
//  Order.swift
//  CupcakeCorner
//
//  Created by Oláh Máté on 14/08/2024.
//

import SwiftUI

struct Address: Codable {
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    private let key = "userAddress"
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedAddress = try? JSONDecoder().decode(Address.self, from: savedItems) {
                name = decodedAddress.name
                streetAddress = decodedAddress.streetAddress
                city = decodedAddress.city
                zip = decodedAddress.city
                return
            }
        }
    }
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    
    var name = "" {
        didSet {
         updatStoredAddress()
        }
    }
    var streetAddress = "" {
        didSet {
         updatStoredAddress()
        }
    }
    var city = "" {
        didSet {
         updatStoredAddress()
        }
    }
    var zip = "" {
        didSet {
         updatStoredAddress()
        }
    }
    
    var hasValidAddress: Bool {
        isValidAddesItem(name) && isValidAddesItem(streetAddress) && isValidAddesItem(city) && isValidAddesItem(zip)
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2

        cost += Decimal(type) / 2

        if extraFrosting {
            cost += Decimal(quantity)
        }

        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    private func isValidAddesItem(_ item: String) -> Bool {
        item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }
    
    private func updatStoredAddress() {
        let newAddress = Address(name: name,
                                 streetAddress: streetAddress,
                                 city: city,
                                 zip: zip)
        
        if let encoded = try? JSONEncoder().encode(newAddress) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
