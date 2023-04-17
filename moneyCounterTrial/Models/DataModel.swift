import Foundation
import CoreData
var inApp = inAppViewController()
class DataModel: NSObject {
    //MARK: step 2 Create a delegate property here.
    weak var collectionViewDelegate: CustomInputCollectionViewControllerDelegate?
    // MARK: Properties
    var entries: [Int]
    var totals: [Double]
    var resultString = ""
    var result:Double = 0{
        didSet { //called when item changes
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = inApp.selectedCurrency
            let resultString = formatter.string(from: self.result as NSNumber)!
            self.resultString = resultString
            //MARK: step 4 call the delegate method from the protocol
            collectionViewDelegate?.setResultField()
        }
    }
    var count: Int { return entries.count }
    var countResult: Double { return result }
    
    //    // MARK: Methods
    init(entries: [Int],totals: [Double]) {
        self.entries = entries
        self.totals = totals
        switch inApp.selectedCurrency {
        case "EGP":
            if inApp.arrayEGP.count != 0 {
                self.entries = inApp.arrayEGP
                self.totals = inApp.arrayyyyEGPTotals
            }
            break
        case "JMD":
            if inApp.arrayJMD.count != 0 {
                self.entries = inApp.arrayJMD
                self.totals = inApp.arrayyyyJMDTotals
            }
            break
       
        case "INR":
            if inApp.arrayINR.count != 0 {
                self.entries = inApp.arrayINR
                self.totals = inApp.arrayyyyINRTotals
            }
            break
        case "ILS":
            if inApp.arrayILS.count != 0 {
                self.entries = inApp.arrayILS
                self.totals = inApp.arrayyyyILSTotals
            }
            break
        case "SAR":
            if inApp.arraySAR.count != 0 {
                self.entries = inApp.arraySAR
                self.totals = inApp.arrayyyySARTotals
            }
            break
        case "USD":
            if inApp.arrayUSD.count != 0 {
                self.entries = inApp.arrayUSD
                self.totals = inApp.arrayyyyUSDTotals
            }
            break
        case "EUR":
            if inApp.arrayEUR.count != 0 {
                self.entries = inApp.arrayEUR
                self.totals = inApp.arrayyyyEURTotals
            }
            break
        case "RON":
            if inApp.arrayRON.count != 0 {
                self.entries = inApp.arrayRON
                self.totals = inApp.arrayyyyRONTotals
            }
            break
        case "GBP":
            if inApp.arrayGBP.count != 0 {
                self.entries = inApp.arrayGBP
                self.totals = inApp.arrayyyyGBPTotals
            }
            break
        case "KWD":
            if inApp.arrayKWD.count != 0 {
                self.entries = inApp.arrayKWD
                self.totals = inApp.arrayyyyKWDTotals
            }
            break
        case "CAD":
            if inApp.arrayCAD.count != 0 {
                self.entries = inApp.arrayCAD
                self.totals = inApp.arrayyyyCADTotals
            }
            break
        case "MYR":
            if inApp.arrayMYR.count != 0 {
                self.entries = inApp.arrayMYR
                self.totals = inApp.arrayyyyMYRTotals
            }
            break
        case "SGD":
            if inApp.arraySGD.count != 0 {
                self.entries = inApp.arraySGD
                self.totals = inApp.arrayyyySGDTotals
            }
            break
        case "ZAR":
            if inApp.arrayZAR.count != 0 {
                self.entries = inApp.arrayZAR
                self.totals = inApp.arrayyyyZARTotals
            }
            break
        case "HKD":
            if inApp.arrayHKD.count != 0 {
                self.entries = inApp.arrayHKD
                self.totals = inApp.arrayyyyHKDTotals
            }
            break
       
        case "CNY":
            if inApp.arrayCNY.count != 0 {
                self.entries = inApp.arrayCNY
                self.totals = inApp.arrayyyyCNYTotals
            }
            break
        case "CHF":
            if inApp.arrayCHF.count != 0 {
                self.entries = inApp.arrayCHF
                self.totals = inApp.arrayyyyCHFTotals
            }
            break
        case "AUD":
            if inApp.arrayAUD.count != 0 {
                self.entries = inApp.arrayAUD
                self.totals = inApp.arrayyyyAUDTotals
            }
            break
        case "JPY":
            if inApp.arrayJPY.count != 0 {
                self.entries = inApp.arrayJPY
                self.totals = inApp.arrayyyyJPYTotals
            }
            break
        case "SEK":
            if inApp.arraySEK.count != 0 {
                self.entries = inApp.arraySEK
                self.totals = inApp.arrayyyySEKTotals
            }
            break
        case "TWD":
            if inApp.arrayTWD.count != 0 {
                self.entries = inApp.arrayTWD
                self.totals = inApp.arrayyyyTWDTotals
            }
            break
        case "BYN":
            if inApp.arrayBYN.count != 0 {
                self.entries = inApp.arrayBYN
                self.totals = inApp.arrayyyyBYNTotals
            }
            break
        case "HUF":
            if inApp.arrayHUF.count != 0 {
                self.entries = inApp.arrayHUF
                self.totals = inApp.arrayyyyHUFTotals
            }
            break
        case "CZK":
            if inApp.arrayCZK.count != 0 {
                self.entries = inApp.arrayCZK
                self.totals = inApp.arrayyyyCZKTotals
            }
            break
        case "MXN":
            if inApp.arrayMXN.count != 0 {
                self.entries = inApp.arrayMXN
                self.totals = inApp.arrayyyyMXNTotals
            }
            break
        case "RUB":
            if inApp.arrayRUB.count != 0 {
                self.entries = inApp.arrayRUB
                self.totals = inApp.arrayyyyRUBTotals
            }
            break
        case "CUP":
            if inApp.arrayCUP.count != 0 {
                self.entries = inApp.arrayCUP
                self.totals = inApp.arrayyyyCUPTotals
            }
            break
 
        case "KRW":
            if inApp.arrayKRW.count != 0 {
                self.entries = inApp.arrayKRW
                self.totals = inApp.arrayyyyKRWTotals
            }
            break
        case "MUR":
            if inApp.arrayMUR.count != 0 {
                self.entries = inApp.arrayMUR
                self.totals = inApp.arrayyyyMURTotals
            }
            break
        case "PLN":
            if inApp.arrayPLN.count != 0 {
                self.entries = inApp.arrayPLN
                self.totals = inApp.arrayyyyPLNTotals
            }
            break
        case "PEN":
            if inApp.arrayPEN.count != 0 {
                self.entries = inApp.arrayPEN
                self.totals = inApp.arrayyyyPENTotals
            }
            break
        case "PHP":
            if inApp.arrayPHP.count != 0 {
                self.entries = inApp.arrayPHP
                self.totals = inApp.arrayyyyPHPTotals
            }
            break
        case "CLP":
            if inApp.arrayCLP.count != 0 {
                self.entries = inApp.arrayCLP
                self.totals = inApp.arrayyyyCLPTotals
            }
            break
        case "BRL":
            if inApp.arrayBRL.count != 0 {
                self.entries = inApp.arrayBRL
                self.totals = inApp.arrayyyyBRLTotals
            }
            break
        case "TRY":
            if inApp.arrayTRY.count != 0 {
                self.entries = inApp.arrayTRY
                self.totals = inApp.arrayyyyTRYTotals
            }
            break
        case "NZD":
            if inApp.arrayNZD.count != 0 {
                self.entries = inApp.arrayNZD
                self.totals = inApp.arrayyyyNZDTotals
            }
            break
        case "NOK":
            if inApp.arrayNOK.count != 0 {
                self.entries = inApp.arrayNOK
                self.totals = inApp.arrayyyyNOKTotals
            }
            break
        case "UYU":
            if inApp.arrayUYU.count != 0 {
                self.entries = inApp.arrayUYU
                self.totals = inApp.arrayyyyUYUTotals
            }
            break
        case "DOP":
            if inApp.arrayDOP.count != 0 {
                self.entries = inApp.arrayDOP
                self.totals = inApp.arrayyyyDOPTotals
            }
            break
        case "MVR":
            if inApp.arrayMVR.count != 0 {
                self.entries = inApp.arrayMVR
                self.totals = inApp.arrayyyyMVRTotals
            }
            break
        case "THB":
            if inApp.arrayTHB.count != 0 {
                self.entries = inApp.arrayTHB
                self.totals = inApp.arrayyyyTHBTotals
            }
            break
        case "COP":
            if inApp.arrayCOP.count != 0 {
                self.entries = inApp.arrayCOP
                self.totals = inApp.arrayyyyCOPTotals
            }
            break
        case "ARS":
            if inApp.arrayARS.count != 0 {
                self.entries = inApp.arrayARS
                self.totals = inApp.arrayyyyARSTotals
            }
            break
        default:
            if inApp.arrayUSD.count != 0 {
                self.entries = inApp.arrayUSD
                self.totals = inApp.arrayyyyUSDTotals
            }
            self.entries = entries
            self.totals = totals
            break
        }
    }
    convenience init(numberOfEntries: Int,numberOfTotals:Int) {
        self.init(entries: [Int](repeating: 0, count: numberOfEntries), totals: [Double](repeating: 0, count: numberOfTotals))
    }
    subscript(_ index: Int) -> Int {
        return entries[index] * 1
    }
}
extension DataModel: CustomInputCellDelegate {
    func findTotal(at indexPath: IndexPath) {
    }
    
