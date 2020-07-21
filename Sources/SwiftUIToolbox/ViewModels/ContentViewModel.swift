//
//  ContentViewModel.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct ContentViewModel<Content: View> {
    let content: Content
    let height: CGFloat?
    
    public init(content: Content, height: CGFloat? = nil) {
        self.content = content
        self.height = height
    }
}

