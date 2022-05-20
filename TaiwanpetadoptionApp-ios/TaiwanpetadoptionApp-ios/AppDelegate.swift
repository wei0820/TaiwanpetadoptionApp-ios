//
//  AppDelegate.swift
//  TaiwanpetadoptionApp-ios
//
//  Created by  JackPan on 2021/8/7.
//

import UIKit
import Firebase
import GoogleMobileAds
//import VpadnSDKAdKit
import AppTrackingTransparency
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                //you got permission to track
//            })
//        } else {
//            //you got permission to track, iOS 14 is not yet installed
//        }
//        
        
        ApplicationDelegate.shared.application(
                 application,
                 didFinishLaunchingWithOptions: launchOptions
             )

        return true
    }



}

