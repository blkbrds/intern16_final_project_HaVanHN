//
//  Api.Map.swift
//  EateryTour
//
//  Created by NganHa on 10/9/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Map {

    struct QueryParams {
        var radius: String
        var query: String
        var location: String

        func toJSON() -> Parameters {
            let parameters: Parameters = [
                "radius": radius,
                "query": query,
                "ll": location
            ]
            return parameters
        }
    }

    @discardableResult
    static func exploring(params: QueryParams, completion: @escaping Completion<[Restaurant]>) -> Request? {
        let path = Api.Path.Trending.path
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
