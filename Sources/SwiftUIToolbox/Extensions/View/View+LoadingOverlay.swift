//
//  View+LoadingOverlay.swift
//  
//
//  Created by Q Trang on 8/8/20.
//

import SwiftUI

struct LoadingOverlayViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            GeometryReader { reader in
                content
                
                if self.isLoading {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.01))
                        .edgesIgnoringSafeArea(.vertical)
                        .frame(width: reader.frame(in: .global).width, height: reader.frame(in: .global).height)
                }
            }
        }
    }
}

extension View {
    public func loadingOverlay(isLoading: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: LoadingOverlayViewModifier(isLoading: isLoading))
    }
}

