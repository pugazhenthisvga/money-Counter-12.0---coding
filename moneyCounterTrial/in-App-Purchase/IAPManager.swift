
import StoreKit
import Foundation

protocol IAPManagerDelegate{
    func shouldUpdateUI()
    func hideRestoreButton()
    func hideAds()
    func showIAPRelatedError(_ error: Error)
    func showSingleAlert(withMessage message: String)
    func didFinishRestoringPurchasedProducts()
}

class IAPManager: NSObject{
    static let productID = "com.pugazh.moneyCounterPlusThirtyEight"
    static let IAPHelperPurchaseNotification = "com.pugazh.moneyCounterPlusThirtyEight"
    static let shared = IAPManager()
    var delegate : IAPManagerDelegate?
    func startInAppPurchaseObserver(){
        SKPaymentQueue.default().add(self)
    }
    func removeAds() -> Bool{
        if SKPaymentQueue.canMakePayments(){
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = IAPManager.productID
            SKPaymentQueue.default().add(paymentRequest)
            return true
        }else{
            print("User cannot Make Payments")
            return false
        }
    }
  
    enum IAPManagerError: Error {
        case noProductIDsFound
        case noProductsFound
        case paymentWasCancelled
        case productRequestFailed
        case userCannotMakePayments
    }
}
extension IAPManager: SKPaymentTransactionObserver{
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("purchase successful : ")
                delegate?.hideAds()
                NotificationCenter.default.post(name:adsremoved,object: nil)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("restore successful : ")
                delegate?.hideAds()
                delegate?.didFinishRestoringPurchasedProducts()
                delegate?.hideRestoreButton()
                NotificationCenter.default.post(name:adsremoved,object: nil)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                if let error = transaction.error as? SKError {
                    if error.code != .paymentCancelled {
                        delegate?.showSingleAlert(withMessage: IAPManagerError.productRequestFailed.localizedDescription)
                    } else {
                        delegate?.showSingleAlert(withMessage: IAPManagerError.paymentWasCancelled.localizedDescription)
                         
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred:
                break
            case .purchasing: break
            @unknown default: break
            }
        }
    }
    func restorePurchases(){
            SKPaymentQueue.default().restoreCompletedTransactions()
         
    }
}
 
extension IAPManager.IAPManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
        case .noProductsFound: return "No In-App Purchases were found."
        case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
        case .paymentWasCancelled: return "In-App Purchase process was cancelled."
        case .userCannotMakePayments: return "User cannot Make Payments.Enable Payments and try again."
        }
    }
}