    // MARK: Input Related Extensions
    func insertText(_ text: String, at indexPath: IndexPath, didFinishUpdate: ((Int) -> ())?) {
        if let number = Int(text), number < 10 {
            let newEntry = entries[indexPath.item] * 10 + number
            guard newEntry <= 99999 else { return }
            entries[indexPath.item] = newEntry
            didFinishUpdate?(entries[indexPath.item])
        }
    }
    func deleteBackwards(at indexPath: IndexPath , didFinishUpdate: ((Int) -> ())?) {
        entries[indexPath.item] /= 10
        didFinishUpdate?(entries[indexPath.item])
    }
    
    func insertTotal(_ text: String, at indexPath: IndexPath, didFinishUpdate: ((Double) -> ())?) {
        switch inApp.selectedCurrency {
        case "INR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.inrStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.inrStruct.inr[i]
            }
            if (currencyModel.inrStruct.inr[indexPath.item] != 0.25){
                local = (local * 10).rounded()/10
                self.result = local
            } else {
                self.result = local
            }
            break
        case "EGP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.egpStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.egpStruct.inr[i]
            }
            self.result = local
            break
        case "JMD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.jmdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.jmdStruct.inr[i]
            }
            self.result = local
            break
       
        case "USD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.usdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.usdStruct.inr[i]
            }
            self.result = local
            break
        case "SAR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.sarStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.sarStruct.inr[i]
            }
            if (currencyModel.sarStruct.inr[indexPath.item] != 0.25){
                local = (local * 10).rounded()/10
                self.result = local
            } else {
                self.result = local
            }
            break
       
            
        case "ILS":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.ilsStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.ilsStruct.inr[i]
            }
            self.result = local
            break
            
        case "EUR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.eurStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.eurStruct.inr[i]
            }
            self.result = local
            break
        case "AUD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.audStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.audStruct.inr[i]
            }
            self.result = local
            break
        case "SGD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.sgdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.sgdStruct.inr[i]
            }
            self.result = local
            break
        case "MYR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.myrStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.myrStruct.inr[i]
            }
            self.result = local
            break
        case "HKD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.hkdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.hkdStruct.inr[i]
            }
            self.result = local
            break
        case "RON":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.ronStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.ronStruct.inr[i]
            }
            self.result = local
            break
        case "CHF":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.chfStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.chfStruct.inr[i]
            }
            self.result = local
            break
        case "CAD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.cadStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.cadStruct.inr[i]
            }
            self.result = local
            break
        case "GBP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.gbpStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.gbpStruct.inr[i]
            }
            self.result = local
            break
 
        case "NZD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.nzdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.nzdStruct.inr[i]
            }
            self.result = local
            break
        case "NOK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.nokStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.nokStruct.inr[i]
            }
            self.result = local
            break
        case "ARS":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.arsStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.arsStruct.inr[i]
            }
            self.result = local
            break
        case "CNY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.cnyStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.cnyStruct.inr[i]
            }
            self.result = local
            break
        case "ZAR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.zarStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.zarStruct.inr[i]
            }
            self.result = local
            break
        case "MXN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.mxnStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.mxnStruct.inr[i]
            }
            self.result = local
            break
        case "RUB":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.rubStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.rubStruct.inr[i]
            }
            self.result = local
            break
        case "DOP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.dopStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.dopStruct.inr[i])
            }
            self.result = local
            break
        case "MVR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.mvrStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.mvrStruct.inr[i])
            }
            self.result = local
            break
        case "JPY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.jpyStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.jpyStruct.inr[i])
            }
            self.result = local
            break
        case "KRW":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.krwStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.krwStruct.inr[i])
            }
            self.result = local
            break
        case "KWD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.kwdStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:3)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.kwdStruct.inr[i])
            }
            self.result = local
            break
        case "MUR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.murStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.murStruct.inr[i])
            }
            self.result = local
            break
        case "CUP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.cupStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.cupStruct.inr[i])
            }
            self.result = local
            break
        case "PLN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.plnStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.plnStruct.inr[i])
            }
            self.result = local
            break
        case "PEN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.penStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.penStruct.inr[i])
            }
            self.result = local
            break
        case "PHP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.phpStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.phpStruct.inr[i])
            }
            self.result = local
            break
        case "CLP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.clpStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.clpStruct.inr[i])
            }
            self.result = local
            break
        case "BRL":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.brlStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.brlStruct.inr[i])
            }
            self.result = local
            break
        case "TRY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.tryStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.tryStruct.inr[i])
            }
            self.result = local
            break
        case "UYU":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.uyuStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.uyuStruct.inr[i])
            }
            self.result = local
            break
        case "THB":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.thbStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.thbStruct.inr[i])
            }
            self.result = local
            break
        case "COP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.copStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.copStruct.inr[i])
            }
            self.result = local
            break
        case "SEK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.sekStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.sekStruct.inr[i])
            }
            self.result = local
            break
        case "TWD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.twdStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.twdStruct.inr[i])
            }
            self.result = local
        case "BYN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.bynStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.bynStruct.inr[i])
            }
            self.result = local
            break
        case "HUF":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.hufStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.hufStruct.inr[i])
            }
            self.result = local
            break
        case "CZK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.czkStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?((totals[indexPath.item] ))
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.czkStruct.inr[i])
            }
            self.result = local
            break
        default:
            break
        }
        
    }
    func deleteBackwardsTotal(at indexPath: IndexPath , didFinishUpdate: ((Double) -> ())?) {
        switch inApp.selectedCurrency {
        case "INR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.inrStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.inrStruct.inr[i]
            }
            self.result = local
            break
        case "ILS":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.ilsStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.ilsStruct.inr[i]
            }
            self.result = local
            break
        case "MUR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.murStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.murStruct.inr[i]
            }
            self.result = local
            break
        case "CHF":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.chfStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.chfStruct.inr[i]
            }
            self.result = local
            break
        case "USD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.usdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.usdStruct.inr[i]
            }
            self.result = local
            break
        case "HKD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.hkdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.hkdStruct.inr[i]
            }
            self.result = local
            break
        case "RON":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.ronStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.ronStruct.inr[i]
            }
            self.result = local
            break
        case "EUR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.eurStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.eurStruct.inr[i]
            }
            self.result = local
            break
        case "AUD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.audStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.audStruct.inr[i]
            }
            self.result = local
            break
        case "SGD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.sgdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.sgdStruct.inr[i]
            }
            self.result = local
            break
        case "SEK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.sekStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.sekStruct.inr[i])
            }
            self.result = local
        case "TWD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.twdStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.twdStruct.inr[i])
            }
            self.result = local
            break
        case "BYN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.bynStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.bynStruct.inr[i])
            }
            self.result = local
            break
        case "HUF":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.hufStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.hufStruct.inr[i])
            }
            self.result = local
            break
        case "CZK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.czkStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.czkStruct.inr[i])
            }
            self.result = local
            break
        case "MYR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.myrStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.myrStruct.inr[i]
            }
            self.result = local
            break
        case "CAD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.cadStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.cadStruct.inr[i]
            }
            self.result = local
            break
        case "GBP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.gbpStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.gbpStruct.inr[i]
            }
            self.result = local
            break
 
        case "NZD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.nzdStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.nzdStruct.inr[i]
            }
            self.result = local
            break
        case "NOK":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.nokStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.nokStruct.inr[i]
            }
            self.result = local
            break
        case "ARS":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.arsStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.arsStruct.inr[i]
            }
            self.result = local
            break
        case "CNY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.cnyStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.cnyStruct.inr[i]
            }
            self.result = local
            break
        case "ZAR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.zarStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.zarStruct.inr[i]
            }
            self.result = local
            break
        case "MXN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.mxnStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.mxnStruct.inr[i]
            }
            self.result = local
            break
        case "RUB":
            totals[indexPath.item] = Double(entries[indexPath.item]) * currencyModel.rubStruct.inr[indexPath.item]
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * currencyModel.rubStruct.inr[i]
            }
            self.result = local
            break
        case "DOP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.dopStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.dopStruct.inr[i])
            }
            self.result = local
            break
        case "MVR":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.mvrStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.mvrStruct.inr[i])
            }
            self.result = local
            break
        case "JPY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.jpyStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.jpyStruct.inr[i])
            }
            self.result = local
            break
        case "KRW":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.krwStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.krwStruct.inr[i])
            }
            self.result = local
            break
        case "KWD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.kwdStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:3)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.kwdStruct.inr[i])
            }
            self.result = local
            break
        case "CUP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.cupStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.cupStruct.inr[i])
            }
            self.result = local
            break
        case "PLN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.plnStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.plnStruct.inr[i])
            }
            self.result = local
            break
        case "PEN":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.penStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.penStruct.inr[i])
            }
            self.result = local
            break
        case "PHP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.phpStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.phpStruct.inr[i])
            }
            self.result = local
            break
        case "CLP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.clpStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.clpStruct.inr[i])
            }
            self.result = local
            break
        case "BRL":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.brlStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.brlStruct.inr[i])
            }
            self.result = local
            break
        case "TRY":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.tryStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.tryStruct.inr[i])
            }
            self.result = local
            break
        case "UYU":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.uyuStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.uyuStruct.inr[i])
            }
            self.result = local
            break
        case "THB":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.thbStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.thbStruct.inr[i])
            }
            self.result = local
            break
        case "COP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.copStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.copStruct.inr[i])
            }
            self.result = local
            break
        case "JMD":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.jmdStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.jmdStruct.inr[i])
            }
            self.result = local
            break
        case "EGP":
            totals[indexPath.item] = Double(entries[indexPath.item]) * Double(currencyModel.egpStruct.inr[indexPath.item])
            totals[indexPath.item] = totals[indexPath.item].round(to:2)
            didFinishUpdate?(totals[indexPath.item])
            var local = 0.0
            for i in 0..<entries.count{
                local  += Double(entries[i]) * Double(currencyModel.egpStruct.inr[i])
            }
            self.result = local
            break
            
        default:
            break
        }
    }
    
    
}
