//
//  Image+ImageModifier.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

extension Image {
    public func modifier<T>(_ modifier: T) -> some View where T: ImageModifier {
        modifier.body(content: self)
    }
}
