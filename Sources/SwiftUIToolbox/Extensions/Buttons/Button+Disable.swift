//
//  Button+Disable.swift
//  
//
//  Created by Quang Trang on 7/24/20.
//

import SwiftUI

public struct DisableButtonModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .opacity(0.5)
        .disabled(true)
    }
}

extension Button {
    public func disableButton() -> some View {
        ModifiedContent(content: self, modifier: DisableButtonModifier())
    }
}
