//
//  NSMutableAttributedString+Link.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import Foundation

extension NSMutableAttributedString {
    public func convertToLink(with text: String, linkURL: String) {
        let range = self.mutableString.range(of: text)
        
        if range.location != NSNotFound {
            addAttribute(.link, value: linkURL, range: range)
        }
    }
}

