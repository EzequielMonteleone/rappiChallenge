//
//  Api.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation

class Api {
    static let KEY = "7bb7cb02eeae47e7756e69b3dcdad8c0"
    static let BASE_URL_IMAGE = "https://image.tmdb.org/t/p/w500"
    private var enviroment: Enviroment = Enviroment.Production

    internal func getEnviroment() -> Enviroment {
        return self.enviroment
    }
}
