//
//  API.Restaurant.swift
//  EateryTour
//
//  Created by NganHa on 9/17/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import ObjectMapper

extension Api.Trending {

    struct QueryParams {
        var query: String
        var location: String
        var limit: String

        func toJSON() -> Parameters {
            let parameters: Parameters = [
                "limit": limit,
                "query": query,
                "ll": location
            ]
            return parameters
        }
    }
    @discardableResult
    static func getTrending(params: QueryParams, completion: @escaping Completion<[Restaurant]>) -> Request? {
       // guard let lat = LocationManager.shared.currentLatitude, let lng = LocationManager.shared.currentLongitude else { return nil }
       // Api.Path.Trending.curentLocation = "\(lat),\(lng)"
        let path = Api.Path.Trending.path
       // print(path)
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let json = data as? JSObject,
                        let response = json["response"] as? JSObject,
                        let groups = response["groups"] as? JSArray,
                        let items = groups.first?["items"] as? JSArray else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    let restaurants: [Restaurant] = Mapper<Restaurant>().mapArray(JSONArray: items)
                    completion(.success(restaurants))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
