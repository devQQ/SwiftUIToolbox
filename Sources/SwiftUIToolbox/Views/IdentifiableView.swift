//
//  IdentifiableView.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct IdentifiableView : View, Identifiable, Hashable {
    public var id : String
    public var view : AnyView
    
    public init(id: String = UUID().uuidString, view: AnyView) {
        self.id = id
        self.view = view
    }
    
    public var body: some View {
        view
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension IdentifiableView: Equatable {
    public static func ==(lhs: IdentifiableView, rhs: IdentifiableView) -> Bool {
        return lhs.id == rhs.id
    }
}

