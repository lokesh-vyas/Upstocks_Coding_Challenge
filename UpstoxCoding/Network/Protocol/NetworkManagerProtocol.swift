//
//  NetworkManagerProtocol.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func startRequest(request: APIData, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}
