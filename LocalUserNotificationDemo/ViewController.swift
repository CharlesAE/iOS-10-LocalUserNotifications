//
//  ViewController.swift
//  LocalUserNotificationDemo
//
//  Created by Charles E on 2/5/17.
//  Copyright © 2017 LEO Technology. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    let center = UNUserNotificationCenter.current()
    let notif = UNMutableNotificationContent()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavItem()

        setupNotifications()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func setupNavItem() {
        
        //Navigation Items - Button
        
        let notifyButton = UIButton(type: .custom)
        notifyButton.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
        notifyButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        notifyButton.addTarget(self, action: #selector(sendNotification(_:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: notifyButton)
        
    }
    
    func setupNotifications() {
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
      
        let yesAction = UNNotificationAction(identifier: "YES_ACTION",
                                                 title: "Yes",
                                                 options: [.foreground])
        let noAction = UNNotificationAction(identifier: "NO_ACTION",
                                                title: "No",
                                                options: [.foreground])
        
        let generalCategory = UNNotificationCategory(identifier: "demoCategory", actions: [yesAction, noAction], intentIdentifiers: [], options: .customDismissAction)
        
        center.setNotificationCategories([generalCategory])

        center.requestAuthorization(options: authOptions) { (granted, error) in
            if granted {
                
                print("Authorized")
                
            }
            else {
                print(error!.localizedDescription)
            }
            
            }
        
        
        
        
    }
    func sendNotification(_ sender: UIButton){
        
        
        let myImage = "anticipation"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif")
            else {
                return
                
        }
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "demoNotification", url: imageUrl, options: [:])
        
        notif.title = "Rocky Horror Picture Show"
        notif.body = "HAVE YOU SEEN THIS CLASSIC?"
        notif.categoryIdentifier = "demoCategory"
        notif.attachments = [attachment]
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "demoNotification", content: notif, trigger: notifTrigger)
        center.add(request, withCompletionHandler: {error in
            if error != nil {
                print(error!)
            }
            else {
                print("notification sent")
            }
        })
    }

}

