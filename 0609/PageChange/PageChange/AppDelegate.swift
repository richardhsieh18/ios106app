
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        
        print("進入app")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        print("即將進入背景")
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        print("進入背景")
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        print("即將從背景進入到前景")
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        print("啟動app")
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        print("app終止")
    }


}

