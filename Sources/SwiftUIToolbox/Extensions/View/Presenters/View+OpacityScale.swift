//
//  View+OpacityScale.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct OpacityScalePresenter<U: View, V: View>: View {
    @Binding var isPresented: Bool
    
    public var parent: () -> U
    //The view that is presented by this view
    public var presentingView: () -> V
    
    private var insertionTransition: AnyTransition {
        AnyTransition.opacity.combined(with: .scale(scale: 1.2))
    }
    
    private var removalTransition: AnyTransition {
        AnyTransition.opacity.combined(with: .scale(scale: 1.5))
    }
    
    public var body: some View {
        GeometryReader { reader in
            ZStack {
                self.parent().zIndex(0)
                
                if self.isPresented {
                    Button("", action: {})
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.2))
                        .edgesIgnoringSafeArea(.all)
                        .zIndex(1)
                        .onTapGesture {
                            withAnimation {
                                self.isPresented.toggle()
                            }
                    }
                    .transition(.asymmetric(insertion: self.insertionTransition, removal: self.removalTransition))
                    
                    self.presentingView()
                        .zIndex(2)
                        .transition(.asymmetric(insertion: self.insertionTransition, removal: self.removalTransition))
                }
            }
        }
        .animation(.easeInOut(duration: 0.3))
    }
}

extension View {
    public func opacityScale<V: View>(isPresented: Binding<Bool>, content: V) -> some View {
        OpacityScalePresenter(isPresented: isPresented, parent: { self }, presentingView: { content })
    }
}

