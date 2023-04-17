//
//  moreAppsTableViewController.swift
//  Money Counter
//
//  Created by PUGAZHENTHI VENKATACHALAM on 27/07/18.
//  Copyright © 2018 PUGAZHENTHI VENKATACHALAM. All rights reserved.
//
import UIKit
import StoreKit
import MessageUI
private let reuseIdentifier = "geometricCell"
private let itemsPerRow: CGFloat = 2
private let itemsPerRowPad: CGFloat = 4
enum Theme: String {
    case light, dark, system

    // Utility var to pass directly to window.overrideUserInterfaceStyle
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
class moreAppsCollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SKStoreProductViewControllerDelegate{
    private let edgeInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    var candies = [Candy]()
    var iOSVersion : String = ""
    var modelName : String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mailButton: UIButton!
    
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var moreAppsLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var soundButton : UIButton!
    @IBOutlet weak var niteModeSwitch: UISwitch!
    var soundImage = UIImage(named: "soundImage");
    var muteImage = UIImage(named: "muteImage");
    var muted : Bool = false
    // MARK: UICollectionViewDataSource
    
    fileprivate func setSoundButton() {
        self.muted = defaults.value(forKey: "soundKey") as? Bool ?? false
        soundButton.tintColor = UIColor.systemTeal
        let soundImageYellow = self.soundImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let muteImageYellow = self.muteImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        self.muted == true ? (soundLabel.text = "unmute") : (soundLabel.text = "mute")
        self.muted == true ? (soundButton.setImage(muteImageYellow, for: .normal)) : (soundButton.setImage(soundImageYellow, for: .normal))
    }
    
