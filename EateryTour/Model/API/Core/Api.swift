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

    struct Photo {}

    struct Search {}

    struct Map {}
}

extension Api.Path {

    struct Trending {
        static var filter: String { return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)&radius=10000" }
        static var path: String { return baseURL / "explore?\(filter)" }
    }

    struct Recommend {
        static var filter: String {
            return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)"
        }
        static var path: String { return baseURL / "\(filter)" }
    }

    struct Detail {
        static var id: String = "abc"
        static var filter: String {
            return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)"
        }
        static var path: String { return baseURL / "\(id)?\(filter)" }
    }

    struct Photo {
         static var id: String = "default_id"
               static var filter: String {
                   return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)"
               }
        static var path: String { return baseURL / id / "photos?\(filter)" }
    }

    struct Search {
        static var filter: String {
            return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)&radius=1000&limit=10"
        }
        static var path: String { return baseURL / "search?\(filter)" }
    }

    struct Map {
        static var filter: String { return "client_id=\(APIKeys.client_id)&client_secret=\(APIKeys.client_secret)&oauth_token=\(APIKeys.oauth_token)&v=\(APIKeys.dateVersion)&limit=10" }
        static var path: String { return baseURL / "explore?\(filter)" }
    }
}

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
