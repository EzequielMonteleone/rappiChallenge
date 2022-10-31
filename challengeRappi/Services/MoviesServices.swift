//
//  MoviServices.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation

class MoviesServices: Api {
    
    var Services: HttpServices
    
    override init() {
        self.Services = HttpServices()
    }
    
    func getMoviesUpcoming(completionHandler: @escaping ((ResponseMovie?) -> Void), completionError: @escaping ((Error?) -> Void)) {
        self.Services.get(type: ResponseMovie.self, url: "\(getEnviroment().apiUrl)movie/upcoming?api_key=\(Api.KEY)") { response in
            if let res = response {
                completionHandler(res)
            }
        } onError: { error in
            if let err = error {
                completionError(err)
            }
        }
    }
    
    func getMoviesTopRated(completionHandler: @escaping ((ResponseMovie?) -> Void), completionError: @escaping ((Error?) -> Void)) {
        self.Services.get(type: ResponseMovie.self, url: "\(getEnviroment().apiUrl)movie/top_rated?api_key=\(Api.KEY)") { response in
            if let res = response {
                completionHandler(res)
            }
        } onError: { error in
            if let err = error {
                completionError(err)
            }
        }
    }
    
    func getMoviDetail(moviId: Int, completionHandler: @escaping ((MovieDetail?) -> Void), completionError: @escaping ((Error?) -> Void)) {
        self.Services.get(type: MovieDetail.self, url: "\(getEnviroment().apiUrl)movie/\(moviId)?api_key=\(Api.KEY)") { response in
            if let res = response {
                completionHandler(res)
            }
        } onError: { error in
            if let err = error {
                completionError(err)
            }
        }

    }
    
    func getMoviVideos(moviId: Int, completionHandler: @escaping ((MovieVideos?) -> Void), completionError: @escaping ((Error?) -> Void)) {
        self.Services.get(type: MovieVideos.self, url: "\(getEnviroment().apiUrl)movie/\(moviId)/videos?api_key=\(Api.KEY)") { response in
            if let res = response {
                completionHandler(res)
            }
        } onError: { error in
            if let err = error {
                completionError(err)
            }
        }
    }
    
}
