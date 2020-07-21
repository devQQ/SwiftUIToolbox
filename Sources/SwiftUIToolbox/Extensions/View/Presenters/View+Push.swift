//
//  View+Push.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct PushPresenter<U: View, V: View>: View {
    @Binding var isPresented: Bool
    
    public var parent: () -> U
    //The view that is presented by this view
    public var presentingView: () -> V
    
    public var body: some View {
        GeometryReader { reader in
            ZStack {
                self.parent().zIndex(0)
                
                if self.isPresented {
                    self.presentingView()
                        .zIndex(1)
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut)
                }
            }
        }
    }
}

extension View {
    public func push<V: View>(isPresented: Binding<Bool>, content: V) -> some View {
        PushPresenter(isPresented: isPresented, parent: { self }, presentingView: { content })
    }
}
