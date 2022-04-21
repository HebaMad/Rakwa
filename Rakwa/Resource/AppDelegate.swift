//
//  AppDelegate.swift
//  Rakwa
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
import Firebase
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        observerNetwork()
      
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
        observerNetwork()
      self.registerForPushNotification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
        
        
    }
    
    func observerNetwork () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }

    
    let reachability = Reachability()
    
    @objc func reachabilityChanged(note: Notification) {
           
           let reachability = note.object as! Reachability
           
           switch reachability.connection {
           case .wifi:
               DispatchQueue.main.async {
               
                   print("Reachable via WiFi")
               }
               
           case .none:
               DispatchQueue.main.async {
                   print("None")
                   if !Reachability3.isConnectedToNetwork(){
                       UIApplication.shared.topViewController()?.showNoInternetVC()
                       
                   }
               }
         
           case .cellular:
               DispatchQueue.main.async {
               
                   print("Reachable via cellular")
               }
           }
       }

}

