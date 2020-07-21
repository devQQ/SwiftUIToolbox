//
//  View+.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

extension View {
    public func debug(color: Color = .red, width: CGFloat = 4.0, text: String = "") -> some View {
        return self.border(color, width: width)
            .overlay(
                VStack {
                    Text(text).fontWeight(.bold).foregroundColor(color)
                    Spacer()
                }
                .padding()
        )
    }
    
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
    public func eraseToIdentifiableView(id: String = UUID().uuidString) -> IdentifiableView {
        IdentifiableView(id: id, view: self.eraseToAnyView())
    }
    
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, content(self)))
        } else {
            return TupleView((self, nil))
        }
    }
    
    public func toViewController() -> UIViewController {
        UIHostingController(rootView: self)
    }
}

