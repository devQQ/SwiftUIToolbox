//
//  LazyView.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

//https://github.com/joehinkle11/Lazy-View-SwiftUI/blob/master/Source/LazyView.swift

public struct LazyView<Content: View>: View {
    private let build: () -> Content
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    public var body: Content {
        build()
    }
}

