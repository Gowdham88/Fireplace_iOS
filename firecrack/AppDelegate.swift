//
//  AppDelegate.swift
//  firecrack
//
//  Created by Paramesh on 18/01/17.
//  Copyright © 2017 Paramesh. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import AVKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var prefs = UserDefaults.standard
    //var player = AVAudioPlayer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        // Override point for customization after application launch.

        registerforDeviceLockNotification()


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {

            UIScreen.main.brightness = brightvalue as! CGFloat

            var error:NSError?


            if ((player.rate != 0) && (error == nil)) {

                // player is playing
                print("Player playing")

            }else {
                print("Player not playing")

                player.play()
                //notplaying
            }

        }

        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }



    func registerforDeviceLockNotification() {
        //Screen lock notifications
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),     //center
            Unmanaged.passUnretained(self).toOpaque(),     // observer
            displayStatusChangedCallback,     // callback
            "com.apple.springboard.lockcomplete" as CFString,     // event name
            nil,     // object
            .deliverImmediately)
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),     //center
            Unmanaged.passUnretained(self).toOpaque(),     // observer
            displayStatusChangedCallback,     // callback
            "com.apple.springboard.lockstate" as CFString,    // event name
            nil,     // object
            .deliverImmediately)
    }

    private let displayStatusChangedCallback: CFNotificationCallback = { _, cfObserver, cfName, _, _ in

        guard let lockState = cfName?.rawValue as String? else {
            return
        }

        let catcher = Unmanaged<AppDelegate>.fromOpaque(UnsafeRawPointer(OpaquePointer(cfObserver)!)).takeUnretainedValue()
        catcher.displayStatusChanged(lockState)
    }
    var myvalue = 0

    private func displayStatusChanged(_ lockState: String) {


        myvalue += 1
        // the "com.apple.springboard.lockcomplete" notification will always come after the "com.apple.springboard.lockstate" notification
        print("Darwin notification NAME = \(lockState)")
        if (lockState == "com.apple.springboard.lockcomplete") {


            player.pause()
            print("DEVICE LOCKED")

        } else {

            if myvalue == 2 {

                print("1. LOCK STATUS CHANGED")

            } else if myvalue == 3 {

                myvalue = 0
                print("2. LOCK STATUS CHANGED - Audio will play")
                player.play()

            }

        }
    }
    
    






    func applicationDidEnterBackground(_ application: UIApplication) {

        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {

            UIScreen.main.brightness = brightvalue as! CGFloat

            //player.pause()
            // registerforDeviceLockNotification()

        }

        //UIScreen.main.brightness = CGFloat(0)
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }


    func applicationWillEnterForeground(_ application: UIApplication) {

        if let appBrightness1 = prefs.value(forKey: "appBrightness") {

            UIScreen.main.brightness = appBrightness1 as! CGFloat
        }
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

        if let appBrightness1 = prefs.value(forKey: "appBrightness") {

            UIScreen.main.brightness = appBrightness1 as! CGFloat
        }
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {

        if let brightvalue = prefs.value(forKey: "DeviceBrightness") {

            UIScreen.main.brightness = brightvalue as! CGFloat

        }
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

