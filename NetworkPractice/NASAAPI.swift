//
//  DogAPI.swift
//  NetworkPractice
//
//  Created by Danny Espina on 8/22/18.
//  Copyright © 2018 Danny Espina. All rights reserved.
//

import Foundation
import UIKit

enum NASAAPIError: Error {
    case invaildJSONData
}

struct NASAAPI {
    private static let baseURLString = "https://api.nasa.gov/planetary/apod"
    private static let apiKey = "iGsBQFdmxG9yOWSgIPcQsUqHNyPH1AEjAcIvDNVE"
    
    private static func NASAURL(parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "api_key" : apiKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    static var PictureOfTheDay: URL {
        return NASAURL(parameters: [:])
    }
    
    static func photo(fromJSON data: Data) -> ImageResult {
        do {
            
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
            let jsonDictionary = jsonObject as? [AnyHashable:Any],
            let date = jsonDictionary["date"] as? String,
            let explanation = jsonDictionary["explanation"] as? String,
            let hdurl = jsonDictionary["hdurl"] as? String,
            let media_type = jsonDictionary["media_type"] as? String,
            let service_version = jsonDictionary["service_version"] as? String,
            let title = jsonDictionary["title"] as? String,
            let url = jsonDictionary["url"] as? String
                else {
                    return .failure(NASAAPIError.invaildJSONData)
            }
            
            let photo = Photo(date: date, explanation: explanation, hdurl: hdurl, media_type: media_type, service_version: service_version, title: title, url: url)
            
            
            return .success(photo)
        } catch let error {
            return .failure(error)
        }
    }
    
    static func downloadImage(at urlString: String, completion: @escaping (DownloadResult) -> Void)
    {
        let url = URL(string: urlString)
        guard let imageURL = url else {return}
        let request = URLRequest(url: imageURL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let imageData = data, let image = UIImage(data: imageData) else {return completion(.failure(error!))}
            
            return completion(.success(image))
            
        }
        task.resume()
    }
}
