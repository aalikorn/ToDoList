//
//  TaskRequest.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Alamofire

public struct TaskRequest: APIRequest {
    public struct Task: Decodable, Sendable {
        public let id: Int
        public let todo: String
        public let completed: Bool
    }
    public typealias Response = [Task]
    
    public var method: HTTPMethod { .get }
    public var path: String { "todos" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init() { }
}
