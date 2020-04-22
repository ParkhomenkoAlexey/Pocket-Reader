//
//  ExtensionDelegate.swift
//  Pocket Reader WatchKit Extension
//
//  Created by Алексей Пархоменко on 17.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import WatchConnectivity

let NotificationPurchasedMovieOnWatch = "PurchasedMovieOnWatch"

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    lazy var notificationCenter: NotificationCenter = {
    return NotificationCenter.default
    }()
    
    func applicationDidFinishLaunching() {
        setupWatchConnectivity()
        setupNotificationCenter()
    }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    private func setupNotificationCenter() {
      notificationCenter.addObserver(forName: NSNotification.Name(rawValue: NotificationPurchasedMovieOnWatch), object: nil, queue: nil) { (notification:Notification) -> Void in
        self.sendSelectedBooksToPhone(notification: notification)
      }
    }
    
    func sendSelectedBooksToPhone(notification: Notification) {
        print(#function)
        if WCSession.isSupported() {
            let session = WCSession.default
            let pickedBooks = UserSettings.userBooks.map { (bookItem) in
                return bookItem.representation
            }
            do {
                let dictionary: [String : Any] = ["books": pickedBooks]
                try session.updateApplicationContext(dictionary)
            } catch {
                print("ERROR: \(error)")
            }
        }
    }

}

extension ExtensionDelegate: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WC Session activation failed with error: " + "\(error.localizedDescription)")
            return
        }
        print("WC Session activated with state: " +
            "\(activationState.rawValue)")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        var pickedBooks = [BookItem]()
        if let books = applicationContext["books"] as? [[String: Any]] {
            books.forEach { (book) in
                if let book = BookItem(data: book) {
                    pickedBooks.append(book)
                }
                
            }
            UserSettings.userBooks = pickedBooks
            DispatchQueue.main.async(execute: {
              WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "PickedBooks", context: [:] as AnyObject)])
            })

//            pickedBooks.forEach { (book) in
//                print(book.name)
//            }
        }
    }
}
