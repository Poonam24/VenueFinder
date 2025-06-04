//
//  DatabaseManager.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 30/04/2025.
//
import Foundation

protocol StorageManagerInterface{
    func save(_ status: Bool, _ key: String)
    func getSavedStatus(_ key: String) -> Bool 
}

final class StorageManager: StorageManagerInterface {
    
    static let sharedStorageManagerInstance : StorageManager = StorageManager()
    private init() {}
    
    // saves status for particular key in userdefaults
    func save(_ status: Bool, _ key: String) {
        UserDefaults.standard.setValue(status, forKey: key)
    }
    // fetches status for particular key in userdefaults
    func getSavedStatus(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}
