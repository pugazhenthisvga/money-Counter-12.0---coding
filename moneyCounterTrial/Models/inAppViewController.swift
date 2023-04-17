//
//  ViewController.swift
//  SwiftyStoreKit
//

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import StoreKit
import MessageUI
import SafariServices
import Network
var productConverter :  SKProduct?
let defaults = UserDefaults.standard
let testDevideId = "74e0d081a2a5956027421faf483d312c"
let appIdString = "https://itunes.apple.com/app/id522348381"    
let ohmYellowColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
let currencyModel = CurrencyModel()

class inAppViewController: NSObject{
   // var localeCurrencyCode : String =  "USD"
    //localeCurrencyCode =  NSLocale.current.currencyCode
   // var selectedCurrency : String = "USD"
    //var baseCurrencyCode : String? = NSLocale.current.currencyCode
    var baseCurrencyCode : String = NSLocale.current.currencyCode ?? "USD"
    var selectedCurrency: String {
        
        get {return baseCurrencyCode }
        set { baseCurrencyCode = newValue }
    }
    var internetAvailable : Bool = true
    static let shared = inAppViewController()
    let monitor = NWPathMonitor()
    func checkInternet(){
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Yay! We have internet!")
                inApp.internetAvailable = true
            }else{
                inApp.internetAvailable = false
                print("Ooops! We have no internet!")
            }
            
        }
    }
    var arrayINR : [Int] = []
    var arrayyyyINRTotals : [Double] = []
    var INRResults : String = ""
    
    var arrayJMD : [Int] = []
    var arrayyyyJMDTotals : [Double] = []
    var JMDResults : String = ""
    
    var arrayTWD : [Int] = []
    var arrayyyyTWDTotals : [Double] = []
    var TWDResults : String = ""
    
    var arrayBYN : [Int] = []
    var arrayyyyBYNTotals : [Double] = []
    var BYNResults : String = ""
    
    var arrayHUF : [Int] = []
    var arrayyyyHUFTotals : [Double] = []
    var HUFResults : String = ""
    
    var arrayCZK : [Int] = []
    var arrayyyyCZKTotals : [Double] = []
    var CZKResults : String = ""
    
    var arrayEGP : [Int] = []
    var arrayyyyEGPTotals : [Double] = []
    var EGPResults : String = ""
    
    var arrayILS : [Int] = []
    var arrayyyyILSTotals : [Double] = []
    var ILSResults : String = ""
    
    var arraySAR : [Int] = []
    var arrayyyySARTotals : [Double] = []
    var SARResults : String = ""
    
    var arrayUSD : [Int] = []
    var arrayyyyUSDTotals : [Double] = []
    var USDResults : String = ""
    
    var arrayEUR : [Int] = []
    var arrayyyyEURTotals : [Double] = []
    var EURResults : String = ""
    
    var arrayGBP : [Int] = []
    var arrayyyyGBPTotals : [Double] = []
    var GBPResults : String = ""
    
    var arrayKWD : [Int] = []
    var arrayyyyKWDTotals : [Double] = []
    var KWDResults : String = ""
    
    var arrayCAD : [Int] = []
    var arrayyyyCADTotals : [Double] = []
    var CADResults : String = ""
    
    var arrayMYR : [Int] = []
    var arrayyyyMYRTotals : [Double] = []
    var MYRResults : String = ""
    
    var arraySGD : [Int] = []
    var arrayyyySGDTotals : [Double] = []
    var SGDResults : String = ""
    
    var arrayHKD : [Int] = []
    var arrayyyyHKDTotals : [Double] = []
    var HKDResults : String = ""
    
    var arrayRON : [Int] = []
    var arrayyyyRONTotals : [Double] = []
    var RONResults : String = ""
    
    var arrayCNY : [Int] = []
    var arrayyyyCNYTotals : [Double] = []
    var CNYResults : String = ""
    
    var arrayCHF : [Int] = []
    var arrayyyyCHFTotals : [Double] = []
    var CHFResults : String = ""
    
    var arrayAUD : [Int] = []
    var arrayyyyAUDTotals : [Double] = []
    var AUDResults : String = ""
    
    var arrayJPY : [Int] = []
    var arrayyyyJPYTotals : [Double] = []
    var JPYResults : String = ""
    
    var arraySEK : [Int] = []
    var arrayyyySEKTotals : [Double] = []
    var SEKResults : String = ""
    
    var arrayZAR : [Int] = []
    var arrayyyyZARTotals : [Double] = []
    var ZARResults : String = ""
    
    var arrayMXN : [Int] = []
    var arrayyyyMXNTotals : [Double] = []
    var MXNResults : String = ""
    
    var arrayRUB : [Int] = []
    var arrayyyyRUBTotals : [Double] = []
    var RUBResults : String = ""
    
    var arrayCUP : [Int] = []
    var arrayyyyCUPTotals : [Double] = []
    var CUPResults : String = ""
    
 
    var arrayKRW : [Int] = []
    var arrayyyyKRWTotals : [Double] = []
    var KRWResults : String = ""
    
    var arrayMUR : [Int] = []
    var arrayyyyMURTotals : [Double] = []
    var MURResults : String = ""
    
    var arrayPLN : [Int] = []
    var arrayyyyPLNTotals : [Double] = []
    var PLNResults : String = ""
    
    var arrayPEN : [Int] = []
    var arrayyyyPENTotals : [Double] = []
    var PENResults : String = ""
    
    var arrayPHP : [Int] = []
    var arrayyyyPHPTotals : [Double] = []
    var PHPResults : String = ""
    
    var arrayCLP : [Int] = []
    var arrayyyyCLPTotals : [Double] = []
    var CLPResults : String = ""
    
    var arrayBRL : [Int] = []
    var arrayyyyBRLTotals : [Double] = []
    var BRLResults : String = ""
    
    var arrayTRY : [Int] = []
    var arrayyyyTRYTotals : [Double] = []
    var TRYResults : String = ""
    
    var arrayNZD : [Int] = []
    var arrayyyyNZDTotals : [Double] = []
    var NZDResults : String = ""
    
    var arrayNOK : [Int] = []
    var arrayyyyNOKTotals : [Double] = []
    var NOKResults : String = ""
    
    var arrayUYU : [Int] = []
    var arrayyyyUYUTotals : [Double] = []
    var UYUResults : String = ""
    
    var arrayDOP : [Int] = []
    var arrayyyyDOPTotals : [Double] = []
    var DOPResults : String = ""
    
    var arrayMVR : [Int] = []
    var arrayyyyMVRTotals : [Double] = []
    var MVRResults : String = ""
    
    var arrayTHB : [Int] = []
    var arrayyyyTHBTotals : [Double] = []
    var THBResults : String = ""
    
    var arrayCOP : [Int] = []
    var arrayyyyCOPTotals : [Double] = []
    var COPResults : String = ""
    var arrayARS : [Int] = []
    var arrayyyyARSTotals : [Double] = []
    var ARSResults : String = ""
    var defaultCurrencyPath = NSIndexPath(row: 0, section: 0)
    var keyboardHeight : CGFloat = 0.0
    var calculatorTitle : String = ""
    var calculatorIndex : Int = 0
    var calculatorUnits : Int = 0
     
    let singleSpace = " "
    let doubleSpace = "  "
    let trebleSpace = "   "
    var selectedIndex : Int = 1
    
    let enterText = NSLocalizedString("from_name", comment: "")
    var inputKey : Bool = false
    var soundKey : Bool = false
    var rowCount : Int = 0
    
    func coinCount(selectedCurrency:String) -> Int{
        switch selectedCurrency {
        case "JMD":
            return currencyModel.jmdStruct.inrDollar.count
        case "TWD":
            return currencyModel.twdStruct.inrDollar.count
        case "BYN":
            return currencyModel.bynStruct.inrDollar.count
        case "HUF":
            return currencyModel.hufStruct.inrDollar.count
        case "CZK":
            return currencyModel.czkStruct.inrDollar.count
        case "EGP":
            return currencyModel.egpStruct.inrDollar.count
        case "INR":
            return currencyModel.inrStruct.inrDollar.count
        case "USD":
            return currencyModel.usdStruct.inrDollar.count
        case "EUR":
            return currencyModel.eurStruct.inrDollar.count
        case "RON":
            return currencyModel.ronStruct.inrDollar.count
        case "AUD":
            return currencyModel.audStruct.inrDollar.count
        case "SGD":
            return currencyModel.sgdStruct.inrDollar.count
        case "MYR":
            return currencyModel.myrStruct.inrDollar.count
        case "HKD":
            return currencyModel.hkdStruct.inrDollar.count
        case "SEK":
            return currencyModel.sekStruct.inrDollar.count
        case "CHF":
            return currencyModel.chfStruct.inrDollar.count
        case "CAD":
            return currencyModel.cadStruct.inrDollar.count
        case "GBP":
            return currencyModel.gbpStruct.inrDollar.count
       
        case "NZD":
            return currencyModel.nzdStruct.inrDollar.count
        case "NOK":
            return currencyModel.nokStruct.inrDollar.count
        case "ARS":
            return currencyModel.arsStruct.inrDollar.count
        case "CNY":
            return currencyModel.cnyStruct.inrDollar.count
        case "ZAR":
            return currencyModel.zarStruct.inrDollar.count
        case "MXN":
            return currencyModel.mxnStruct.inrDollar.count
        case "RUB":
            return currencyModel.mxnStruct.inrDollar.count
        case "DOP":
            return currencyModel.dopStruct.inrDollar.count
        case "MVR":
            return currencyModel.mvrStruct.inrDollar.count
        case "JPY":
            return currencyModel.jpyStruct.inrDollar.count
        case "KRW":
            return currencyModel.krwStruct.inrDollar.count
        case "KWD":
            return currencyModel.kwdStruct.inrDollar.count
        case "MUR":
            return currencyModel.murStruct.inrDollar.count
        case "CUP":
            return currencyModel.cupStruct.inrDollar.count
        case "PLN":
            return currencyModel.plnStruct.inrDollar.count
        case "PEN":
            return currencyModel.penStruct.inrDollar.count
        case "PHP":
            return currencyModel.phpStruct.inrDollar.count
        case "CLP":
            return currencyModel.clpStruct.inrDollar.count
        case "BRL":
            return currencyModel.brlStruct.inrDollar.count
        case "TRY":
            return currencyModel.tryStruct.inrDollar.count
        case "UYU":
            return currencyModel.uyuStruct.inrDollar.count
        case "THB":
            return currencyModel.thbStruct.inrDollar.count
        case "COP":
            return currencyModel.copStruct.inrDollar.count
        default:
            return 0
        }
        
    }
    
    func setTitle(title : String)->UILabel{
        let TITLELABEL : UILabel = UILabel(frame: CGRect.zero)
        TITLELABEL.frame = CGRect(x: 15, y: 0, width: 300, height: 40) as CGRect
        TITLELABEL.backgroundColor = UIColor.clear
        TITLELABEL.textColor = .systemGray
        TITLELABEL.numberOfLines = 2  //  Helvetica Bold 14.0
        TITLELABEL.font = UIFont (name: "Avenir-Medium", size: 20)
        TITLELABEL.adjustsFontSizeToFitWidth     = true
        TITLELABEL.text = title
        TITLELABEL.textAlignment = NSTextAlignment.center
        return TITLELABEL
    }
