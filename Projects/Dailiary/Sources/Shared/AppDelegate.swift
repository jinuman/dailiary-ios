//
//  AppDelegate.swift
//  Dailiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool
    {
        Thread.sleep(forTimeInterval: 0.3)

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
        
        guard let titleFont = UIFont(name: "SangSangShinb7", size: 20) else { return }
        guard let largeTitleFont = UIFont(name: "SangSangShinb7", size: 34) else { return }
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [.font: titleFont]
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [.font: largeTitleFont]
        
        navigationController.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        
        guard let backImage = backgroundImage else { return }
        navigationController.navigationBar.barTintColor = UIColor(patternImage: backImage)
    }
    
    private func environmentForInject() -> Environment {
        
        // Temporary dummy data 
        let diaries: [Diary] = [
            // 어제
            Diary(createdAt: Date.before(1), text: longText),
            Diary(createdAt: Date.before(1), text: "어제 일기"),
            // 2일 전
            Diary(createdAt: Date.before(2), text: "2일 전 일기"),
            Diary(createdAt: Date.before(2), text: "2일 전 일기"),
            // 3일 전
            Diary(createdAt: Date.before(3), text: "3일 전 일기"),
            Diary(createdAt: Date.before(3), text: "3일 전 일기"),
            Diary(createdAt: Date.before(3), text: "3일 전 일기")
        ]
        
        let repository = InMemoryDiaryRepository(diaries: diaries)
        
        // environment 생성
        let environment = Environment(
            diaryRepository: repository,
            settings: UserDefaults.standard
        )
        
        return environment
    }

}

let longText: String = """
Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
"""

