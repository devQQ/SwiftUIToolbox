//
//  View+Keyboard.swift
//  
//
//  Created by Q Trang on 8/1/20.
//

import SwiftUI

extension UIApplication {
    public func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public class KeyboardObserver: ObservableObject {
    public var isVisible = false
    @Published public var keyboardHeight: CGFloat = 0.0
    @Published public var keyboardAnimationDuration: Double = 0.25
    @Published public var isObserving: Bool = false
    
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        isObserving = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        isObserving = false
    }
    
    @objc func keyboardFrameChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardBeginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        isVisible = keyboardBeginFrame.minY >= keyboardEndFrame.minY
        keyboardHeight = isVisible ? keyboardEndFrame.height : 0.0
        keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
    }
}

public struct KeyboardObserverViewModifier: ViewModifier {
    let keyboardHeight: CGFloat
    let keyboardAnimationDuration: Double
    
    public func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .edgesIgnoringSafeArea(keyboardHeight > 0 ? .bottom : [])
            .animation(.easeInOut(duration: keyboardAnimationDuration))
    }
}

extension View {
    public func observeKeyboard(keyboardHeight: CGFloat, keyboardAnimationDuration: Double) -> some View {
        return ModifiedContent(content: self, modifier: KeyboardObserverViewModifier(keyboardHeight: keyboardHeight, keyboardAnimationDuration: keyboardAnimationDuration))
    }
}