//    func setTitleWithColor(title : String,color :UIColor)->UILabel{
//        let TITLELABEL : UILabel = UILabel(frame: CGRect.zero)
//        TITLELABEL.frame = CGRect(x: 15, y: 0, width: 300, height: 40) as CGRect
//        TITLELABEL.backgroundColor = UIColor.clear
//        TITLELABEL.numberOfLines = 2  //  Helvetica Bold 14.0
//        TITLELABEL.font = UIFont (name: "Avenir-Medium", size: 20)
//        TITLELABEL.adjustsFontSizeToFitWidth     = true
//        TITLELABEL.text = title
//        TITLELABEL.textColor = color
//        TITLELABEL.textAlignment = NSTextAlignment.center
//        return TITLELABEL
//    }
//    func setTitleWithColorPad(title : String,color :UIColor)->UILabel{
//        let TITLELABEL : UILabel = UILabel(frame: CGRect.zero)
//        TITLELABEL.frame = CGRect(x: 15, y: 0, width: 300, height: 40) as CGRect
//        TITLELABEL.backgroundColor = UIColor.clear
//        TITLELABEL.numberOfLines = 2  //  Helvetica Bold 14.0
//        TITLELABEL.font = UIFont (name: "Avenir-Medium", size: 30)
//        TITLELABEL.adjustsFontSizeToFitWidth     = true
//        TITLELABEL.text = title
//        TITLELABEL.textColor = color
//        TITLELABEL.textAlignment = NSTextAlignment.center
//        return TITLELABEL
//    }
//    func setTitleforTableView(title : String)->UILabel{
//        let TITLELABEL : UILabel = UILabel(frame: CGRect.zero)
//        TITLELABEL.frame = CGRect(x: 15, y: 0, width: 300, height: 40) as CGRect
//        TITLELABEL.backgroundColor = UIColor.clear
//        TITLELABEL.textColor = .white
//        TITLELABEL.numberOfLines = 2  //  Helvetica Bold 14.0
//        TITLELABEL.font = UIFont (name: "Avenir-Medium", size: 20)
//        TITLELABEL.adjustsFontSizeToFitWidth     = true
//        TITLELABEL.text = title
//        TITLELABEL.textAlignment = NSTextAlignment.center
//        return TITLELABEL
//    }
    
    func setTitleForPad(title : String)->UILabel{
        let TITLELABEL : UILabel = UILabel(frame: CGRect.zero)
        TITLELABEL.frame = CGRect(x: 15, y: 0, width: 300, height: 40) as CGRect
        TITLELABEL.backgroundColor = UIColor.clear
        TITLELABEL.textColor = .systemGray
        TITLELABEL.numberOfLines = 2  //  Helvetica Bold 14.0
        TITLELABEL.font = UIFont (name: "Avenir-Medium", size: 25)
        TITLELABEL.adjustsFontSizeToFitWidth     = true
        TITLELABEL.text = title
        TITLELABEL.textAlignment = NSTextAlignment.center
        
        return TITLELABEL
    }
    func setLabelTitle(title:String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.font =  UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = .systemGray   
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true;
        label.translatesAutoresizingMaskIntoConstraints = true
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: label.superview, attribute: .centerX, multiplier: -0.5, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .lessThanOrEqual, toItem: label.superview, attribute: .width, multiplier: 0.5, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: label.superview, attribute: .centerY, multiplier: 1, constant: 0))
        label.superview?.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: label.superview, attribute: .height, multiplier: 1, constant: 0))
        return label
    }
    
}

