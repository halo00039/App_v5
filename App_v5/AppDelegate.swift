//
//  AppDelegate.swift
//  App
//
//  Created by 葉上輔 on 2020/7/22.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit
let Save_Second_Timer_Key = "Save_Second_Timer_Key"
let App_First_Run_Save_Data_Key = "App_First_Run_Save_Data_Key"
let Mode_Button_On_Or_Off = "Mode_Button_On_Or_Off"
func AppFirstRun() {
    let ud = UserDefaults.standard
    if ud.integer(forKey: App_First_Run_Save_Data_Key) == 0 {
        print("First Run")
        ud.set(100, forKey: App_First_Run_Save_Data_Key)
        ud.set(true, forKey: Mode_Button_On_Or_Off)
        ud.synchronize()
    } else {
        
        print("AppAlreadyFirstRun")
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppFirstRun()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

