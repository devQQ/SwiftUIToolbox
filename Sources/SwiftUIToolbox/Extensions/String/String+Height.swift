//
//  String+Height.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import UIKit

extension String {
    public func height(constraintToWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
