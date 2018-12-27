//
//  AppDelegate.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        customizeNavigationBar()
        addDummyData()
        
        return true
    }
    
    private func customizeNavigationBar() {
        if let navController = window?.rootViewController as? UINavigationController {
            navController.navigationBar.prefersLargeTitles = true
            navController.navigationBar.barStyle = UIBarStyle.black
            navController.navigationBar.tintColor = UIColor.white    // BarButton color
            
            let bgImage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd],
                                                size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
            navController.navigationBar.barTintColor = UIColor(patternImage: bgImage!)
        }
    }
    
    private func injectEnvironment() {
        guard
            let navController = window?.rootViewController as? UINavigationController,
            let timelineVC = navController.topViewController as? TimelineTableViewController
            else { return }
        
        let entries: [Entry] = [
            // 어제
            Entry(createdAt: Date.before(1), text: "어제 일기"),
            // 2일 전
            Entry(createdAt: Date.before(2), text: "2일 전 일기"),
            Entry(createdAt: Date.before(2), text: "2일 전 일기"),
            // 3일 전
            Entry(createdAt: Date.before(3), text: "3일 전 일기"),
            Entry(createdAt: Date.before(3), text: "3일 전 일기"),
            Entry(createdAt: Date.before(3), text: "3일 전 일기")
        ]
        
        let repo: InMemoryEntryRepository = InMemoryEntryRepository(entries: entries)
        
    }
    func addDummyData() {
        let entries: [Entry] = [
            // 어제
            Entry(createdAt: Date.before(1), text: "어제 일기"),
            // 2일 전
            Entry(createdAt: Date.before(2), text: "2일 전 일기"),
            Entry(createdAt: Date.before(2), text: "2일 전 일기"),
            // 3일 전
            Entry(createdAt: Date.before(3), text: "3일 전 일기"),
            Entry(createdAt: Date.before(3), text: "3일 전 일기"),
            Entry(createdAt: Date.before(3), text: "3일 전 일기")
        ]
        let repo = InMemoryEntryRepository.shared
        entries.forEach {
            repo.add($0)
        }
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


}

