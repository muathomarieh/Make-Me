//
//  NotificationManager.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import Foundation
import UserNotifications

let pomodoroTimerNotificationID = "pomodoroTimerNotificationID"
class NotificationManager {
    
    static let instance: NotificationManager = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { success, error in
                if let error = error {
                    print("ERROR: \(error)")
                } else {
                    print("SUCCESS")
                }
            }
        
    }
    
    func schedulePomodoroNotification(seconds: TimeInterval) {
        
        cancelNotification(to: pomodoroTimerNotificationID)

        let content = UNMutableNotificationContent()
        content.title = "Hello Hello!"
        content.subtitle = "This is the time to "
        content.body = "Make Me!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        let request = UNNotificationRequest(identifier: pomodoroTimerNotificationID, content: content, trigger: trigger)
        
        // Add notification to notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(
                    "Error scheduling notification: \(error.localizedDescription)"
                )
            }
        }
        
    }
    
    func scheduleNotification(taskTitle: String, date: Date, id: String) {
   
        let content = UNMutableNotificationContent()
        content.title = "Hello Hello!"
        content.subtitle = "This is the time to " + taskTitle
        content.body = "Make Me!"
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        // Create trigger
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )

        // Create request
        let request = UNNotificationRequest(
            identifier: id,
            content: content,
            trigger: trigger
        )
        
        // Add notification to notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(
                    "Error scheduling notification: \(error.localizedDescription)"
                )
            }
        }
    }
    
    func cancelNotification(to id: String) {
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.removeAllDeliveredNotifications()
    }
}
