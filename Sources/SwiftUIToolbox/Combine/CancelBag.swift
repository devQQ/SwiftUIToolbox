//
//  CancelBag.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import Foundation
import Combine

public typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    public mutating func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        formUnion(cancellables())
    }
    
    public mutating func cancel() {
        forEach { $0.cancel() }
        self.removeAll()
    }
    
    @_functionBuilder
    struct Builder {
        func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}
