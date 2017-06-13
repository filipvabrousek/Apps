/*
2 View controllers needed
*/

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    /*                              CHECK FOR EXISTENCE OF 3D TOUCH                     */
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available{             
            registerForPreviewing(with: self, sourceView: view)
            
        } else {
            print("Force touch not available")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




    /*                              NEW WAY OF ADDING DELEGATE                              */
extension ViewController:UIViewControllerPreviewingDelegate{
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let peekWC = storyboard?.instantiateViewController(withIdentifier: "peekWC")
        return peekWC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        let popWC = storyboard?.instantiateViewController(withIdentifier: "popWC")
        
        show(popWC!, sender: self)
    }
    
}





















//
//  AppDelegate.swift
//  ForceTouch
//
//  Created by Filip Vabroušek on 05.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    /*                          PERFORM ACTION WHEN TAPPED ON ICON SHOWED AFTER FORCE TOUCH         */
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("Shortcut item tapped")
        
        if shortcutItem.type == "filip.ForceTouch.ForceTouch.newUser"{
            //go to add WC
            
        }
    }
    
    
}


