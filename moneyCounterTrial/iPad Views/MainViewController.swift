//
//  MainViewController.swift
//  CustomSplitControl

import UIKit
import StoreKit
private let inAppSegue = "inAppSegue"
private let itemsPerRow: CGFloat = 2
 
class MainViewController: UIViewController  ,SKStoreProductViewControllerDelegate ,UICollectionViewDelegate,UICollectionViewDataSource

{
    let dataBase = DataBaseClass()
    private let edgeInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private let edgeInsetTop = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
     
    var calculatorUnits : Int = 0
    var calculatorIndex : Int = 0
    var civilIndex :Int = 1
    var selectedRow : Candy!
    var defaultCurrencyPath = NSIndexPath(row: 0, section: 0)
    // outlets
    @IBOutlet weak var removeAdsButton : UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
  //  @IBOutlet weak var containerView: UIView!
    @IBOutlet var appNameTitleLabel : UILabel!
    @IBOutlet var appNameImageView : UIImageView!
     
    var candies = [Candy]()
    // var containerViewController = ContainerViewController()
    var menuEnabled = true {
        didSet {
            let targetAlpha: CGFloat
            if menuEnabled {
                targetAlpha = 1.0
                collectionView.allowsSelection = true
            } else {
                targetAlpha = 1.0
                collectionView.allowsSelection = false
            }
            UIView.animate(withDuration: 0.5, animations: { self.collectionView.alpha = targetAlpha })
        }
    }
    var currencyArray = [String]()
    var flagArray = [String]()
    
