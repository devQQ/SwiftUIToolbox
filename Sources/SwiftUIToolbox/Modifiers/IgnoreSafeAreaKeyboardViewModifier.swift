//
//  IgnoreSafeAreaKeyboardViewModifier.swift
//  
//
//  Created by Q Trang on 10/8/20.
//

import SwiftUI

public struct IgnoreSafeAreaKeyboardViewModifier: ViewModifier {
    public let edges: Edge.Set
    
    public init(edges: Edge.Set) {
        self.edges = edges
    }
    
    public func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            return content
                .ignoresSafeArea(.keyboard, edges: edges)
                .eraseToAnyView()
        } else {
            return content
                .eraseToAnyView()
        }
    }
}

