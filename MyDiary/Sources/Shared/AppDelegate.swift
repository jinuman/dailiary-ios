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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
        
        let timelineViewModel = TimelineViewModel(environment: self.environmentForInject())
        let timelineViewController = TimelineViewController(viewModel: timelineViewModel)
        
        window.rootViewController =
            UINavigationController(rootViewController: timelineViewController)
        window.makeKeyAndVisible()
        
        self.customizeNavigationBar()
        
        return true
    }
    
    // MARK: - Custom methods
    private func customizeNavigationBar() {
        guard let navigationController =
            self.window?.rootViewController as? UINavigationController else { return }
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = UIBarStyle.default
        navigationController.navigationBar.tintColor = UIColor.black    // BarButton color
        
        let backgroundImage = UIImage.gradientImage(
            with: [.gradientStart, .gradientEnd],
            size: CGSize(width: UIScreen.main.bounds.size.width, height: 1)
        )
        
        guard let image = backgroundImage else { return }
        navigationController.navigationBar.barTintColor = UIColor(patternImage: image)
        
        guard
            let titleFont = UIFont(name: "SangSangShinb7", size: 20),
            let largeTitleFont = UIFont(name: "SangSangShinb7", size: 34) else { return }
        
        let titleTextAttributes: [NSAttributedString.Key : Any] = [.font : titleFont]
        let largeTitleTextAttributes: [NSAttributedString.Key : Any] = [.font : largeTitleFont]
        
        navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
    }
    
    private func environmentForInject() -> Environment {
        
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
        
        let repository: InMemoryDiaryRepository = InMemoryDiaryRepository(diaries: diaries)
        
        // environment 생성
        let environment = Environment(
            diaryRepository: repository,
            settings: UserDefaults.standard
        )
        
        return environment
    }

}

