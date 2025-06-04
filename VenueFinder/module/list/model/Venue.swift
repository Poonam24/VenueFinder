//
//  Venue.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import Foundation
import SwiftData

// This is intentionally create as class
final class Venue: Identifiable, Codable {
    var id: String?
    var name: String?
    var shortDescription: String?
    var imageURL: String?
    var isFavourite: Bool = false

    init(id: String? = nil, name: String? = nil, shortDescription: String? = nil, imageURL: String? = nil, isFavourite: Bool) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.imageURL = imageURL
        self.isFavourite = isFavourite
    }
}


