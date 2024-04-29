//
//  Constant.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

struct Constant {
    static let host = "jsonplaceholder.typicode.com"
    static let posts = "/posts"
    static let comments = "/comments"
    static let postId = "postId"
    static let schemeHTTPS = "https"
}

public enum HTTPStatusCode: Int {
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case couldNotFindData = 422
}

enum HTTPMethod: String {
    case get = "GET"
}

struct HTTPConstant {
    static let headerKeyContentType = "Content-Type"
    static let headerValueContentTypeJson = "application/json"
}
