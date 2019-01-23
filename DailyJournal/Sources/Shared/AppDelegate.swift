//
//  AppDelegate.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import RealmSwift

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
        
        let config = Realm.Configuration(inMemoryIdentifier: "InMemoryRealm")
        guard let realm = try? Realm(configuration: config) else { fatalError("realm config error!") }
        let repo = RealmEntryRepository(realm: realm)
        let env = Environment(
            entryRepository: repo,
            entryFactory: RealmEntry.entry,
            settings: UserDefaults.standard)
        timelineVC.viewModel = TimelineViewViewModel(environment: env)
    }
    
}