    var localeCurrencyCode : String?
    func setCurrencyArray(code:String) -> (currencyArray:[String],flagArray :[String]) {
        switch self.localeCurrencyCode {
        case "USD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR", "THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "ILS":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["ILS","USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR", "THB","COP","ARS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["ILS","USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","JMD","EGP"]
            break
        case "GBP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["GBP","USD","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["GBP","USD","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "BYN":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["GBP","USD","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["GBP","USD","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
        case "EUR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["EUR", "RON", "HUF","USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["EUR", "RON", "HUF","USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "RON":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["RON","EUR", "HUF","USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["RON","EUR", "HUF","USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "HUF":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["HUF","EUR", "RON", "USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["HUF","EUR", "RON", "USD","GBP","CAD","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
        case "CAD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CAD","USD","EUR", "RON", "HUF","GBP","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CAD","USD","EUR", "RON", "HUF","GBP","AUD","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
        case "AUD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["AUD","USD","CAD","EUR", "RON", "HUF","GBP","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["AUD","USD","CAD","EUR", "RON", "HUF","GBP","CHF","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
        case "CHF":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CHF","USD","AUD","CAD","EUR", "RON", "HUF","GBP","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CHF","USD","AUD","CAD","EUR", "RON", "HUF","GBP","CNY","TWD","HKD","SGD","KWD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
        case "CNY":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CNY","TWD","USD","KWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CNY","TWD","USD","KWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "TWD":
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["TWD","CNY","USD","KWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["TWD","CNY","USD","KWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "HKD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["HKD","USD","KWD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["HKD","USD","KWD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
            
        case "SGD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["SGD","USD","KWD","HKD","CNY","TWD","MYR","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["SGD","USD","KWD","HKD","CNY","TWD","MYR","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "MYR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["MYR","USD","KWD","SGD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["MYR","USD","KWD","SGD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "INR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["INR","USD","KWD","MYR","SGD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["INR","USD","KWD","MYR","SGD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "JPY":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["JPY","USD","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["JPY","USD","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "SEK":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["SEK","USD","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["SEK","USD","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "ZAR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["ZAR","USD","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["ZAR","USD","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "MXN":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["MXN","USD","COP","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["MXN","USD","COP","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","ARS","ILS","JMD","EGP"]
            break
            
        case "COP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["COP","USD","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["COP","USD","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","ARS","ILS","JMD","EGP"]
            break
            
        case "RUB":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["RUB", "BYN","USD","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["RUB", "BYN","USD","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "CUP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CUP","CZK","USD","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CUP","CZK","USD","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "CZK":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CZK","CUP","USD","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CZK","CUP","USD","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
      
            
        case "KRW":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["KRW","USD","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["KRW","USD","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "MUR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["MUR","USD","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["MUR","USD","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "PLN":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["PLN","USD","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["PLN","USD","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "PHP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["PHP","USD","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["PHP","USD","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "CLP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["CLP","USD","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["CLP","USD","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "BRL":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["BRL","USD","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["BRL","USD","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "TRY":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["TRY","USD","BRL","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["TRY","USD","BRL","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NZD","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "NZD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["NZD","USD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["NZD","USD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","SEK","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","NOK","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "NOK":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["NOK","USD","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["NOK","USD","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","UYU", "DOP", "MVR","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "UYU":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["UYU","USD", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["UYU","USD", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "DOP":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["DOP","USD", "MVR","UYU","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["DOP","USD", "MVR","UYU","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
            
        case "MVR":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["MVR","USD","DOP", "UYU","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["MVR","USD","DOP", "UYU","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","MYR","SGD","KWD","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","THB","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "THB":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["THB","USD","SGD","KWD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["THB","USD","SGD","KWD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ARS","ILS","JMD","EGP"]
            break
            
        case "ARS":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["ARS","THB","USD","SGD","KWD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["ARS","THB","USD","SGD","KWD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ILS","JMD","EGP"]
            
            break
            
        case "KWD":
            
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["KWD","THB","USD","SGD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["KWD","ARS","THB","USD","SGD","MYR","UYU", "DOP", "MVR","NOK","SEK","NZD","BRL", "TRY","CLP","PHP","PLN","MUR","KRW","CUP","CZK","RUB", "BYN","MXN","ZAR","JPY","INR","HKD","CNY","TWD","CHF","AUD","CAD","EUR", "RON", "HUF","GBP","PEN","COP","ILS","JMD","EGP"]
            
            break
        default:
            currencyArray = defaults.stringArray(forKey: "currencyArray")  ?? ["USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU","DOP", "MVR","THB","COP","KWD","ARS","ILS","JMD","EGP"]
            flagArray = defaults.stringArray(forKey: "flagArray")  ?? ["USD","GBP","EUR", "RON", "HUF","CAD","AUD","CHF","CNY","TWD","HKD","SGD","MYR","INR","JPY","SEK","ZAR","MXN","RUB", "BYN","CUP","CZK","KRW","MUR","PLN","PEN","PHP","CLP","BRL", "TRY","NZD","NOK","UYU", "DOP", "MVR","THB","COP","KWD","ARS","ILS","JMD","EGP"]
            break
        }
        return(currencyArray,flagArray)
    }

    fileprivate func  selectDefaultCurrency() {
        
        let data1 = UserDefaults.standard.object(forKey: "defaultCurrency") as? NSData
        if ((data1 != nil)){
        inApp.defaultCurrencyPath = NSKeyedUnarchiver.unarchiveObject(with: data1! as Data) as! NSIndexPath}
        
        self.collectionView.selectItem(at: inApp.defaultCurrencyPath as IndexPath    , animated: true, scrollPosition: .centeredHorizontally)
        self.collectionView(self.collectionView, didSelectItemAt:inApp.defaultCurrencyPath as IndexPath)
    }
    // new inApp purchase methods
 
 
 
    func showNoBuyAlert(withMessage message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("moneyCounter", comment: ""), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    fileprivate func checkSubscription(){
        if( UserDefaults.standard.bool(forKey: IAPManager.IAPHelperPurchaseNotification) == true )
        {
            self.view.reloadInputViews()
        }else
        {
            if self.view.window != nil{
                self.view.endEditing(true)
               
            }
        }
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    @objc func showRemoveAdsView(){
        self.performSegue(withIdentifier: "inAppSegue", sender: self)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("view did Appear")
    }
    // new inApp purchase methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        localeCurrencyCode = inApp.selectedCurrency
        let currencyResult = setCurrencyArray(code: localeCurrencyCode!)
        currencyArray = currencyResult.currencyArray
        flagArray = currencyResult.flagArray
        inApp.selectedCurrency = currencyArray[0]
        
           
        removeAdsButton.addTarget(self, action:#selector(showRemoveAdsView), for: .touchUpInside)
        removeAdsButton.layer.cornerRadius = 5.0
        removeAdsButton.setTitleColor(UIColor.systemTeal, for:.normal)
        removeAdsButton.setTitle(NSLocalizedString("removeAds", comment: ""), for: .normal)
        removeAdsButton.titleLabel?.font =  UIFont (name: "Avenir-Heavy", size:18)
        self.collectionView.backgroundColor = UIColor.systemTeal

        self.appNameTitleLabel.layer.cornerRadius = 5.0
        self.appNameTitleLabel.clipsToBounds = true
        self.appNameImageView.layer.cornerRadius = 5.0
        self.appNameImageView.clipsToBounds = true
        self.appNameTitleLabel.text = NSLocalizedString("moneyCounter", comment: "nil")
        appNameTitleLabel.font = UIFont (name: "Avenir-Heavy", size:24)
        appNameTitleLabel.textColor = UIColor.systemTeal
      
        self.navigationController?.navigationBar.isTranslucent     = true
        // register cellscellfor
        collectionView!.register(UINib.init(nibName: "MemeCellPad", bundle: nil), forCellWithReuseIdentifier: "MemeCellPad")
        let currencySelectionStatus = UserDefaults.standard.bool(forKey: "currencySelectionStatus")
        if currencySelectionStatus == true{
            selectDefaultCurrency()
        }
        self.tabBarController?.viewControllers![0].tabBarItem.title = NSLocalizedString("Money", comment: "nil")
        self.tabBarController?.viewControllers![1].tabBarItem.title =  NSLocalizedString("More", comment: "nil")
    }
    // MARK: - In prepareForSegue, we should initialise the container, as the first segue is triggered upon loading of the container.
 
    // MARK: - Table view data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  currencyArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellPad", for: indexPath) as! MemeCellPad
        // Configure the cell
        // Configure the celldidlo
        cell.configureWithImage(index: indexPath.row,currencyArray:currencyArray,flagArray:flagArray)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !menuEnabled { return }
        //self.navigationItem.titleView = inApp.setTitle(title: inApp.calculatorTitle)
        if let indexPaths = self.collectionView!.indexPathsForSelectedItems{
            let indexPath = indexPaths[0] as NSIndexPath
            inApp.calculatorTitle = currencyArray[indexPath.item]
            inApp.selectedCurrency = currencyArray[indexPath.item]
            inApp.selectedIndex = indexPath.item
            let nameTwo = Notification.Name(rawValue:unitTwo)
            NotificationCenter.default.post(name:nameTwo,object: nil)
        }
    }
}
extension MainViewController : UICollectionViewDelegateFlowLayout {

    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = edgeInset.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem , height: widthPerItem)
        
    }
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInset
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return edgeInset.left
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //self.containerViewController.children[0].view.endEditing(true)
    }
}
extension UISegmentedControl {
    
    /// Present segments one below the other vertically.
    /// Be sure to re-set after inserting segments.
    var vertical : Bool {
        get {
            return abs(transform.b) > 0.001
        }
        set {
            // rotate view
            self.transform = newValue ? CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2)) : CGAffineTransform.identity
            
            let padding : CGFloat = 8
            let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            var size : CGSize
            var maxHeight : CGFloat = 50
            var totalWidth : CGFloat = 500
            
            // reverse rotate segment content
            for segment in subviews {
                for contentView in segment.subviews {
                    size = contentView.sizeThatFits(maxSize)
                    maxHeight = max(maxHeight, newValue ? size.width : size.height)
                    totalWidth += (newValue ? size.height : size.width) + padding
                    contentView.transform = newValue ? CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 2)) : CGAffineTransform.identity
                }
            }
            
            // adjust size
            bounds = CGRect(x: 0, y: 0, width: totalWidth/1 + padding, height: maxHeight + 2*padding)
        }
    }
    
    func scaleToFit(size: CGSize) { // keeps aspect ratio
        var frameSize = bounds.size
        if vertical { swap(&frameSize.width, &frameSize.height) }
        let scale = min(size.width / frameSize.width, size.height / frameSize.height)
        if scale < 1 {
            transform = transform.scaledBy(x: scale, y: scale)
        }
    }
}

