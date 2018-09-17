//
//  photoStore.swift
//  NetworkPractice
//
//  Created by Danny Espina on 8/22/18.
//  Copyright © 2018 Danny Espina. All rights reserved.
//

import Foundation
import UIKit

enum ImageResult {
    case success(Photo)
    case failure(Error)
}

enum DownloadResult {
    case success(UIImage)
    case failure(Error)
}
enum PhotoError {
    case imageCreationError
}

class photoStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchPictureOfTheDay(completion: @escaping (ImageResult) -> Void) {
        let url = NASAAPI.PictureOfTheDay
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) -> Void in
            let result = self.processPhotosRequest(data: data, error: error)
            
            completion(result)
            
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> ImageResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return NASAAPI.photo(fromJSON: jsonData)
    }
}
