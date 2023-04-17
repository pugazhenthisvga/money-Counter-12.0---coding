
//  AppDelegate.swift
//  Created by V PUGAZHENTHI on 17/08/20.
//  Copyright © 2020 V PUGAZHENTHI. All rights reserved.

import UIKit
import CoreData
import GoogleMobileAds
import StoreKit
import Siren
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize the Google Mobile Ads SDK.
            GADMobileAds.sharedInstance().start(completionHandler: nil)

        inAppViewController.shared.checkInternet()
        IAPManager.shared.startObserving()
        minimalCustomizationPresentationExample()
        StoreReviewHelper.incrementAppOpenedCount()
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().tintColor = .systemTeal
        UITabBar.appearance().unselectedItemTintColor = .systemGray
         
        UINavigationBar.appearance().tintColor = UIColor.systemTeal
        let darkModeStatus = defaults.bool(forKey: "darkMode")
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = darkModeStatus == true ? .dark : .light
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        saveData()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
        saveData()
    }
    func saveData(){
        switch inApp.selectedCurrency {
        case "INR":
            //defaults.set(inApp.arrayINR, forKey: "arrayINR")
            //defaults.set(inApp.arrayyyyINRTotals, forKey: "arrayyyyINRTotals")
            //inApp.INRResults = dataModel!.resultString
            //defaults.set(inApp.INRResults, forKey: "INRResults")
            break
        default: break
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Money_Counter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {

  /// The simplest implementation of Siren.
  /// All default rules are implemented and the
  /// results of the completion handler are ignored.
  func defaultExample() {
      Siren.shared.wail()
  }

  /// The simplest implementation of Siren.
  /// All default rules are implemented and the
  /// results of the completion handler are returned or an error is returned.
  func defaultExampleUsingCompletionHandler() {
      Siren.shared.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }

 

  /// Minor customization to Siren's update alert presentation.
  func minimalCustomizationPresentationExample() {
      let siren = Siren.shared
      siren.rulesManager = RulesManager(globalRules: .annoying)
      siren.presentationManager = PresentationManager(alertTintColor: .brown,
                                                      appName: NSLocalizedString("moneyCounter", comment: ""))
      siren.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }
 
 

  /// How to present an alert every time the app is foregrounded.
  func annoyingRuleExample() {
      let siren = Siren.shared
      siren.rulesManager = RulesManager(globalRules: .annoying)

      siren.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }

  /// How to present an alert every time the app is foregrounded.
  /// This will block the user from using the app until they update the app.
  /// Setting `showAlertAfterCurrentVersionHasBeenReleasedForDays` to `0` IS NOT RECOMMENDED
  /// as it will cause the user to go into an endless loop to the App Store if the JSON results
  /// update faster than the App Store CDN.
  ///
  /// The `0` value is illustrated in this app as an example on how to change how quickly an alert is presented.
  func hyperCriticalRulesExample() {
      let siren = Siren.shared
      siren.rulesManager = RulesManager(globalRules: .critical,
                                        showAlertAfterCurrentVersionHasBeenReleasedForDays: 2)

      siren.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }

 
  /// An example on how to present your own custom alert using Siren's localized Strings and version checking cadence.
  func customAlertRulesExample() {
      let siren = Siren.shared
      // The key for using custom alerts is to set the `alertType` to `.none`.
      // The `Results` type will return localized strings for your app's custom modal presentation.
      // The `promptFrequency` allows you to customize how often Siren performs the version check before returning a non-error result back into your app, prompting your custom alert functionality.
      let rules = Rules(promptFrequency: .immediately, forAlertType: .none)
      siren.rulesManager = RulesManager(globalRules: rules)

      siren.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }

  /// An example on how to change the App Store region that your app in which your app is available.
  /// This should only be used if your app is not available in the US App Store.
  /// This example function illustrates how this can be done by checking against the Russian App Store.
  func appStoreCountryChangeExample() {
      let siren = Siren.shared
      siren.apiManager = APIManager(country: .russia)

      siren.wail { results in
          switch results {
          case .success(let updateResults):
              print("AlertAction ", updateResults.alertAction)
              print("Localization ", updateResults.localization)
              print("Model ", updateResults.model)
              print("UpdateType ", updateResults.updateType)
          case .failure(let error):
              print(error.localizedDescription)
          }
      }
  }
 
}
