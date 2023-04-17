 
 import UIKit
 import StoreKit
 //private let reuseIdentifier = "geometricCell"
 private let itemsPerRow: CGFloat = 3
  
 let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
 let calculatorBackroudColor = UIColor(red: 52/255, green: 57/255, blue: 66/255, alpha: 1.0)
 let greenColor = UIColor(red: 85/255, green: 139/255, blue: 47/255, alpha: 1.0)
 let lightColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
 let lightBlueColor = UIColor(red: 17/255, green: 147/255, blue: 224/255, alpha: 1.0)
 let lightBlueColor1 = UIColor(red: 79/255, green: 173/255, blue: 248/255, alpha: 1.0)
 let darkBlueColor = UIColor(red: 33/255, green: 106/255, blue: 180/255, alpha: 1.0)
 let geoColor = UIColor(red: 239/255, green: 186/255, blue: 102/255, alpha: 1.0)
 let geoColorDark = UIColor(red: 250/255, green: 183/255, blue: 95/255, alpha: 1.0)
 let customColor = UIColor(red: 230/255, green: 240/255, blue: 240/255, alpha: 1.0)
 let yellowColor = UIColor(hexString: "#F9BE60")
 let calculatorBlueColor = UIColor(red: 50/255, green: 102/255, blue: 162/255, alpha: 1.0)
 let darkGreenColor = UIColor(hexString: "#bbf1fa")
 let lightGreenColor = UIColor(hexString: "#2a9d8f")
 let lightYellowColor = UIColor(hexString: "#e9c46a")
 let lightGreyColor = UIColor(hexString: "#264653")
 
 let bannerViewadUnitID = "ca-app-pub-9724087161177174/3990002938"
 let interstitialAdUnitId = "ca-app-pub-9724087161177174/2283035645"
 let moneyCOunterBlueColor  = UIColor(hexString: "07689F")
 let blueColorNew = UIColor(red: 20/255, green: 39/255, blue: 78/255, alpha: 1.0)
 let goldenColor = UIColor(red: 216/255, green: 158/255, blue: 82/255, alpha: 1.0)
 let newBlueColor = UIColor(hexString:"0566A2")
 let spacing:CGFloat = 2.0
 class MoneyCollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {
     
    
    
    
    private let edgeInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
    
    var candies = [Candy]()
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var currencyArray = [String]()
    var flagArray = [String]()
    var localeCurrencyCode : String?
    
    fileprivate func  selectDefaultCurrency() {
        let data1 = UserDefaults.standard.object(forKey: "defaultCurrency") as? NSData
        if ((data1 != nil)){
        inApp.defaultCurrencyPath = NSKeyedUnarchiver.unarchiveObject(with: data1! as Data) as! NSIndexPath}
        self.collectionView.selectItem(at: inApp.defaultCurrencyPath as IndexPath    , animated: true, scrollPosition: .centeredHorizontally)
        self.collectionView(self.collectionView, didSelectItemAt:inApp.defaultCurrencyPath as IndexPath)
    }
     fileprivate func checkDarkMode() {
         let darkModeStatus = defaults.bool(forKey: "darkMode")
         if darkModeStatus == true{
              
             overrideUserInterfaceStyle = .dark
         }else{
             
             overrideUserInterfaceStyle = .light
         }
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        inApp.defaultCurrencyPath = NSIndexPath(row: 0, section: 0)
        //self.collectionView.backgroundColor = UIColor(hexString: "07689F")
        self.collectionView.backgroundColor = UIColor.systemTeal
        self.navigationItem.titleView = inApp.setTitle(title: NSLocalizedString("moneyCounter", comment: ""))
        self.tabBarController?.viewControllers![0].tabBarItem.title = NSLocalizedString("Money", comment: "nil")
        self.tabBarController?.viewControllers![1].tabBarItem.title =  NSLocalizedString("More", comment: "nil")
        
        
        // Register cell classes
        collectionView!.register(UINib.init(nibName: "MemeCell", bundle: nil), forCellWithReuseIdentifier: "MemeCell")
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("moneyCounter", comment: "")
       // localeCurrencyCode = NSLocale.current.currencyCode
        localeCurrencyCode = inApp.selectedCurrency 
        let currencyResult = setCurrencyArray(code: localeCurrencyCode!)
        currencyArray = currencyResult.currencyArray
        flagArray = currencyResult.flagArray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        let currencySelectionStatus = UserDefaults.standard.bool(forKey: "currencySelectionStatus")
        if currencySelectionStatus == true{
            selectDefaultCurrency()
        }
        collectionView.layer.cornerRadius = 5.0
    }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier:currencyArray[indexPath.row], sender: collectionView)
        inApp.calculatorTitle = currencyArray[indexPath.item]
        inApp.selectedCurrency = currencyArray[indexPath.item]
        print("inApp.selectedCurrency : \(inApp.selectedCurrency    )")
        inApp.selectedIndex = indexPath.item
        print("inApp.selectedIndex :\(inApp.selectedIndex)")
        performSegue(withIdentifier:"currencySegue",sender:collectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPaths = self.collectionView!.indexPathsForSelectedItems{
            let indexPath = indexPaths[0] as NSIndexPath
            let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem //
        }
    }
 }
 // MARK: - Collection View Flow Layout Delegate
 extension MoneyCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  currencyArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCell
        // Configure the cell
        cell.configureWithImage(index: indexPath.row,currencyArray:currencyArray,flagArray:flagArray)
        return cell
    }
 
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
         if deviceIdiom == .pad{
             let paddingSpace = edgeInset.left * (itemsPerRow + 1)
             let availableWidth = collectionView.frame.width - paddingSpace
             let widthPerItem = availableWidth / itemsPerRow
             return CGSize(width: widthPerItem , height: widthPerItem)
         }else{
             let paddingSpace = edgeInset.left * (itemsPerRow + 1)
             let availableWidth = collectionView.frame.width - paddingSpace
             let widthPerItem = availableWidth / itemsPerRow
             return CGSize(width: widthPerItem , height: widthPerItem)
         }
     }
     //    // MARK: Collection View Delegate And Data Source Extension
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return edgeInset.left
     }
     //
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return edgeInset.left
     }
     //
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return edgeInset
     }
 }
