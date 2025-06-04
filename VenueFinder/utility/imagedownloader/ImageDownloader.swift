//
//  ImageDownloader.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//

import Foundation

protocol ImageDownloaderInterface {
   func downloadImage(from urlString: String, completion: @escaping (Data?, CustomError?) -> Void)
}

final class ImageDownloader: ImageDownloaderInterface {
    
    static let shared = ImageDownloader()
    private init() {}
    
    func downloadImage(from urlString: String, completion: @escaping (Data?, CustomError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, CustomError.unknownError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, CustomError.invalidResponse)
                return
            }
            if let data = data {
                completion(data, nil)
            } else {
                completion(nil, CustomError.unknownError)
            }
        }.resume()
    }
}
