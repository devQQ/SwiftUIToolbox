//
//  ImagePicker.swift
//  
//
//  Created by Q Trang on 8/7/20.
//

import SwiftUI

public struct ImagePicker: UIViewControllerRepresentable {
    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if parent.allowsEditing {
                let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                parent.handler(selectedImage)
            } else {
                let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                parent.handler(selectedImage)
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    public let sourceType: UIImagePickerController.SourceType
    public let allowsEditing: Bool
    public let handler: (UIImage?) -> Void
    
    public init(sourceType: UIImagePickerController.SourceType, allowsEditing: Bool = true, handler: @escaping (UIImage?) -> Void) {
        self.sourceType = sourceType
        self.allowsEditing = allowsEditing
        self.handler = handler
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
        vc.allowsEditing = true
        vc.delegate = context.coordinator
        
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
