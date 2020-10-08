//
//  Api.Search.swift
//  EateryTour
//
//  Created by NganHa on 10/7/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Search {

    struct QueryParams {
        var location: String = ""
        var query: String = ""

        func toJSON() -> Parameters {
            let params: Parameters = [
                "ll": location,
                "query": query
            ]
            return params
        }
    }

    @discardableResult
    static func searching(params: QueryParams, completion: @escaping Completion<[RestaurantSearching]>) -> Request? {
        let path = Api.Path.Search.path
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            switch result {
            case .success(let data):
                guard let json = data as? JSObject,
                    let response = json["response"] as? JSObject,
                    let venues = response["venues"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                }
                print(venues)
                let restaurants = Mapper<RestaurantSearching>().mapArray(JSONArray: venues)
                completion(.success(restaurants))
            case .failure:
                completion(.failure(Api.Error.invalidURL))
            }
        }
    }
}
