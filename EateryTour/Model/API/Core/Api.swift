//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire

final class Api {

    struct Path {
        static let baseURL = "https://api.foursquare.com/v2/venues"
    }

    struct Trending {}

    struct Detail {}
    
    struct Recommend {}

    struct Search {
        let id: String
        let key: String
    }
}

extension Api.Path {

    struct Trending {
         static var filter: String { return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&v=\(APIKeys.dateVersion)&radius=10000" }
        static var path: String { return baseURL / "explore?\(filter)" }
    }
    
    struct Recommend {
        static var filter: String {
            return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&v=\(APIKeys.dateVersion)"
        }
        static var path: String { return baseURL / "\(filter)"}
    }

    struct Detail {
        static var id: String = "abc"
        static var filter: String {
            return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)"
        }
        static var path: String { return baseURL / "\(id)?\(filter)" }
    }
}

//    struct Search {
//        let id: String
//        let key: String
//        var path: String { return baseURL / clientKeySecret / "&\(key)" / "\(id)" }
//    }

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
