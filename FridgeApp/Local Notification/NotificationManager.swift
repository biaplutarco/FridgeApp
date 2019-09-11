//
//  LocalNotificationManager.swift
//  FridgeApp
//
//  Created by Bia on 10/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager {
    static var shared = NotificationManager()
    
    init() {}
    
    private var notifications = [Notificable]()
    
    private func scheduleNotifications() {
        notifications.forEach { (notification) in
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)
            let request = UNNotificationRequest(identifier: notification.body, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    private func addNotification(_ notification: Notificable) {
        notifications.append(notification)
    }
    
    func removeAllNotifications() {
        notifications.removeAll()
    }
    
    func createNotificationToProduct(_ product: Product) {
        guard let date = product.days else { fatalError("error pegando o days") }
        guard let title = product.title else { fatalError("error pegando o title") }
        
        if Calendar.current.isDateInTomorrow(date) {
            let notification = WillExpiry(productTitle: title, datetime: DateComponents().fromTime(hour: 20, minute: 54))
            NotificationManager.shared.addNotification(notification)
        } else if Calendar.current.isDateInToday(date) {
            let notification = ExpiryToday(productTitle: title, datetime: DateComponents().fromTime(hour: 20, minute: 54) )
            NotificationManager.shared.addNotification(notification)
        } else if Calendar.current.isDateInYesterday(date) {
            let notification = Expired(productTitle: title, datetime: DateComponents().fromTime(hour: 10, minute: 35) )
            NotificationManager.shared.addNotification(notification)
        }
    }
    
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            for notification in notifications {
                print(notification)
            }
        }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
}
