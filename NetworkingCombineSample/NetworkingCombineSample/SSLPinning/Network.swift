//
//  Network.swift
//  NetworkingCombineSample
//
//  Created by Balraj Verma on 12/11/20.
//  Copyright © 2020 Balraj Verma. All rights reserved.
//

import Foundation
import Alamofire
import Combine


class Network {
    var mTLS : Bool?
    
    var Event = PassthroughSubject<[JsonDat], AFError>()
    func doANetworkFetch() -> AnyPublisher<[JsonDat] , AFError> {
        let publisher = AF.request("https://jsonplaceholder.typicode.com/posts")
         .publishDecodable(type: [JsonDat].self)
        return publisher.value()
    
    }
    
    //MARK: - NETWORK REQUEST WITH PINNING
    func doNetworkAgainWithSSLPinning(mTLS:Bool) -> AnyPublisher<[JsonDat] , AFError> {
        return SSLPinning.request(URLRequestConveter.postURL, mTLSEnable: mTLS)
        .publishDecodable(type: [JsonDat].self)
        .value()
    }
}

// Use Request convetible to use request in Request // not in session.
enum URLRequestConveter: URLRequestConvertible {
    static let baseURLString = "https://jsonplaceholder.typicode.com"
    
    case postURL
    
    func asURLRequest() throws -> URLRequest {
        let path: String
        switch self {
        case .postURL:
            path = "/posts"
        }
        
        let url = URL(string: URLRequestConveter.baseURLString + path)!
        return URLRequest(url: url)
    }
    
}
