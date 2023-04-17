import Foundation
import StoreKit
let Defaults = UserDefaults.standard
struct UserDefaultsKeys {
static let APP_OPENED_COUNT = "APP_OPENED_COUNT"
}
struct StoreReviewHelper {
    static func incrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:
        guard var appOpenCount = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT) as? Int else {
            Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
            return
        }
        appOpenCount += 1
        print("App run count is : \(appOpenCount)")
        Defaults.set(appOpenCount, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
    }
    static func decrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:
        guard var appOpenCount = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT) as? Int else {
           // Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
            return
        }
        appOpenCount -= 1
        print("App run count is : \(appOpenCount)")
        Defaults.set(appOpenCount, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
    }
     
    static func checkAndAskForReview() { // call this whenever appropriate
        // this will not be shown everytime. Apple has some internal logic on how to show this.
        guard let appOpenCount = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT) as? Int else {
            Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
            return
        }
        
        switch appOpenCount {
        case 2,5:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%10 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is 1: \(appOpenCount)")
            break;
        }
    }
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            if (inApp.internetAvailable){
                 
                SKStoreReviewController.requestReview()
            }else{
                print("Ooops! We have no internet!")
                StoreReviewHelper.decrementAppOpenedCount()
            }
             
        } else {
            // Fallback on earlier versions
            // Try any other 3rd party or manual method here.
        }
    }
}
