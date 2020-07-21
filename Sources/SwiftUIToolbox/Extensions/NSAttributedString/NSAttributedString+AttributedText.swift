//
//  NSAttributedString+AttributedText.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import UIKit

extension NSAttributedString {
    public static func addAttributedText(text: String, textURLs: [TextURL], textAlignment: NSTextAlignment = .left, font: UIFont, textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font, .foregroundColor: textColor])
        
        if textAlignment != .left {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = textAlignment
            
            attributedString.addAttributes([.paragraphStyle: paragraph], range: NSMakeRange(0, text.count))
        }
        
        guard textURLs.count > 0 else {
            return attributedString
        }
        
        for textURL in textURLs {
            attributedString.convertToLink(with: textURL.text, linkURL: textURL.url)
        }
        
        return attributedString
    }
    
    public static func addAttributedText(text: String, textURL: TextURL?, textAlignment: NSTextAlignment = .left, font: UIFont, textColor: UIColor) -> NSAttributedString {
        var textURLs: [TextURL] = []
        
        if let validTextURL = textURL {
            textURLs.append(validTextURL)
        }
        
        return addAttributedText(text: text, textURLs: textURLs, textAlignment: textAlignment, font: font, textColor: textColor)
    }
}

