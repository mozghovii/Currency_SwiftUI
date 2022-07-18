//
//  APIRequest.swift
//  Currency_SwiftUI
//
//  Created by serhii.mozhovyi on 18.07.2022.
//

import Foundation
import Alamofire

enum APIResult<Value> {
    case success(Value)
    case failure(Error)
}

typealias ResultCallback<Value> = APIResult<Value>

protocol API {
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension API {
    
    func send<T>(_ request: T)async throws -> ResultCallback<T.Response> where T: APIRequest {
        // MARK: Using Latest Async/Await
        
        try await withUnsafeThrowingContinuation { continuation in
            
            
            let endpoint = endpoint(for: request)
            
            let method = request.method
            let parameters = request.parameters()
            let encoding = request.parameterEncoding
            let preparedRequest = prepareRequest(endpoint,
                                                 method: method,
                                                 parameters: parameters,
                                                 encoding: encoding,
                                                 headers: nil)
            
            preparedRequest?.validate().responseData(completionHandler: { dataResponse in
                
                switch dataResponse.result {
                case .success(let data):
                    // response with data
                    do {
                        let data = try JSONDecoder.apiJSONDecoder().decode(T.Response.self, from: data)
                        
                        continuation.resume(returning: .success(data))
                        
                    } catch {
                        continuation.resume(returning: .failure(error))
                    }
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            })
        }
    }
    
    private func endpoint<T>(for request: T) -> URL where T: APIRequest {
        guard let baseUrl = URL(string: baseURL + request.path) else {
            fatalError("Bad resourceName: \(request.path)")
        }
        
        
        return baseUrl
    }
    
    private func prepareRequest(_ url: URLConvertible,
                                method: HTTPMethod = .get,
                                parameters: Any? = nil,
                                encoding: ParameterEncoding = URLEncoding.default,
                                headers: HTTPHeaders? = nil) -> DataRequest? {
        var originalRequest: URLRequest?
        
        do {
            originalRequest = try URLRequest(url: url, method: method, headers: headers)
            var encodedURLRequest: URLRequest?
            
            if let urlEncoding = encoding as? URLEncoding, let parameters = parameters as? Parameters {
                encodedURLRequest = try urlEncoding.encode(originalRequest!, with: parameters)
            } else if let jsonEncoding = encoding as? JSONEncoding {
                encodedURLRequest = try jsonEncoding.encode(originalRequest!, withJSONObject: parameters)
            } else {
                assertionFailure("Encoding method with these parameters is incorrect")
                return nil
            }
            
            return AF.request(encodedURLRequest!)
            
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
}

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameterEncoding: ParameterEncoding { get }
    func parameters() -> Any?
}

extension APIRequest {
    
    var jsonEncoder: JSONEncoder {
        return JSONEncoder()
    }
    
    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding(destination: .methodDependent, arrayEncoding: .brackets, boolEncoding: .literal)
        default:
            return JSONEncoding.default
        }
    }
    
    func parameters() -> Any? {
        return prepareParameters(self)
    }
    
    func prepareParameters<T>(_ parameters: T) -> Any? where T: Encodable {
        guard let data = try? jsonEncoder.encode(parameters) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    }
}
