//
//  ActivityIndicator.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
    @Binding public var isAnimating: Bool
    
    public let style: UIActivityIndicatorView.Style
    
    public init(style: UIActivityIndicatorView.Style, isAnimating: Binding<Bool>) {
        self.style = style
        self._isAnimating = isAnimating
    }
    
    public func makeUIView(context: Context) -> UIActivityIndicatorView {
       return UIActivityIndicatorView(style: style)
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

