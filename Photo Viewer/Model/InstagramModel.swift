//
//  InstagramModel.swift
//  Photo Viewer
//
//  Created by Ambuj Shukla on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import Foundation

struct InstagramModel: Codable {
    var data: [MediaData]
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct MediaData: Codable {
    var images: ImageList
    enum CodingKeys: String, CodingKey {
        case images = "images"
    }
}

struct ImageList: Codable {
    var low_resolution: ImageConfigurations
    var standard_resolution: ImageConfigurations
    var thumbnail: ImageConfigurations
    
    enum CodingKeys: String, CodingKey {
        case low_resolution = "low_resolution"
        case standard_resolution = "standard_resolution"
        case thumbnail = "thumbnail"
    }
}

struct ImageConfigurations: Codable {
    var height: Int
    var url: String
    var width: Int
}
