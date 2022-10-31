//
//  MovieDetail.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 28/10/2022.
//

import Foundation

struct MovieDetail: Codable {
    var adult: Bool?
    var backdrop_path: String
    var belongs_to_collection: Collection?
    var budget: Int?
    var genres: [Genders]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String
    var production_companies: [Company]?
    var production_countries: [Country]?
    var release_date: String
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [Language]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}
