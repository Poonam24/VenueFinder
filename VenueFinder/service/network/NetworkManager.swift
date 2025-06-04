//
//  Networking.swift
//  VenueFinder
//
//  Created by poonam.l.yadav on 24/04/2025.
//


import Foundation
import Network


final class NetworkManager: ServiceInterface {
    
    
    static let shared = NetworkManager()
    private init() {}
    private var request : URLRequest?
    private let session: URLSession = URLSession.shared
    
    private let monitor = NWPathMonitor()
    private var isInternetAvailable = false
    
    func createRequest(url: URL?, latitude: Double, longitude: Double) -> URLRequest? {
        var urlString : String = ""
        if url == nil {
            urlString = "\(Constants.baseURLString)?lat=\(latitude)&lon=\(longitude)"
        }
        guard let url = URL(string: urlString) else {return nil}
        request = URLRequest(url: url)
        request?.httpMethod = Constants.MethodType.get.rawValue
        return request
    }
    
    // fetches data over internet, parses through parser utility, and returns to caller using closure
    func fetchVenues(url: URL?, latitude: Double, longitude: Double, completionHandler: @escaping (Result<[Venue]?, CustomError>) -> ()) {
        
        guard let request = self.createRequest(url: url, latitude: latitude, longitude: longitude) else {return }
        
        session.dataTask(with: request) { data, response, error in
            if(error == nil) {
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        guard let data = data else  {return}
                        let parser = Parser()
                        let venueArray = parser.parseResult(from: data)
                        completionHandler(.success(venueArray))
                    }
                } else {
                    completionHandler(.failure(.invalidResponse))
                }
            } else {
                completionHandler(.failure(.noInternetConnection))
                
            }
        }.resume()
        
    }
}


// checking the network availability
extension NetworkManager {
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isInternetAvailable = true
            } else {
                self.isInternetAvailable = false
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitorQueue", attributes: .concurrent)
        monitor.start(queue: queue)
    }
    
    func isInternetConnected() -> Bool {
        return isInternetAvailable
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
