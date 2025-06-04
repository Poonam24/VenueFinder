//
//  ServiceType.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 27/04/2025.
//


protocol ServiceFactoryInterface {
    func createService(for type: Constants.ServiceType) -> ServiceInterface
    func createLocationService(for type: Constants.LocationType) -> LocationManagerInterface
}

final class ServiceFactory: ServiceFactoryInterface {
    
    func createLocationService(for type: Constants.LocationType) -> LocationManagerInterface {
        switch type {
        case .userCoreLocation:
            let coreLocationManager = LocationManagerService()
            return coreLocationManager
        case .inMemoryLocation:
            let localLocationManager = LocalLocationReader()
            return localLocationManager
        }
    }
    
    // Flexibilty to add extra service layer in future if need dbmanager in between
    func createService(for type: Constants.ServiceType) -> ServiceInterface {
        switch type {
        case .network:
            let networkManager = NetworkManager.shared
            return networkManager
        }
    }
}
