//
//  SceneDelegate.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-03.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            
            if FileService.fileExist(fileName: "LayoutSettings", fileType: .json) {
                self.configureUsingLocalLayoutSettings()
            } else {
                self.configureByFetchingExternalLayoutSettings()
            }
             
            window?.makeKeyAndVisible()
        }
    }
    
    private func configureByFetchingExternalLayoutSettings() {
        self.window?.rootViewController = FetchSettingsViewController()
    }
    
    private func configureUsingLocalLayoutSettings() {
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
        if let layoutSettingsObject = FileService.fetch(type: LayoutSettingsObject.self, fileName: "LayoutSettings", fileType: .json) {
            LayoutSettings.shared.layoutSettingsObject = layoutSettingsObject
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        AudioService.shared.stopSound()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

