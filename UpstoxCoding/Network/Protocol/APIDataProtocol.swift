//
//  APIDataProtocol.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import Foundation

protocol APIData {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var dataType: ResponseDataType { get }
    func absolutePath(from basePath: String) -> String
}

extension APIData {
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}

