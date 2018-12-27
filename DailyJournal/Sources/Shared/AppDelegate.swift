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
        injectEnvironment()
        
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
        timelineVC.environment = Environment(entryRepository: repo)
    }
    
}

