//
//  ImageModifier.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public protocol ImageModifier {
    associatedtype Body : View
    
    func body(content: Image) -> Self.Body
}

