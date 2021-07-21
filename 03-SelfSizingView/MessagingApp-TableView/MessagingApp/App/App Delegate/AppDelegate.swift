
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let viewController = MessagesTableViewController()
    let navigationViewController = UINavigationController(rootViewController: viewController)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationViewController
    window?.makeKeyAndVisible()
    return true
  }
}
