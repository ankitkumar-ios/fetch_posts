//
//  SearchResponseModel.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

/// SearchResponse model helps to decode API values
public struct SearchResponse: Decodable {
    /// Just to make the initializer public
    public init() {}

    /// List of Countries and it's rates for 1USD
    public var items: [SearchItem]?

    /// Initialising from decoder to decode JSON
    /// - Parameter decoder: Decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        items = try values.decode([SearchItem].self)
    }
}

public struct SearchItem: Decodable {
    /// Just to make the initializer public
    public init() {}

    public var userId : Int?
    public var id : Int?
    public var title : String?
    public var body : String?

    enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }

}
