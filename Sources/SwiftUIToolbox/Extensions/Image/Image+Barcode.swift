//
//  Image+Barcode.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import UIKit
import SwiftUI
import CoreImage

public struct BarcodeViewModifier: ViewModifier {
    @State var generatedImage: UIImage? = nil
    public let data: String
    public let scale: CGFloat
    public let foreground: UIColor
    public let background: UIColor
    
    public func body(content: Content) -> some View {
        if let barcodeImage = generatedImage {
            return Image(uiImage: barcodeImage)
                .eraseToAnyView()
        } else {
            return content.onAppear(perform: {
                self.generateBarcode()
            })
                .eraseToAnyView()
        }
    }
    
    public func generateBarcode(foreground: UIColor = .black, background: UIColor = .white) {
        let asciiData = data.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return
        }
        
        filter.setValue(asciiData, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        guard let output = filter.outputImage?.transformed(by: transform) else {
            return
        }
        
        let parameters = [
            "inputColor0": CIColor(color: foreground),
            "inputColor1": CIColor(color: background)
        ]
        let coloredOutput = output.applyingFilter("CIFalseColor", parameters: parameters)
        
        let ciContext: CIContext = CIContext()
        
        guard let cgImage = ciContext.createCGImage(coloredOutput, from: output.extent) else {
            return
        }
        
        self.generatedImage = UIImage(cgImage: cgImage)
    }
}

extension Image {
    public func barcode(data: String, scale: CGFloat = 1.5, foreground: UIColor = .black, background: UIColor = .white) -> some View {
        ModifiedContent(content: self, modifier: BarcodeViewModifier(data: data, scale: 1.5, foreground: foreground, background: background))
    }
}
