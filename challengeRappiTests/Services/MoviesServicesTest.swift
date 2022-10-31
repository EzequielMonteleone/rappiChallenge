//
//  MoviesServicesTest.swift
//  challengeRappiTests
//
//  Created by Ezequiel Monteleone on 30/10/2022.
//

import XCTest

class MoviesServicesTest: XCTestCase {
    
    func getMoviesUpcomingSuccess() throws {
        let url = URL(string: "")!
        var request = URLRequest(url: url)
        request.method = .get
        let promise = expectation(description: "CALL API SUCCESS")
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let _ = data, error == nil, let result = response as? HTTPURLResponse else {
                print("Connection error: \(String(describing: error))")
                return
            }
            do {
                XCTAssertTrue(result.statusCode == 200)
                promise.fulfill()
            }
        }.resume()
        waitForExpectations(timeout: 5)
    }
    
    func getMoviesUpcomingFailed() throws {
        let url = URL(string: "")!
        var request = URLRequest(url: url)
        request.method = .get
        let promise = expectation(description: "CALL API FAILED")
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let _ = data, error == nil, let result = response as? HTTPURLResponse else {
                print("Connection error: \(String(describing: error))")
                return
            }
            do {
                XCTAssertTrue(result.statusCode != 200)
                promise.fulfill()
            }
        }.resume()
        waitForExpectations(timeout: 5)
    }
    
}
