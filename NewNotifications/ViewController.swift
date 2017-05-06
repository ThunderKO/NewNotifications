//
//  ViewController.swift
//  NewNotifications
//
//  Created by KO TING on 6/5/2017.
//  Copyright © 2017年 EdUHK. All rights reserved.
//

import UIKit
//import Framework
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            
            if granted {
                print("Notifications access granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            
            if success {
                print("Successfully scheduled function")
            } else {
                print("Error scheduling notification")
            }
            
        })
    }

    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        //Add an attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        //create the attchment
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        //Only for extension
        //delcare in the mainViewController, onlt mention the identifier declared in the content extension view controller
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in IOS 10 are what I've always dreamed of!"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
        
    }
}

