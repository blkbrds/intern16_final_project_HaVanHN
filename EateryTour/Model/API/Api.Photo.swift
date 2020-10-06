//
//  Api.Photo.swift
//  EateryTour
//
//  Created by NganHa on 9/29/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Photo {

    struct QueryParams {
        var limit: Int

        func toJSON() -> Parameters {
            let params: Parameters = [
                "limit": limit
            ]
            return params
        }
    }

    @discardableResult
    static func getPhoto(params: QueryParams, restaurantId: String, completion: @escaping Completion<[Photo]>) -> Request? {
        Api.Path.Photo.id = restaurantId
        let path = Api.Path.Photo.path
        print(path)
        return api.request(method: .get, urlString: path, parameters: params.toJSON()) { (result) in
            switch result {
            case .success(let data):
                guard let json = data as? JSObject else {
                    completion(.failure(Api.Error.json))
                    return
                }
                guard let photoBundle: PhotoBundle = Mapper<PhotoBundle>().map(JSON: json) else {
                    completion(.failure(Api.Error.json))
                    return
                }
                completion(.success(photoBundle.photoList))
            case .failure:
                completion(.failure(Api.Error.invalidURL))
            }
        }
    }
}
