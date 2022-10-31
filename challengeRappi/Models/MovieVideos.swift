//
//  MovieVideos.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 28/10/2022.
//

import Foundation

struct Video: Codable {
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published_at: String
    var id: String
}

struct MovieVideos: Codable {
    var id: Int
    var results: [Video]
}
