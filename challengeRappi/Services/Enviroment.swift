//
//  Enviroment.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation

class Enviroment {
    var apiUrl: String = ""

    init(apiUrl: String) {
        self.apiUrl = apiUrl
    }
    
    static var Production: Enviroment {
        get{
            return Enviroment(apiUrl: "https://api.themoviedb.org/3/")
        }
    }
}
