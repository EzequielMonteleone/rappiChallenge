//
//  Manager.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 30/10/2022.
//

import Foundation
import UIKit

class StorageManager {

    func save(object: Codable, key: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(Serializer.encode(object: object), forKey: key)
    }
    
    func restore<T>(type: T.Type, key: String) -> T? where T : Codable {
        let defaults = UserDefaults.standard
        if let json = defaults.value(forKey: key) {
            return Serializer.decode(type: T.self, jsonData: json as! Data)
        }
        return nil
    }
    
}
