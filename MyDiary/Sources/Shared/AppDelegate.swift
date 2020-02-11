//
//  AppDelegate.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.3)
        
        let console = ConsoleDestination()
        log.addDestination(console)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
        
        window.backgroundColor = .white
        
        let navController = UINavigationController(rootViewController: TimelineController())
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        customizeNavigationBar()
        injectEnvironment()
        
        return true
    }
    
    // MARK: - Custom methods
    private func customizeNavigationBar() {
        guard let navController = window?.rootViewController as? UINavigationController else { return }
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barStyle = UIBarStyle.default
        navController.navigationBar.tintColor = UIColor.black    // BarButton color
        
        let bgImage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd],
                                            size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        guard let image = bgImage else { return }
        navController.navigationBar.barTintColor = UIColor(patternImage: image)
        
        guard
            let titleFont = UIFont(name: "SangSangShinb7", size: 20),
            let largeTitleFont = UIFont(name: "SangSangShinb7", size: 34) else { return }
        
        let titleTextAttributes: [NSAttributedString.Key : Any] = [.font : titleFont]
        let largeTitleTextAttributes: [NSAttributedString.Key : Any] = [.font : largeTitleFont]
        
        navController.navigationBar.titleTextAttributes = titleTextAttributes
        navController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
    }
    
    private func injectEnvironment() {
        guard
            let navController = window?.rootViewController as? UINavigationController,
            let timelineVC = navController.topViewController as? TimelineController else { return }
        
        // dummy data
        let diaries: [Diary] = [
            // 어제
            Diary(createdAt: Date.before(1), text: "어제 일기"),
            Diary(createdAt: Date.before(1), text: "어제 일기"),
            // 2일 전
            Diary(createdAt: Date.before(2), text: "2일 전 일기"),
            Diary(createdAt: Date.before(2), text: "2일 전 일기"),
            // 3일 전
            Diary(createdAt: Date.before(3), text: "3일 전 일기"),
            Diary(createdAt: Date.before(3), text: "3일 전 일기"),
            Diary(createdAt: Date.before(3), text: "3일 전 일기")
        ]
        
        let repo: InMemoryDiaryRepository = InMemoryDiaryRepository(diaries: diaries)
        let env = Environment(diaryRepository: repo, settings: UserDefaults.standard)   // env 생성
        timelineVC.viewModel = TimelineViewModel(environment: env)                      // env 주입
    }

}

