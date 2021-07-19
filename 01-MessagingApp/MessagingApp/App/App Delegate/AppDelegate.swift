import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
//		launchFormStoryBoard()
		
			launchFromCode()
			return true
  }
	
	func launchFromCode() {
		let viewController = TabBarController()
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}
	
	func launchFormStoryBoard() {

//		1
	 let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
	 // 2
	 let viewController =
		 storyboard.instantiateInitialViewController()
	 // 3
	 window = UIWindow(frame: UIScreen.main.bounds)
	 // 4
	 window?.rootViewController = viewController
	 // 5
	 window?.makeKeyAndVisible()
	}
}
