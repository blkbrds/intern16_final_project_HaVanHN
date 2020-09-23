//
//  Api.Detail.swift
//  EateryTour
//
//  Created by NganHa on 9/23/20.
//  Copyright © 2020 Ha Van H.N. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Detail {

    @discardableResult
    static func getDetail(restaurantId: String, completion: @escaping Completion<Detail>) -> Request? {
        Api.Path.Detail.id = restaurantId
        let path = Api.Path.Detail.path
        print(path)
        return api.request(method: .get, urlString: path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let json = data as? JSObject else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    guard let detail: Detail = Mapper<Detail>().map(JSON: json) else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    completion(.success(detail))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
