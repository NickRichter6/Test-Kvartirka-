//
//  NetworkManager.swift
//  Test
//
//  Created by Nick Ivanov on 22.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session: URLSession = URLSession.shared
    private let endpoints = Endpoints()
    
    private init() {}
    
    func getCities(completion: @escaping ([String: Int]?, Error?) -> Void) {
        
        guard let url = URL(string: endpoints.getCities()) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        baseRequest(request: request) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    let result = try JSONDecoder().decode(Countries.self, from: data)
                    var citiesDict = [String: Int]()
                    for country in result.countries {
                        for city in country.cities {
                            citiesDict[city.name] = city.id
                        }
                    }
                    completion(citiesDict, nil)
                } catch {
                }
            }
        }
    }
    
    func getFlats(fromCityId id: Int, offset: Int, screenWidth: Int, screenHeight: Int, completion: @escaping (Flats?, Error?) -> Void) {
        
        let urlString = endpoints.getFlats(cityId: String(id), offset: String(offset), screenWidth: String(screenWidth), screenHeight: String(screenHeight))
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        baseRequest(request: request) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(Flats.self, from: data)
                    completion(result, nil)
                } catch {
                }
            }
        }
    }
    
    private func baseRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        session.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
}

