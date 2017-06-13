
/*
APP DELEGATE

//
//  AppDelegate.swift
//  FBLoginDemo
//
//  Created by Filip Vabroušek on 06.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        
        
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
        
        
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}








*/










//
//  ViewController.swift
//  FBLoginDemo
//
//  Created by Filip Vabroušek on 06.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    /*                                          SET UP LOGIN BUTTON                     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.current() != nil){
            print("User logged in")
        } else {
            
            let loginBtn = FBSDKLoginButton()
            loginBtn.center = self.view.center
            loginBtn.readPermissions = ["public_profile", "email"]
            loginBtn.delegate = self
            self.view.addSubview(loginBtn)
        }
    }
    
    
    
    /*                                            LOGIN BUTTON (get the user details)                   */
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
            print(error)
            
        } else if result.isCancelled {
            print("User canceled login")
            
        } else {
            
            if result.grantedPermissions.contains("email"){
                
                if let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"emails"]){
                    
                    graphRequest.start(completionHandler: { (connection, result, error) in
                        
                        if error != nil{
                            print(error)
                            
                        } else {
                            
                            if let userDetails = result{
                                print(userDetails)
                            }
                            
                            
                        }
                    })
                    
                    
                    
                }
                
                
            }
        }
    }
    
    
    /*                                              DID LOG OUT                             */
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

