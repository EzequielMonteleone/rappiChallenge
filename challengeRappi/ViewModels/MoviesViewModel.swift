//
//  MoviesViewModel.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation
import UIKit

struct MoviesList {
    var title: String
    var movie: ResponseMovie?
    var header: TitleFilterSectionViewDataSource
    var headerHeight: Int
    var rowHeight: Int
    var orientation: UICollectionView.ScrollDirection
}

class MoviesViewModel {
    
    let nextReleasesStorageKey = "nextReleasesStorageKey"
    let TrendStorageKey = "TrendStorageKey"
    let recommendedForYouStorageKey = "recommendedForYouStorageKey"
    let moviDetailStorageKey = "moviDetailStorageKey"
    let moviVideosStorageKey = "moviVideosStorageKey"
    let moviesServices: MoviesServices = MoviesServices()
    let storage: StorageManager = StorageManager()
    var list: [MoviesList] = []
    var movieDetail: MovieDetail?
    var movieVideos: MovieVideos?
    var officialTrailer: Video?
    
    func fetchMoviesUpcoming(complete: @escaping (() -> Void), completeWithError: @escaping ((Error?) -> Void)) {
        self.moviesServices.getMoviesUpcoming { response in
            self.storage.save(object: response, key: self.nextReleasesStorageKey)
            self.list.append(MoviesList(title: "Próximos estrenos", movie: response, header: TitleSectionView.Instance(), headerHeight: 60, rowHeight: 180, orientation: .horizontal))
            complete()
        } completionError: { error in
            if let response = self.storage.restore(type: ResponseMovie.self, key: self.nextReleasesStorageKey) {
                self.list.append(MoviesList(title: "Próximos estrenos", movie: response, header: TitleSectionView.Instance(), headerHeight: 60, rowHeight: 180, orientation: .horizontal))
                complete()
            } else {
                completeWithError(error)
            }
        }

    }
    
    func fetchMoviesTopRated(complete: @escaping (() -> Void), completeWithError: @escaping ((Error?) -> Void)) {
        self.moviesServices.getMoviesTopRated { response in
            self.storage.save(object: response, key: self.TrendStorageKey)
            self.list.append(MoviesList(title: "Tedencia", movie: response, header: TitleSectionView.Instance(), headerHeight: 60, rowHeight: 180, orientation: .horizontal))
            complete()
        } completionError: { error in
            if let response = self.storage.restore(type: ResponseMovie.self, key: self.TrendStorageKey) {
                self.list.append(MoviesList(title: "Tedencia", movie: response, header: TitleSectionView.Instance(), headerHeight: 60, rowHeight: 180, orientation: .horizontal))
                complete()
            } else {
                completeWithError(error)
            }
        }

    }
    
    func fetchRecommendedMovies(complete: @escaping (() -> Void), completeWithError: @escaping ((Error?) -> Void)) {
        self.moviesServices.getMoviesTopRated { response in
            if let r = response {
                self.storage.save(object: r, key: self.recommendedForYouStorageKey)
                let firstSix = ResponseMovie(page: r.page, results: Array(r.results.prefix(6)), total_pages: r.total_pages, total_results: r.total_results)
                self.list.append(MoviesList(title: "Recomendado para ti", movie: firstSix, header: TitleFilterSectionView.Instance(), headerHeight: 80, rowHeight: 700, orientation: .vertical))
                complete()
            }
        } completionError: { error in
            if let r = self.storage.restore(type: ResponseMovie.self, key: self.recommendedForYouStorageKey) {
                self.storage.save(object: r, key: self.recommendedForYouStorageKey)
                let firstSix = ResponseMovie(page: r.page, results: Array(r.results.prefix(6)), total_pages: r.total_pages, total_results: r.total_results)
                self.list.append(MoviesList(title: "Recomendado para ti", movie: firstSix, header: TitleFilterSectionView.Instance(), headerHeight: 80, rowHeight: 700, orientation: .vertical))
                complete()
            } else {
                completeWithError(error)
            }
        }
    }
    
    func filterSpanishMovies() {
        if let filter = self.list[1].movie?.results.filter({$0.original_language == "es"}) {
            self.list[2].movie?.results = filter
        }
    }
    
    func filterByYear() {
        if let filter = self.list[1].movie?.results.filter({$0.release_date.components(separatedBy: "-")[0] == "1993"}) {
            self.list[2].movie?.results = filter
        }
    }
    
    func fetchMoviDetail(moviId: Int, complete: @escaping (() -> Void), completeWithError: @escaping ((Error?) -> Void)) {
        self.moviesServices.getMoviDetail(moviId: moviId) { response in
            self.storage.save(object: response, key: self.moviDetailStorageKey)
            self.movieDetail = response
            complete()
        } completionError: { error in
            if let response = self.storage.restore(type: MovieDetail.self, key: self.moviDetailStorageKey) {
                self.movieDetail = response
                complete()
            } else {
                completeWithError(error)
            }
        }

    }
    
    func fetchOfficialTrailer(moviId: Int, complete: @escaping (() -> Void), completeWithError: @escaping ((Error?) -> Void)) {
        self.moviesServices.getMoviVideos(moviId: moviId) { response in
            self.storage.save(object: response, key: self.moviVideosStorageKey)
            self.movieVideos = response
            if let officialTrailer = response?.results.filter({$0.official}).first {
                self.officialTrailer = officialTrailer
                complete()
            } else {
                if(response?.results.count ?? 0 > 0) {
                    self.officialTrailer = response?.results[0]
                }
                complete()
            }
        } completionError: { error in
            if let response = self.storage.restore(type: MovieVideos.self, key: self.moviVideosStorageKey) {
                self.movieVideos = response
                if let officialTrailer = response.results.filter({$0.official}).first {
                    self.officialTrailer = officialTrailer
                    complete()
                } else {
                    if(response.results.count > 0) {
                        self.officialTrailer = response.results[0]
                    }
                    complete()
                }
            } else {
                completeWithError(error)
            }
        }

    }
    
}
