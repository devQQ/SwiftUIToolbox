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
    public let color: UIColor
    
    public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style, color: UIColor) {
        self.style = style
        self.color = color
        self._isAnimating = isAnimating
    }
    
    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.color = color
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
