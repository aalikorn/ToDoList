//
//  ApiClient.swift
//  Core
//
//  Created by Даша Николаева on 22.07.2025.
//

import Alamofire
import Combine
import Foundation

open class APIClient: @unchecked Sendable {
    @MainActor public static var shared = APIClient()
    private let session: Session
    private let responseQueue: DispatchQueue
    
    private init(session: Session = .default,
                responseQueue: DispatchQueue = .main) {
        self.session = session
        self.responseQueue = responseQueue
    }
    
    open func send<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.Response, Error>) -> Void
    ) {
        let url = "https://dummyjson.com/" + request.path
        
        session.request(
            url,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: request.headers
        )
        .validate()
        .responseDecodable(of: T.Response.self) { [weak self] response in
            self?.responseQueue.async {
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
