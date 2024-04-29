//
//  CloudEnvironment.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

public protocol CloudEnvironment {
    func getBaseUrl(with query: String?) -> URL?
    func getScheme() -> String
    func getHost() -> String
}

// Defining the environment
extension CloudEnvironment {
    public func getHost() -> String {
        Constant.host
    }

    public func getScheme() -> String {
        Constant.schemeHTTPS
    }
}
