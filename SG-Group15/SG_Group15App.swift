//
//  SG_Group15App.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct SG_Group15App: App {
    @StateObject var languageManager = LanguageManager()
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("theme") private var theme: Theme = .light
    
    let notificationDelegate = NotificationDelegate()
    
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
        UserDefaults.standard.set(0, forKey: "badgeCount")
        UNUserNotificationCenter.current().setBadgeCount(0)
        UNUserNotificationCenter.current().delegate = notificationDelegate
        requestNotificationPermission()
        scheduleNotificationWithBadge(hour: 8, minute: 00)
        // Start the background music
        SoundManager.shared.playBackground()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase, initial: true) { _,newScenePhase in
                    if newScenePhase == .active {
                        // Clear badge count when the app becomes active
                        clearBadgeCount()
                        removeAllNotifications()
                    }
                }
                .onAppear {
                    clearBadgeCount()
                }
                .environmentObject(languageManager)
            // Set the locale of the app using the selected language
                .environment(\.locale, .init(identifier: languageManager.selectedLanguage))
                .preferredColorScheme(theme.colorScheme)
        }
    }
    
    func clearBadgeCount() {
        UserDefaults.standard.set(0, forKey: "badgeCount")
        
        UNUserNotificationCenter.current().setBadgeCount(0) { error in
            if let error = error {
                print("Error clearing badge count: \(error.localizedDescription)")
            }
        }
    }
    
    // Remove all pending and delivered notifications
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        print("All notifications removed.")
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Permission granted.")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to update and set the badge count
    func updateBadgeCount(by increment: Int) {
        let currentBadgeCount = UserDefaults.standard.integer(forKey: "badgeCount")
        let newBadgeCount = max(currentBadgeCount + increment, 0)
        UserDefaults.standard.set(newBadgeCount, forKey: "badgeCount")
        
        UNUserNotificationCenter.current().setBadgeCount(newBadgeCount) { error in
            if let error = error {
                print("Error setting badge count: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to get the current badge count
    func getCurrentBadgeCount() -> Int {
        return UserDefaults.standard.integer(forKey: "badgeCount")
    }
    
    func scheduleNotificationWithBadge(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't lose your streak!"
        content.sound = UNNotificationSound.default
        
        // Increment the badge count
        let newBadgeCount = getCurrentBadgeCount() + 1
        content.badge = NSNumber(value: newBadgeCount)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Notification with badge scheduled successfully.")
                // Update the badge count in UserDefaults and set it
                updateBadgeCount(by: 1)
            }
        }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // Called when a notification is delivered while the app is running
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
