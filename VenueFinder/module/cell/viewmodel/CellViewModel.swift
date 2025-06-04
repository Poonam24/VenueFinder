//
//  ViewModel.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 28/04/2025.
//

import Foundation

protocol CustomCellViewModelInterface {
    func loadImage(withImageURL: String, callback: @escaping (Data?, CustomError?) -> Void)
    func saveInDatabase(_ status: Bool, _ key: String)
    func getSavedStatus(_ key: String) -> Bool
}


final class CustomCellViewModel: CustomCellViewModelInterface {
    
    var dataBaseManagerInstance: StorageManagerInterface!
    var imageDownloaderInstance: ImageDownloaderInterface!
    
    init(imageDownloader: ImageDownloaderInterface = ImageDownloader.shared, dataBaseManager: StorageManagerInterface) {
        imageDownloaderInstance = imageDownloader
        dataBaseManagerInstance = dataBaseManager

    }
    
    func loadImage(withImageURL: String, callback: @escaping (Data?, CustomError?) -> Void) {
        imageDownloaderInstance.downloadImage(from: withImageURL) { (data,error)  in
            callback(data, error)
        }
    }
  
    func saveInDatabase(_ status: Bool, _ key: String) {
        self.dataBaseManagerInstance.save(status, key)
    }
    
    func getSavedStatus(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}
