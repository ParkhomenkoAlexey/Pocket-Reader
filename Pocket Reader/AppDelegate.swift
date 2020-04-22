//
//  AppDelegate.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 17.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit
import WatchConnectivity

let NotificationPurchasedMovieOnPhone = "PurchasedMovieOnPhone"
let NotificaitonPurchasedMovieOnWatch = "PurchasedMovieOnWatch"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var notificationCenter: NotificationCenter = {
        return NotificationCenter.default
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWatchConnectivity()
        setupNotificationCenter()
        return true
    }
    
    private func setupNotificationCenter() {
      notificationCenter.addObserver(forName: NSNotification.Name(rawValue: NotificationPurchasedMovieOnPhone), object: nil, queue: nil) { (notification: Notification) -> Void in
        self.sendSelectedBooksToWatch(notification: notification)
      }
    }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendSelectedBooksToWatch(notification: Notification) {
        if WCSession.isSupported() {
            let session = WCSession.default
            let pickedBooks = UserSettings.userBooks.map { (bookItem) in
                return bookItem.representation
            }
            print(pickedBooks)
            do {
                let dictionary: [String : Any] = ["books": pickedBooks]
                try session.updateApplicationContext(dictionary)
            } catch {
                print("ERROR: \(error)")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

extension AppDelegate: WCSessionDelegate {
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    if let error = error {
    print("WC Session activation failed with error: " + "\(error.localizedDescription)")
    return
      }
      print("WC Session activated with state: " + "\(activationState.rawValue)")
  }
    
  func sessionDidBecomeInactive(_ session: WCSession) {
    print("WC Session did become inactive")
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    print("WC Session did deactivate")
    WCSession.default.activate()
  }
}
