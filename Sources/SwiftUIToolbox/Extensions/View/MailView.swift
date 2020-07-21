//
//  MailView.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import MessageUI
import SwiftUI

public enum MailComposerError: Error {
    case cannotSendMail
}

extension MailComposerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotSendMail:
            return NSLocalizedString("You need to setup your email account to continue", comment: "")
        }
    }
}

public struct MailView: UIViewControllerRepresentable {
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresented: Bool
        var resultHandler: (Result<MFMailComposeResult, Error>?) -> Void
        
        init(isPresented: Binding<Bool>, resultHandler: @escaping (Result<MFMailComposeResult, Error>?) -> Void) {
            self._isPresented = isPresented
            self.resultHandler = resultHandler
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                self.isPresented = false
            }
            
            guard error == nil else {
                self.resultHandler(.failure(error!))
                return
            }
            
            self.resultHandler(.success(result))
        }
    }
    
    @Binding var isPresented: Bool
    var resultHandler: (Result<MFMailComposeResult, Error>?) -> Void
    
    let subject: String?
    let toRecipients: [String]
    
    public init(isPresented: Binding<Bool>, subject: String? = nil, toRecipients: [String] = [], resultHandler: @escaping (Result<MFMailComposeResult, Error>?) -> Void) {
        self._isPresented = isPresented
        self.resultHandler = resultHandler
        self.subject = subject
        self.toRecipients = toRecipients
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, resultHandler: resultHandler)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject(subject ?? "")
        vc.setToRecipients(toRecipients)
        vc.mailComposeDelegate = context.coordinator
        
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
    }
}