    fileprivate func setupLayout() {
       
       
        niteModeSwitch.preferredStyle = .sliding
        
        let mailImage = UIImage(named: "mailImage");
        let mailImageYellow = mailImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        mailButton .setImage(mailImageYellow, for: .normal)
        mailButton.tintColor = UIColor.systemTeal
        mailButton.addTarget(self, action:#selector(btnSendMail), for: .touchUpInside)
         
        
        self.navigationItem.titleView = inApp.setLabelTitle(title: NSLocalizedString("Money Counter", comment: ""))
        self.view.backgroundColor = .systemBackground
        
        self.collectionView.backgroundColor = UIColor.systemTeal
        
        
        developerLabel.backgroundColor = .systemBackground
        developerLabel.textColor = .systemGray
        
        moreAppsLabel?.backgroundColor = .systemBackground
        moreAppsLabel?.textColor = UIColor.systemGray
        moreAppsLabel?.text = NSLocalizedString("moreAppsLabelText", comment: "")
        
        mailLabel?.textColor = UIColor.systemTeal
        mailLabel?.text = NSLocalizedString("contactSupportButtonText", comment: "")
        
        shareLabel?.textColor = UIColor.systemTeal
        shareLabel?.text = NSLocalizedString("dark mode", comment: "")
        
        soundLabel?.textColor = UIColor.systemTeal
       
        soundButton.addTarget(self, action:#selector(muteSound), for: .touchUpInside)
        soundButton.layer.cornerRadius = 5.0
        soundButton.titleLabel?.numberOfLines = 0
        soundButton.titleLabel?.textAlignment  = .center
        
        if deviceIdiom == .pad{
            mailLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
            shareLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
            soundLabel.font = UIFont(name: "Avenir-Heavy", size: 14)
        }else{
            mailLabel.font = UIFont(name: "Avenir-Heavy", size: 10)
            shareLabel.font = UIFont(name: "Avenir-Heavy", size: 10)
            soundLabel.font = UIFont(name: "Avenir-Heavy", size: 10)
        }
        collectionView.layer.cornerRadius = 5.0
    }
    @objc private func muteSound(){
        self.muted.toggle()
        defaults.set(muted, forKey: "soundKey")
        print("soundKey value from button : \(self.muted)")
        let soundImageYellow = self.soundImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let muteImageYellow = self.muteImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
       
        self.muted == true ? (soundLabel.text = "unmute") : (soundLabel.text = "mute")
        self.muted == true ? (soundButton.setImage(muteImageYellow, for: .normal)) : (soundButton.setImage(soundImageYellow, for: .normal))
    
    }
    override func viewDidAppear(_ animated: Bool) {
        switch traitCollection.userInterfaceStyle {
        case .light:
            niteModeSwitch.isOn = false
            defaults.set(false, forKey : "darkMode")
            break
        case .dark:
            niteModeSwitch.isOn = true
            defaults.set(true, forKey : "darkMode")
            break
        case .unspecified:
            break
        @unknown default:
            break
        }
         
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.collectionViewLayout.invalidateLayout()
        checkDarkMode()
    }
    fileprivate func checkDarkMode() {
        if defaults.bool(forKey: "darkMode") == true{
            niteModeSwitch.isOn = true
            
        }else{
            niteModeSwitch.isOn = false
             
        }
       
    }
    @IBAction func niteModeOnOff(sender : UISwitch){
        if sender.isOn{
            defaults.set(true, forKey : "darkMode")
        }else{
            defaults.set(false  , forKey : "darkMode")
            
        }
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = defaults.bool(forKey: "darkMode") == true ? .dark : .light
    }
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        let darkModeStatus = defaults.bool(forKey: "darkMode")
        setSoundButton()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionView?.collectionViewLayout = layout
        self.iOSVersion = UIDevice.current.systemVersion
        self.modelName = UIDevice.current.model
        self.candies  = ModelManager.sharedInstance.moreAppCandies
        setupLayout()
        // Register cell classes
        collectionView!.register(UINib.init(nibName: "MemeCellMore", bundle: nil), forCellWithReuseIdentifier: "MemeCellMore")
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  candies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCellMore", for: indexPath) as! MemeCellMore
        // Configure the cell
        cell.configureWithImage(index: indexPath.row)
        //cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let candy : Candy
        candy = candies[indexPath.row]
        self.adLinkButtonClicked(Row: indexPath.row)
    }
    func productViewControllerDidFinish(_ adViewController:SKStoreProductViewController)
    {
        adViewController.dismiss(animated: true,completion: nil)
        
    }
    @objc func adLinkButtonClicked(Row : Int){
        let selectedRow = Row
        
        let adViewController: SKStoreProductViewController = SKStoreProductViewController()
        adViewController.delegate = self
        
        let params = [ //0 concreteCalculator
            SKStoreProductParameterITunesItemIdentifier:imagefromClassAds.appIdForCellAds(row:selectedRow),]
        
        
        adViewController.loadProduct(withParameters: params, completionBlock: nil)
        self.present(adViewController, animated: true) {
            () -> Void in }
    }
}
extension moreAppsCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if deviceIdiom == .pad{
            let paddingSpace = edgeInset.left * (itemsPerRowPad + 1)
            let availableWidth = collectionView.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRowPad
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
extension moreAppsCollectionViewController : MFMailComposeViewControllerDelegate{
    
    @objc private func reviewApp(){
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        // You can find the App Store ID in your app's product URL "https://itunes.apple.com/app/id638690043"
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id522348381?action=write-review")
        else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
        
    }
    
    @objc func btnSendMail( ) {
       if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.setToRecipients(["contact.pugal.apps@gmail.com"])
        if (   UserDefaults.standard.bool(forKey: IAPManager.IAPHelperPurchaseNotification) == true){
            mail.setSubject("moneyCounter - 12.1p| \(self.iOSVersion) | \(self.modelName)")
        }else{
            mail.setSubject("moneyCounter - 12.1| \(self.iOSVersion) | \(self.modelName)")
        }
          
          mail.mailComposeDelegate = self
          present(mail, animated: true)
          }
       else {
          print("Email cannot be sent")
       }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       if let _ = error {
          self.dismiss(animated: true, completion: nil)
       }
       switch result {
          case .cancelled:
          print("Cancelled")
          break
          case .sent:
          print("Mail sent successfully")
          break
          case .failed:
          print("Sending mail failed")
          break
          default:
          break
       }
       controller.dismiss(animated: true, completion: nil)
    }
}

