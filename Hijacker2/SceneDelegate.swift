//
//  SceneDelegate.swift
//  Hijacker2
//
//  Created by albin holmberg on 2022-04-07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url{
            print(url)
            let components = URLComponents(
                            url: url,
                            resolvingAgainstBaseURL: false
                        )!
            ///let callBackUrl = components.queryItems?.first(where: $)
            
            
            
            var fakeSwishResponseUrl = "company://?res=%7B%22result%22:%22paid%22,%22amount%22:1,%22message%22:%22To%20Company%22,%22payee%22:%22+46738127016%22,%22version%22:2%7D"
            
            let appUrl = URL(string: fakeSwishResponseUrl)
            
            if UIApplication.shared.canOpenURL(appUrl! as URL) {
                UIApplication.shared.open(appUrl!)
            } else {
                print("App not installed")
            }
            
            
            /**let v:String? = components.queryItems?.first(where: {$0.name == "res"})?.value
            let data = Data(v.unsafelyUnwrapped.utf8)
            let decoder = JSONDecoder()
            let decoded = try? decoder.decode(Response.self, from: data)
            if decoded != nil{
                print(decoded.unsafelyUnwrapped.result)
                var status: String = ""
                if decoded.unsafelyUnwrapped.result == "paid"{
                    print("Payment completed!")
                    status = "Paid!"
                }else{
                    print("Payment not completed!")
                    status = "Not Paid!"
                }
                let alertController = UIAlertController(title: "Payment Status: ", message: status, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alertController.addAction(okAction)
                    
                    window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }else{
                print("no data was returned")
            }*/
            
        }
    }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

