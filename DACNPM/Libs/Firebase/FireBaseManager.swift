//
//  FireBaseManager.swift
//  zody-native-app
//
//  Created by TruongVO07 on 8/17/18.
//  Copyright © 2018 Zody. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

import Realm
import RealmSwift

class FireBaseManager: NSObject {
    static let share = FireBaseManager()
    
    fileprivate var isShowConfirmPopup: Bool = false
    //
    let fcmTokenKey = "Firebase.key.FCMToken"
    var fcmToken: String? {
        set {
            let pref = UserDefaults.standard
            pref.set(newValue ?? "", forKey: fcmTokenKey)
            pref.synchronize()
            //
            debugPrint("--- FCM Token: \(newValue ?? "")")
        }
        get {
            let pref = UserDefaults.standard
            return pref.value(forKey: fcmTokenKey) as? String
        }
    }
    //
    
    // Config
    func config(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension FireBaseManager: UNUserNotificationCenterDelegate {}

extension FireBaseManager: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        self.fcmToken = fcmToken
    }
}
