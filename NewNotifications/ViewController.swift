//
//  ViewController.swift
//  NewNotifications
//
//  Created by Paul Desamero on 7/29/17.
//  Copyright © 2017 PJDesi. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options:
            [.alert, .badge, .sound], completionHandler: { (granted, error) in
                
                if granted {
                    print("Notification Access Granted")
                } else {
                    print(error?.localizedDescription ?? "Access not granted")
                }
        })
    }

    @IBAction func notifyBtnPressed(send: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
        
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ success: Bool) ->()) {
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are better than iOS 9"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error ?? "Error")
                completion(false)
            } else {
                completion(true)
            }
        })
        
        
    }
    
    
}








