//
//  UNUserNotificationCenter+.swift
//  
//
//  Created by Quang Trang on 8/22/20.
//

import Combine
import UserNotifications

extension UNUserNotificationCenter {
    public func currentAuthorizationStatus() -> Future<UNAuthorizationStatus, Never> {
        return Future { resolve in
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                resolve(.success(settings.authorizationStatus))
            }
        }
    }
}
