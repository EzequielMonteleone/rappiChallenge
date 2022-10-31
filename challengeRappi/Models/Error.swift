//
//  Error.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation

struct Error {
    var Message: String
    var success: Bool
    init(message: String, success: Bool) {
        self.Message = message
        self.success = success
    }
}
