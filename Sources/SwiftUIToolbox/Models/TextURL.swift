//
//  TextURL.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import Foundation

public struct TextURL: Identifiable, Hashable, Decodable {
    public let id = UUID()
    public var text: String
    public var url: String
    
    public init(text: String, url: String) {
        self.text = text
        self.url = url
    }
    
    private enum CodingKeys: String, CodingKey {
        case text
        case url
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


