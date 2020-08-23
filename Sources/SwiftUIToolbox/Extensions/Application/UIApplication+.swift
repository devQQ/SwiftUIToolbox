//
//  UIApplication+.swift
//  
//
//  Created by Q Trang on 8/23/20.
//

import SwiftUI

extension UIApplication {
    public var rootViewController: UIViewController? {
        let keyWindow =  UIApplication.shared.windows.first { $0.isKeyWindow }
        return keyWindow?.rootViewController
    }
}
