/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The scene delegate.
 */

import UIKit
import SwiftUI
import Amplify

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var contentView: ContentView?
    var appState: AppState?
    let authSessManager = AuthSessionManager.shared
    let deviceFetcher = GuardianManager.shared
    let eventFetcher = EventFetcher()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.contentView = ContentView()
            self.appState = AppState()
            self.window = window
            renderRoot()
        }
    }
    
    func renderRoot() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var rootController: UIViewController? = nil
        
        DispatchQueue.main.async {
            switch self.authSessManager.authState {
            case .session(let user):
                
                guard let deviceId = UIDevice.current.identifierForVendor else {
                    fatalError("Unable to get a device ID!")
                }
                self.reloadHome()
            default:
                rootController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                let navigationController = UINavigationController(rootViewController: rootController!)
                print("Showing login screen")
                self.window?.rootViewController = navigationController
            }
            
            self.window?.makeKeyAndVisible()
        }
    }
    
    func reloadHome() {
        if let window = self.window {
            window.rootViewController = UIHostingController(
                rootView: self.contentView
                    .environmentObject(self.appState!)
                    .environmentObject(self.deviceFetcher)
                    .environmentObject(self.eventFetcher))
            window.makeKeyAndVisible()
            
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
    }
    
}

