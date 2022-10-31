//
//  HttpServices.swift
//  challengeRappi
//
//  Created by Ezequiel Monteleone on 26/10/2022.
//

import Foundation
import Alamofire

class HttpServices {
    
    private var Manager: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        return Alamofire.Session(configuration: config)
    }()
    
    func get<T>(type: T.Type, url: String, _ headers: HTTPHeaders? = nil, onSuccess: @escaping (T?) -> Void, onError: @escaping (Error?) -> Void) where T : Codable {
        Manager.request(url, method: .get, headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .failure(let error):
                print(error)
                onError(Error(message: "Se ha producido un error.", success: false))
                break
            case .success(let res):
                onSuccess(res)
                break
            }
        }
    }
    
}
