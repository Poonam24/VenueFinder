//
//  CustomError.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import Foundation


// app level customer error
internal enum CustomError : Error, LocalizedError {
    case noInternetConnection
    case invalidResponse
    case timeout
    case serverError
    case unknownError
    
    func userFriendlyMessage() -> String {
            switch self {
            case .noInternetConnection:
                return "It seems like you're not connected to the internet. Please check your connection and try again."
            case .serverError:
                return "There was an issue with the server. Please try again later."
            case .timeout:
                return "The request timed out. Please check your internet connection and try again."
            case .invalidResponse:
                return "We couldn't process the response from the server. Please try again later."
            case .unknownError:
                return "An unknown error occurred. Please try again later."
            }
        }

}

