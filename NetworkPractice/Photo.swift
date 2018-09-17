//
//  Photo.swift
//  NetworkPractice
//
//  Created by Danny Espina on 8/22/18.
//  Copyright © 2018 Danny Espina. All rights reserved.
//

import Foundation

class Photo {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
    
    init(date: String, explanation: String, hdurl: String, media_type: String, service_version: String, title: String, url: String) {
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.media_type = media_type
        self.service_version = service_version
        self.title = title
        self.url = url
    }
    
    
}
