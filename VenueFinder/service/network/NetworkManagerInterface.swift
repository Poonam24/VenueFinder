//
//  File.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 28/04/2025.
//

import Foundation

protocol ServiceInterface : AnyObject {
    func createRequest(url: URL?, latitude: Double, longitude: Double) -> URLRequest?
    func fetchVenues(url: URL?, latitude:Double, longitude: Double, completionHandler: @escaping (Result<[Venue]?, CustomError>) -> ())

}
