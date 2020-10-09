//
//  View+IgnoreSafeArea.swift
//  
//
//  Created by Q Trang on 10/8/20.
//

import SwiftUI

extension View {
    public func ignoreSafeAreaKeyboard(edges: Edge.Set = .all) -> some View {
        ModifiedContent(content: self, modifier: IgnoreSafeAreaKeyboardViewModifier(edges: edges))
    }
}
