//
//  Cosntants.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 28/04/2025.
//


// applevel constants
final class Constants {
    static let numberOfRows = 15
    static let baseURLString = "https://restaurant-api.wolt.com/v1/pages/restaurants"
    
    enum MethodType: String {
        case get = "GET"
        case post = "POST"
    }
    
    static let favouriteButtonWidth = 40
    static let favouriteButtonHeight = 40
    static let favouriteButtonMargin = 20
    static let heartBeats = 4
    
   
    enum ServiceType {
        case network
    }
    enum LocationType {
        case userCoreLocation
        case inMemoryLocation
    }
}
