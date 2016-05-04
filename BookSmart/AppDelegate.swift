//
//  AppDelegate.swift
//  BookSmart
//
//  Created by Alec Brownlie on 3/29/16.
//  Copyright © 2016 Alec Brownlie. All rights reserved.
//

import UIKit
import Parse
import Bolts
//import Atlas

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var layerClient : LYRClient!
    
    // LayerApp ID key to use messaging
    let LayerAppIDString: NSURL! = NSURL(string: "layer:///apps/staging/bdcc3c7a-10da-11e6-a486-234fc40412a3")

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Override point for customization after application launch.
        
        // Initialize Parse.
        Parse.setApplicationId("pGQQu6YGEdBgjX0QrbuJvu7BDZ9rp094yyFmlx6V",
            clientKey: "LNoNKtql2LPKKzt1rU8khbcPFANVsdyG9DLRtUz5")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        //setupLayer()
        
        
        //let tableVC:PostViewController = PostViewController(className: "Posts")
        //tableVC.title = "BookSmart"
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func setupLayer() {
//        layerClient = LYRClient(appID: LayerAppIDString)
//        layerClient.autodownloadMIMETypes = NSSet(objects: ATLMIMETypeImagePNG, ATLMIMETypeImageJPEG, ATLMIMETypeImageJPEGPreview, ATLMIMETypeImageGIF, ATLMIMETypeImageGIFPreview, ATLMIMETypeLocation) as? Set<String>
//    }
}

