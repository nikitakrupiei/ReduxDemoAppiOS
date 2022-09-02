//
//  AppDelegate.swift
//  ReduxDemoApp
//
//  Created by Nikita Krupiei on 12.08.2022.
//

import UIKit
import ReduxDemoCore
import ReSwift

let store: Store<AppState> = {
    createStore(middleware: [createRoutingMiddleware()])
}()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        coordinator = AppCoordinator(window: window)
        
        return true
    }
}

