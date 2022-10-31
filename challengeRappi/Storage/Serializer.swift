//
//  Serializer.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 30/10/2022.
//

import Foundation

class Serializer {
    
    class func encode(object: Codable) -> Encodable {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(object)
        return jsonData
    }
    
    class func decode<T>(type: T.Type, jsonData: Data) -> T where T : Codable {
        let jsonDecoder = JSONDecoder()
        let object = try! jsonDecoder.decode(T.self, from: jsonData)
        return object
    }
    
}
