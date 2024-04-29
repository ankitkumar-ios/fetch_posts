//
//  ServiceError.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

/// Error types
public enum ServiceError: Error {
    case noInternet
    case badData
    case invalidURL
    case serviceError(error: Error)
    case responseError(code: HTTPStatusCode)
}
