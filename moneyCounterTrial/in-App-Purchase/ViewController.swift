
import UIKit
import StoreKit
import MessageUI
class ViewController: UIViewController {
    // MARK: - IBOutlet Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var periodicTableLabel: UILabel!
    @IBOutlet weak var yellowView: UIView!
    var iOSVersion : String = ""
    var modelName : String = ""
    // MARK: - Properties
    var product: SKProduct?
    // MARK: - Properties
    override func viewWillDisappear(_ animated: Bool) {
        print("view is to be dismissed")
    }
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPManager.shared.delegate = self
        self.iOSVersion = UIDevice.current.systemVersion
        self.modelName = UIDevice.current.model
        periodicTableLabel.font = UIFont(name: "AvenirNextCondensed-Medium", size: 16)!
        periodicTableLabel.textColor = UIColor.systemBackground
        periodicTableLabel.text = NSLocalizedString("moneyCounter", comment: "")
        yellowView.layer.cornerRadius = 5.0
        yellowView.backgroundColor = UIColor.systemTeal
        restoreButton.titleLabel?.numberOfLines = 0
        restoreButton.setTitleColor(.systemGray, for: .normal)
        restoreButton.titleLabel?.textAlignment  = .center
        restoreButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)!
        restoreButton.setTitle(NSLocalizedString("restore", comment: ""), for: .normal)
        restoreButton.layer.cornerRadius = 5.0
        restoreButton.backgroundColor =  .systemYellow
        configureTableView()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }
    // MARK: - Custom Methods
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.backgroundColor = .systemBackground
        self.tableView.isScrollEnabled = false
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.register(UINib(nibName: "NonConsumablesCell", bundle: nil), forCellReuseIdentifier: "nonConsumablesCell")
    }
    func showSingleAlert(withMessage message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("moneyCounter", comment: ""), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - IBAction Methods
    @IBAction func restorePurchases(_ sender: Any) {
        IAPManager.shared.restorePurchases()
    }
}
// MARK: - ViewModelDelegate
extension ViewController:IAPManagerDelegate {
 
    func showIAPRelatedError(_ error: Error) {
        let message = error.localizedDescription
        showSingleAlert(withMessage: message)
    }
    
    func shouldUpdateUI() {
        tableView.reloadData()
    }
    
    func didFinishRestoringPurchasedProducts() {
        showSingleAlert(withMessage: NSLocalizedString("All previous In-App Purchases have been restored!", comment: ""))
    }
    
    func hideRestoreButton() {
        restoreButton.backgroundColor = .clear
        restoreButton.titleLabel?.text = ""
        restoreButton.setTitleColor(.clear, for: .normal)
        restoreButton.isEnabled = false
    }
    
    func hideAds() {
        UserDefaults.standard.set(true, forKey: IAPManager.productID)
        tableView.reloadData()
    }
    
}
// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return UserDefaults.standard.bool(forKey: IAPManager.productID) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dequeuedCell: CustomCell?
        dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "nonConsumablesCell", for: indexPath) as? CustomCell
        guard let cell = dequeuedCell else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
       
        if indexPath.row == 0 {
            cell.lockedImageView.image = UIImage(named: "unlockWhiteImage")
            cell.topSeparator.isHidden = true
            cell.configureWithRemoveAds()
        }else {
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 2 {
            return 200
        } else {
            return 200
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let success = IAPManager.shared.removeAds()
        if !success{
            showSingleAlert(withMessage: IAPManager.IAPManagerError.userCannotMakePayments.localizedDescription)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
 
