//
//  App.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import Foundation
import Alamofire

extension ApiManager {

    @discardableResult
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeader? = nil,
                 completion: Completion<Any>?) -> Request? {
        guard Network.shared.isReachable else {
            //completion?(.failure(Api.Error.network))
            return nil
        }

        var header: HTTPHeaders = api.defaultHTTPHeaders

        if let headers = headers {
            header.add(headers)
        }

        let request = AF.request(urlString.urlString,
                                 method: method,
                                 parameters: parameters,
                                 encoding: encoding,
                                 headers: header
        ).responseJSON { (response) in
            if let error = response.error,
                error.code == Api.Error.connectionAbort.code || error.code == Api.Error.connectionWasLost.code {
                AF.request(urlString.urlString,
                           method: method,
                           parameters: parameters,
                           encoding: encoding,
                           headers: header
                ).responseJSON { response in
                    completion?(response.result)
                }
            } else {
                completion?(response.result)
            }
        }
        return request
    }
}
