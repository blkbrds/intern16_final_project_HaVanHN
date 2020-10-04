//
//  Api.Recommend.swift
//  EateryTour
//
//  Created by NganHa on 10/2/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Recommend {

    struct QueryParams {
        var section: String
        var query: String
        var location: String
        var limit: String
        var price: String

        func toJSON() -> Parameters {
            let parameters: Parameters = [
                "section": section,
                "query": query,
                "ll": location,
                "limit": limit,
                "price": price
            ]
            return parameters
        }
    }

    @discardableResult
    static func getRecommend(params: QueryParams, completion: @escaping Completion<[Restaurant]>) -> Request? {
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
