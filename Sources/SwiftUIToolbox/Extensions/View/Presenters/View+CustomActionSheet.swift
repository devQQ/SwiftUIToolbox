//
//  View+CustomActionSheet.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct ActionSheetPresenter<U: View, V: View>: View {
    @Binding var isPresented: Bool
    
    public var parent: () -> U
    public var presentingView: () -> V
    
    private var insertionTransition: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
    
    private var removalTransition: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .bottom))
    }
    
    public var body: some View {
        GeometryReader { reader in
            ZStack {
                self.parent().zIndex(0)
                
                Button("", action: {})
                    .zIndex(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(self.isPresented ? 1 : 0)
                    .onTapGesture {
                        withAnimation {
                            self.isPresented.toggle()
                        }
                }
                .transition(.opacity)
                
                self.presentingView()
                    .zIndex(2)
                    .offset(y: self.isPresented ? 0 : UIScreen.main.bounds.size.height)
            }
        }
    }
}

extension View {
    public func customActionSheet<V: View>(isPresented: Binding<Bool>, content: V) -> some View {
        ActionSheetPresenter(isPresented: isPresented, parent: { self }, presentingView: { content })
    }
}

