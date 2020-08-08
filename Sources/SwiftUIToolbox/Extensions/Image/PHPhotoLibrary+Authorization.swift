//
//  PHPhotoLibrary+Authorization.swift
//  
//
//  Created by Q Trang on 8/7/20.
//

import Photos
import Combine

extension PHPhotoLibrary {
    public func requestAuthorizationStatus() -> Future<PHAuthorizationStatus, Never> {
        return Future { resolve in
            let status = PHPhotoLibrary.authorizationStatus()
            
            guard status == .notDetermined else {
                return resolve(.success(status))
            }
            
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                return resolve(.success(newStatus))
            }
        }
    }
}

