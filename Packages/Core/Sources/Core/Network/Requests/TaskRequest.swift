//
//  TaskRequest.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Alamofire

public struct TaskRequest: APIRequest {
    public struct Response: Decodable, Sendable {
        public let todos: [Task]
        public struct Task: Decodable, Sendable {
            public let id: Int
            public let todo: String
            public let completed: Bool
            public init(id: Int, todo: String, completed: Bool) {
                self.id = id
                self.todo = todo
                self.completed = completed
            }
        }
    }
    
    public var method: HTTPMethod { .get }
    public var path: String { "todos" }
    public var parameters: Parameters?
    public var headers: HTTPHeaders? { nil }
    public var encoding: ParameterEncoding { URLEncoding.default }
    
    public init() { }
}
