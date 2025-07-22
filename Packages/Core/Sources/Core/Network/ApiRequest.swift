//
//  ApiRequest.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Alamofire

public protocol APIRequest {
    associatedtype Response: Decodable & Sendable
    
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders?{ get }
    var encoding: ParameterEncoding { get }
}
