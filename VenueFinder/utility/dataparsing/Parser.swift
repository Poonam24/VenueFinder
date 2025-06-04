//
//  JSONHelper.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//


import Foundation

protocol ParserInterface {
    func parseResult(from data: Data) -> [Venue]
}


// intententionally used as class to parse and return the response
// Also only 15 records are parsed to speed up the processing, the number of records to be parsed can be configured using numberOfRows in Constants file and that will also change number of rows in tableView
final class Parser: ParserInterface {
    
    var listOfVenue : [Venue] = []
    
    func parseResult(from data: Data) -> [Venue] {
        do {
            let jsonSerializedObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            guard let jsonObject = jsonSerializedObject, let sections = jsonObject["sections"] as? [Any] else {
                return []
            }
            for section in sections {
                if let section = section as? [String: Any],
                   let items = section["items"] as? [Any] {
                    for item in items {
                        if let venueItem = item as? [String: Any],
                           let nestedVenueObject = venueItem["venue"] as? [String: Any] {
                            let id = nestedVenueObject["id"] as? String
                            let name = nestedVenueObject["name"] as? String
                            let short_description = nestedVenueObject["short_description"] as? String
                            let image = venueItem["image"] as? [String: Any]
                            let imageURL = image?["url"] as? String
                            let key = id ?? ""
                            let isFavourite = StorageManager.sharedStorageManagerInstance.getSavedStatus(key)
                            let venue = Venue(id: id, name: name, shortDescription: short_description, imageURL: imageURL, isFavourite: isFavourite)
                            listOfVenue.append(venue)
                            // Data contains 1000000s of record which slows down parsing. -- Parsing only as per requirement
                            if(listOfVenue.count == Constants.numberOfRows) {
                                break;
                            }
                        }
                    }
                }
            }
        }
        return listOfVenue
    }
}
