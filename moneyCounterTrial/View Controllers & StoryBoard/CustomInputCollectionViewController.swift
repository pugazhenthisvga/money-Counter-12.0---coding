    import UIKit
    import AVFoundation
    import CoreData
    import GoogleMobileAds
    import AppTrackingTransparency
    import AdSupport
    import StoreKit
    import FBAudienceNetwork

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let managedContext = appDelegate?.persistentContainer.viewContext
    let moneyEntity = NSEntityDescription.entity(forEntityName: "Money", in: managedContext!)!
    //MARK: step 1 Add Protocol here.
    protocol CustomInputCollectionViewControllerDelegate: class {
        func setResultField()
    }
    let unitTwo = "2"
    let noAds = "true"
    let unitsPad = Notification.Name(rawValue: unitTwo)
    let adsremoved = Notification.Name(rawValue: noAds)
    extension CustomInputCollectionViewController:GADBannerViewDelegate,GADFullScreenContentDelegate{

    }
    class CustomInputCollectionViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,AVAudioPlayerDelegate  {
        // MARK: Properties
        let dataBase = DataBaseClass()
        var activeTextField: UICollectionViewCell!
        @IBOutlet weak var topConstraint : NSLayoutConstraint!
        @IBOutlet weak var bottomConstraint : NSLayoutConstraint!
        @IBOutlet weak var bottomConstraintCollectionView : NSLayoutConstraint!
        @IBOutlet weak var verticalLayoutConstraint : NSLayoutConstraint!
        @IBOutlet weak var defaultButton : UIBarButtonItem!
        var defaultCurrencyPath = NSIndexPath(row: 0, section: 0)
        var keyboardHeight : CGFloat = 0.0
        var currencyModel = CurrencyModel()
        var selectedCurrencyModel : GLOBAL?
        var activeCollectionViewCell: UICollectionViewCell!
        let defaults = UserDefaults.standard
        var inrArray:[String] = []
        struct currencyStructure {
            var inrCurrency : [String]?
            var inr = [Int]()
            var inrDollar = [Int]()
            var inrCent = [Double]()
            var inrSymbol = [String]()
            var inrImageArray = [UIImage]()
            var inrCurrencyName : String?
        }
        var dataModel : DataModel?
        private var inAppButton : UIBarButtonItem?
        private var interstitial: GADInterstitialAd?
        private var layout = UICollectionViewFlowLayout()
        private let edgeInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        private let cellInterItemSpacing: CGFloat = 5
        private let cellLineSpacing: CGFloat = 5
        private var numberOfItemsPerRow: CGFloat = 4
        private let numberOfItemsPerRowShare: CGFloat = 1
        @IBOutlet weak var CustomInputCollectionView : UICollectionView!
        @IBOutlet weak var resultTextField : UITextField!
        @IBOutlet weak var clearButton : UIButton!
        @IBOutlet weak var shareButton: UIButton!
        @IBOutlet weak var currencySwitchPad: UISwitch!
        @IBAction func dismissKeyPad(){
            self.view.endEditing(true)
        }
        @IBOutlet weak var notesStackView : UIStackView!
        @IBOutlet weak var notesTextField : UITextField!
        @IBOutlet weak var dateLabel : UILabel!
        @IBOutlet weak var defaultCurrencyLabel : UILabel!
        @IBOutlet weak var topLabel : UILabel!
        @IBOutlet weak var currencyLabel : UILabel!
        @IBOutlet weak var flagImage : UIImageView!
        @IBOutlet weak var dollarImage : UIImageView!
        var activeCell: UICollectionViewCell!
        
        private var collectionViewWidth : CGFloat = 0.0
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            layout.invalidateLayout()
        }
        var initialTopConstraintValue : CGFloat = 0.0
        var initialBottomConstraintValue : CGFloat = 0.0
        var initialBottomConstraintValueCollectionView : CGFloat = 0.0
        fileprivate func setTopConstraint() {
            UIView.animate(withDuration: 0.5, animations: {
                
            })
            initialTopConstraintValue =  topConstraint.constant
        }
        fileprivate func setBottomConstraint() {
            UIView.animate(withDuration: 0.5, animations: {
                // self.topConstraint.constant = self.view.frame.height*(2/3)
                self.initialBottomConstraintValue =  self.bottomConstraint.constant
            })
            
        }
        fileprivate func setBackgroundForCollectionView() {
            let background = UIView()
            background.isUserInteractionEnabled = true
            background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:))))
            CustomInputCollectionView.backgroundView = background
        }
        fileprivate func setCustomInputCollectionView() {
            CustomInputCollectionView.dataSource = self
            CustomInputCollectionView.delegate   = self
            CustomInputCollectionView.register(CustomInputCell.self, forCellWithReuseIdentifier: "CustomInputCell")
        }
        fileprivate func setDateLabel() {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.locale = Locale.current
            let dateString = formatter.string(from: Date())
            dateLabel.text = dateString
            if deviceIdiom == .pad{
                
                dateLabel.font = UIFont (name: "Avenir-Medium", size: 20)
            }else
            {
                
                dateLabel.font = UIFont (name: "Avenir-Medium", size: 12)
            }
            dateLabel.numberOfLines = 0
            dateLabel.textAlignment = .center
            dateLabel.layer.cornerRadius = 5.0
            dateLabel.clipsToBounds  = true
        }
        fileprivate func setNotesTextField() {
            notesTextField.delegate = self
            if deviceIdiom == .pad{
                notesTextField.font = UIFont (name: "Avenir-Medium", size: 22)
            }else
            {
                notesTextField.font = UIFont (name: "Avenir-Medium", size: 16)
            }
            let notesPlaceholderText = NSAttributedString(string:  NSLocalizedString("remarks", comment: ""),
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .subheadline).italicized ])
            notesTextField.attributedPlaceholder = notesPlaceholderText
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            textField.resignFirstResponder()
            return true
        }
        var soundPlayer : AVAudioPlayer?
        func playDeleteSound() {
            guard !inApp.soundKey else {return}
            let soundURL = Bundle.main.url(forResource: "delete", withExtension: "wav")
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: soundURL!)
            }catch{
                print("error : \(error)")
            }
            soundPlayer?.play()
        }
        @objc func handleKeyboardWillShow(notification: Notification) {
            guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            inApp.keyboardHeight = keyboardEndFrame.height
            if (keyboardEndFrame.origin.y + keyboardEndFrame.size.height) > view.frame.size.height {
                // Hardware keyboard is found
                CustomInputCollectionView.contentInset.bottom = view.frame.size.height - keyboardEndFrame.origin.y
            } else {
                //Software keyboard is found
                guard activeTextField != nil else {
                    return
                }
                let bottomInset = keyboardEndFrame.height > activeTextField.frame.height ? keyboardEndFrame.height :activeTextField.frame.height
                CustomInputCollectionView.contentInset.bottom = bottomInset/1.8
                
            }
            var aRect = self.view.frame
            aRect.size.height -= keyboardEndFrame.height
            //Software keyboard is found
            if activeTextField == nil {
                self.activeTextField = CustomInputCollectionView.cellForItem(at: IndexPath(item: inApp.selectedCurrency.count, section: 0))
                
            }
            if let indexPath = CustomInputCollectionView.indexPath(for: activeTextField), let activeField = CustomInputCollectionView.cellForItem(at: indexPath) {
                if (!aRect.contains(activeField.frame.origin) ) {
                    CustomInputCollectionView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
        func handleKeyboardDidChangeState(_ notification: Notification) {
            guard let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            if (keyboardEndFrame.origin.y + keyboardEndFrame.size.height) > view.frame.size.height {
                // Hardware keyboard is found
                CustomInputCollectionView.contentInset.bottom = view.frame.size.height - keyboardEndFrame.origin.y
            } else {
                //Software keyboard is found
            }
            var aRect = self.view.frame
            aRect.size.height -= keyboardEndFrame.height
            if let indexPath = CustomInputCollectionView.indexPath(for: activeTextField), let activeField = CustomInputCollectionView.cellForItem(at: indexPath) {
                if (!aRect.contains(activeField.frame.origin) ) {
                    CustomInputCollectionView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
        func createObserver(){
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.currencyChangedPad), name: unitsPad, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.handlePurchaseNotification), name: adsremoved, object: nil)
        }
        // save to core data
        var quizManagedObject : [NSManagedObject] = []
        func save(question: String, answers: [String]) {
            guard let data = try? JSONEncoder().encode(answers),
                  let answersEncodedString = String(data: data, encoding: .utf8) else { return }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "INRMoney", in: managedContext)!
            let quiz = NSManagedObject(entity: entity, insertInto: managedContext)
            quiz.setValue(question, forKeyPath: "question")
            quiz.setValue(answersEncodedString, forKeyPath: "answers")
            do {
                quizManagedObject.append(quiz)
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        // fetch from core data
        func fetchCoreData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "INRMoney")
            do {
                quizManagedObject = try managedContext.fetch(fetchRequest)
                for i in quizManagedObject {
                    if let decodedAnswerString = i.value(forKey: "answers") as? String {
                        let data = Data(decodedAnswerString.utf8)
                        let answerArray = try? JSONDecoder().decode([String].self, from: data)
                        let question = i.value(forKey: "question") as! String
                        
                        print("Q : ", question)
                        print("A : ", answerArray ?? [""])
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
        fileprivate func switchForinAppSelectedCurrency() {
            switch inApp.selectedCurrency {
            case "INR":
                let selectedCurrency = currencyModel.inrStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
               // selectedCurrencyModel = currencyModel.inrStruct
                break
            case "USD":
                let selectedCurrency = currencyModel.usdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
               // selectedCurrencyModel = currencyModel.usdStruct
                break
            case "ILS":
                let selectedCurrency = currencyModel.ilsStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "EUR":
                let selectedCurrency = currencyModel.eurStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
                
            case "RON":
                let selectedCurrency = currencyModel.ronStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "HUF":
                let selectedCurrency = currencyModel.hufStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "AUD":
                let selectedCurrency = currencyModel.audStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "SGD":
                let selectedCurrency = currencyModel.sgdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "MYR":
                let selectedCurrency = currencyModel.myrStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "HKD":
                let selectedCurrency = currencyModel.hkdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "SEK":
                let selectedCurrency = currencyModel.sekStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "CHF":
                let selectedCurrency = currencyModel.chfStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "CAD":
                let selectedCurrency = currencyModel.cadStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "GBP":
                let selectedCurrency = currencyModel.gbpStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
           
            case "NZD":
                let selectedCurrency = currencyModel.nzdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "NOK":
                let selectedCurrency = currencyModel.nokStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "ARS":
                let selectedCurrency = currencyModel.arsStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "CNY":
                let selectedCurrency = currencyModel.cnyStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "TWD":
                let selectedCurrency = currencyModel.twdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "ZAR":
                let selectedCurrency = currencyModel.zarStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "MXN":
                let selectedCurrency = currencyModel.mxnStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "RUB":
                let selectedCurrency = currencyModel.rubStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "BYN":
                let selectedCurrency = currencyModel.bynStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
                
                case "CZK":
                    let selectedCurrency = currencyModel.czkStruct
                    dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                    self.flagImage.image = selectedCurrency.inrImageArray[0]
                    self.dollarImage.image = selectedCurrency.inrImageArray[1]
                    currencyLabel.text = selectedCurrency.inrCurrencyName
                    
                    break
            case "DOP":
                let selectedCurrency = currencyModel.dopStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "MVR":
                let selectedCurrency = currencyModel.mvrStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "JPY":
                let selectedCurrency = currencyModel.jpyStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "KRW":
                let selectedCurrency = currencyModel.krwStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "KWD":
                let selectedCurrency = currencyModel.kwdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "MUR":
                let selectedCurrency = currencyModel.murStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "CUP":
                let selectedCurrency = currencyModel.cupStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "PLN":
                let selectedCurrency = currencyModel.plnStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "PEN":
                let selectedCurrency = currencyModel.penStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "PHP":
                let selectedCurrency = currencyModel.phpStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "CLP":
                let selectedCurrency = currencyModel.clpStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "BRL":
                let selectedCurrency = currencyModel.brlStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "TRY":
                let selectedCurrency = currencyModel.tryStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "UYU":
                let selectedCurrency = currencyModel.uyuStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "THB":
                let selectedCurrency = currencyModel.thbStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "COP":
                let selectedCurrency = currencyModel.copStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
                
            case "JMD":
                let selectedCurrency = currencyModel.jmdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
            case "EGP":
                let selectedCurrency = currencyModel.egpStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                
                break
                
                
            default:
                let selectedCurrency = currencyModel.usdStruct
                dataModel = DataModel(numberOfEntries: selectedCurrency.inr.count, numberOfTotals: selectedCurrency.inr.count)
                self.flagImage.image = selectedCurrency.inrImageArray[0]
                self.dollarImage.image = selectedCurrency.inrImageArray[1]
                currencyLabel.text = selectedCurrency.inrCurrencyName
                break
            }
            if deviceIdiom == .phone{
                setDefaultCurrencyIcon()
            }else{
                setDefaultCurrencySwitchPad()
            }
            
            //setResultField()
            dataModel?.collectionViewDelegate = self
            CustomInputCollectionView.reloadData()
            
        }
        
        func scrollCollectionViewtoTop(){
            CustomInputCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,at: .top,animated: true)
        }
        @objc func handleShare(){
            performSegue(withIdentifier: "showDenoSegue", sender: self)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDenoSegue"{
                let vc  = segue.destination as! DenominationViewController
                vc.date = self.dateLabel.text
                vc.remarks = self.notesTextField.text
            }
            
        }
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        override func viewWillDisappear(_ animated: Bool) {
        
        }
        func saveArray(){
            switch inApp.selectedCurrency {
            case "INR":
                inApp.arrayINR = dataModel!.entries
                inApp.arrayyyyINRTotals = dataModel!.totals
                defaults.set(inApp.arrayINR, forKey: "arrayINR")
                defaults.set(inApp.arrayyyyINRTotals, forKey: "arrayyyyINRTotals")
                break
            case "USD":
                inApp.arrayUSD = dataModel!.entries
                inApp.arrayyyyUSDTotals = dataModel!.totals
                defaults.set(inApp.arrayUSD, forKey: "arrayUSD")
                defaults.set(inApp.arrayyyyUSDTotals, forKey: "arrayyyyUSDTotals")
                break
            case "ILS":
                inApp.arrayILS = dataModel!.entries
                inApp.arrayyyyILSTotals = dataModel!.totals
                defaults.set(inApp.arrayILS, forKey: "arrayILS")
                defaults.set(inApp.arrayyyyILSTotals, forKey: "arrayyyyILSTotals")
                break
            case "EUR":
                inApp.arrayEUR = dataModel!.entries
                inApp.arrayyyyEURTotals = dataModel!.totals
                defaults.set(inApp.arrayEUR, forKey: "arrayEUR")
                defaults.set(inApp.arrayyyyEURTotals, forKey: "arrayyyyEURTotals")
                break
            case "RON":
                inApp.arrayRON = dataModel!.entries
                inApp.arrayyyyRONTotals = dataModel!.totals
                defaults.set(inApp.arrayRON, forKey: "arrayRON")
                defaults.set(inApp.arrayyyyRONTotals, forKey: "arrayyyyRONTotals")
                break
            case "HUF":
                inApp.arrayHUF = dataModel!.entries
                inApp.arrayyyyHUFTotals = dataModel!.totals
                defaults.set(inApp.arrayHUF, forKey: "arrayHUF")
                defaults.set(inApp.arrayyyyHUFTotals, forKey: "arrayyyyHUFTotals")
                break
            case "GBP":
                inApp.arrayGBP = dataModel!.entries
                inApp.arrayyyyGBPTotals = dataModel!.totals
                defaults.set(inApp.arrayGBP, forKey: "arrayGBP")
                defaults.set(inApp.arrayyyyGBPTotals, forKey: "arrayyyyGBPTotals")
                break
            case "KWD":
                inApp.arrayKWD = dataModel!.entries
                inApp.arrayyyyKWDTotals = dataModel!.totals
                defaults.set(inApp.arrayKWD, forKey: "arrayKWD")
                defaults.set(inApp.arrayyyyKWDTotals, forKey: "arrayyyyKWDTotals")
                break
            case "CAD":
                inApp.arrayCAD = dataModel!.entries
                inApp.arrayyyyCADTotals = dataModel!.totals
                defaults.set(inApp.arrayCAD, forKey: "arrayCAD")
                defaults.set(inApp.arrayyyyCADTotals, forKey: "arrayyyyCADTotals")
                break
            case "MYR":
                inApp.arrayMYR = dataModel!.entries
                inApp.arrayyyyMYRTotals = dataModel!.totals
                defaults.set(inApp.arrayMYR, forKey: "arrayMYR")
                defaults.set(inApp.arrayyyyMYRTotals, forKey: "arrayyyyMYRTotals")
                break
            case "SGD":
                inApp.arraySGD = dataModel!.entries
                inApp.arrayyyySGDTotals = dataModel!.totals
                defaults.set(inApp.arraySGD, forKey: "arraySGD")
                defaults.set(inApp.arrayyyySGDTotals, forKey: "arrayyyySGDTotals")
                break
            case "HKD":
                inApp.arrayHKD = dataModel!.entries
                inApp.arrayyyyHKDTotals = dataModel!.totals
                defaults.set(inApp.arrayHKD, forKey: "arrayHKD")
                defaults.set(inApp.arrayyyyHKDTotals, forKey: "arrayyyyHKDTotals")
                break
            case "CNY":
                inApp.arrayCNY = dataModel!.entries
                inApp.arrayyyyCNYTotals = dataModel!.totals
                defaults.set(inApp.arrayCNY, forKey: "arrayCNY")
                defaults.set(inApp.arrayyyyCNYTotals, forKey: "arrayyyyCNYTotals")
                break
            case "TWD":
                inApp.arrayTWD = dataModel!.entries
                inApp.arrayyyyTWDTotals = dataModel!.totals
                defaults.set(inApp.arrayTWD, forKey: "arrayTWD")
                defaults.set(inApp.arrayyyyTWDTotals, forKey: "arrayyyyTWDTotals")
                break
            case "CHF":
                inApp.arrayCHF = dataModel!.entries
                inApp.arrayyyyCHFTotals = dataModel!.totals
                defaults.set(inApp.arrayCHF, forKey: "arrayCHF")
                defaults.set(inApp.arrayyyyCHFTotals, forKey: "arrayyyyCHFTotals")
                break
            case "AUD":
                inApp.arrayAUD = dataModel!.entries
                inApp.arrayyyyAUDTotals = dataModel!.totals
                defaults.set(inApp.arrayAUD, forKey: "arrayAUD")
                defaults.set(inApp.arrayyyyAUDTotals, forKey: "arrayyyyAUDTotals")
                break
            case "JPY":
                inApp.arrayJPY = dataModel!.entries
                inApp.arrayyyyJPYTotals = dataModel!.totals
                defaults.set(inApp.arrayJPY, forKey: "arrayJPY")
                defaults.set(inApp.arrayyyyJPYTotals, forKey: "arrayyyyJPYTotals")
                break
            case "SEK":
                inApp.arraySEK = dataModel!.entries
                inApp.arrayyyySEKTotals = dataModel!.totals
                defaults.set(inApp.arraySEK, forKey: "arraySEK")
                defaults.set(inApp.arrayyyySEKTotals, forKey: "arrayyyySEKTotals")
                break
            case "ZAR":
                inApp.arrayZAR = dataModel!.entries
                inApp.arrayyyyZARTotals = dataModel!.totals
                defaults.set(inApp.arrayZAR, forKey: "arrayZAR")
                defaults.set(inApp.arrayyyyZARTotals, forKey: "arrayyyyZARTotals")
                break
            case "MXN":
                inApp.arrayMXN = dataModel!.entries
                inApp.arrayyyyMXNTotals = dataModel!.totals
                defaults.set(inApp.arrayMXN, forKey: "arrayMXN")
                defaults.set(inApp.arrayyyyMXNTotals, forKey: "arrayyyyMXNTotals")
                break
            case "RUB":
                inApp.arrayRUB = dataModel!.entries
                inApp.arrayyyyRUBTotals = dataModel!.totals
                defaults.set(inApp.arrayRUB, forKey: "arrayRUB")
                defaults.set(inApp.arrayyyyRUBTotals, forKey: "arrayyyyRUBTotals")
                break
            case "BYN":
                inApp.arrayBYN = dataModel!.entries
                inApp.arrayyyyBYNTotals = dataModel!.totals
                defaults.set(inApp.arrayBYN, forKey: "arrayBYN")
                defaults.set(inApp.arrayyyyBYNTotals, forKey: "arrayyyyBYNTotals")
                break
            case "CZK":
                inApp.arrayCZK = dataModel!.entries
                inApp.arrayyyyCZKTotals = dataModel!.totals
                defaults.set(inApp.arrayCZK, forKey: "arrayCZK")
                defaults.set(inApp.arrayyyyCZKTotals, forKey: "arrayyyyCZKTotals")
                break
            case "CUP":
                inApp.arrayCUP = dataModel!.entries
                inApp.arrayyyyCUPTotals = dataModel!.totals
                defaults.set(inApp.arrayCUP, forKey: "arrayCUP")
                defaults.set(inApp.arrayyyyCUPTotals, forKey: "arrayyyyCUPTotals")
                break
          
            case "KRW":
                inApp.arrayKRW = dataModel!.entries
                inApp.arrayyyyKRWTotals = dataModel!.totals
                defaults.set(inApp.arrayKRW, forKey: "arrayKRW")
                defaults.set(inApp.arrayyyyKRWTotals, forKey: "arrayyyyKRWTotals")
                break
            case "MUR":
                inApp.arrayMUR = dataModel!.entries
                inApp.arrayyyyMURTotals = dataModel!.totals
                defaults.set(inApp.arrayMUR, forKey: "arrayMUR")
                defaults.set(inApp.arrayyyyMURTotals, forKey: "arrayyyyMURTotals")
                break
            case "PLN":
                inApp.arrayPLN = dataModel!.entries
                inApp.arrayyyyPLNTotals = dataModel!.totals
                defaults.set(inApp.arrayPLN, forKey: "arrayPLN")
                defaults.set(inApp.arrayyyyPLNTotals, forKey: "arrayyyyPLNTotals")
                break
            case "PEN":
                inApp.arrayPEN = dataModel!.entries
                inApp.arrayyyyPENTotals = dataModel!.totals
                defaults.set(inApp.arrayPEN, forKey: "arrayPEN")
                defaults.set(inApp.arrayyyyPENTotals, forKey: "arrayyyyPENTotals")
                break
            case "PHP":
                inApp.arrayPHP = dataModel!.entries
                inApp.arrayyyyPHPTotals = dataModel!.totals
                defaults.set(inApp.arrayPHP, forKey: "arrayPHP")
                defaults.set(inApp.arrayyyyPHPTotals, forKey: "arrayyyyPHPTotals")
                break
            case "CLP":
                inApp.arrayCLP = dataModel!.entries
                inApp.arrayyyyCLPTotals = dataModel!.totals
                defaults.set(inApp.arrayCLP, forKey: "arrayCLP")
                defaults.set(inApp.arrayyyyCLPTotals, forKey: "arrayyyyCLPTotals")
                break
            case "BRL":
                inApp.arrayBRL = dataModel!.entries
                inApp.arrayyyyBRLTotals = dataModel!.totals
                defaults.set(inApp.arrayBRL, forKey: "arrayBRL")
                defaults.set(inApp.arrayyyyBRLTotals, forKey: "arrayyyyBRLTotals")
                break
            case "TRY":
                inApp.arrayTRY = dataModel!.entries
                inApp.arrayyyyTRYTotals = dataModel!.totals
                defaults.set(inApp.arrayTRY, forKey: "arrayTRY")
                defaults.set(inApp.arrayyyyTRYTotals, forKey: "arrayyyyTRYTotals")
                break
            case "NZD":
                inApp.arrayNZD = dataModel!.entries
                inApp.arrayyyyNZDTotals = dataModel!.totals
                defaults.set(inApp.arrayNZD, forKey: "arrayNZD")
                defaults.set(inApp.arrayyyyNZDTotals, forKey: "arrayyyyNZDTotals")
                break
            case "NOK":
                inApp.arrayNOK = dataModel!.entries
                inApp.arrayyyyNOKTotals = dataModel!.totals
                defaults.set(inApp.arrayNOK, forKey: "arrayNOK")
                defaults.set(inApp.arrayyyyNOKTotals, forKey: "arrayyyyNOKTotals")
                break
            case "UYU":
                inApp.arrayUYU = dataModel!.entries
                inApp.arrayyyyUYUTotals = dataModel!.totals
                defaults.set(inApp.arrayUYU, forKey: "arrayUYU")
                defaults.set(inApp.arrayyyyUYUTotals, forKey: "arrayyyyUYUTotals")
                break
            case "DOP":
                inApp.arrayDOP = dataModel!.entries
                inApp.arrayyyyDOPTotals = dataModel!.totals
                defaults.set(inApp.arrayDOP, forKey: "arrayDOP")
                defaults.set(inApp.arrayyyyDOPTotals, forKey: "arrayyyyDOPTotals")
                break
            case "MVR":
                inApp.arrayMVR = dataModel!.entries
                inApp.arrayyyyMVRTotals = dataModel!.totals
                defaults.set(inApp.arrayMVR, forKey: "arrayMVR")
                defaults.set(inApp.arrayyyyMVRTotals, forKey: "arrayyyyMVRTotals")
                break
            case "THB":
                inApp.arrayTHB = dataModel!.entries
                inApp.arrayyyyTHBTotals = dataModel!.totals
                defaults.set(inApp.arrayTHB, forKey: "arrayTHB")
                defaults.set(inApp.arrayyyyTHBTotals, forKey: "arrayyyyTHBTotals")
                break
            case "COP":
                inApp.arrayCOP = dataModel!.entries
                inApp.arrayyyyCOPTotals = dataModel!.totals
                defaults.set(inApp.arrayCOP, forKey: "arrayCOP")
                defaults.set(inApp.arrayyyyCOPTotals, forKey: "arrayyyyCOPTotals")
                break
            case "ARS":
                inApp.arrayARS = dataModel!.entries
                inApp.arrayyyyARSTotals = dataModel!.totals
                defaults.set(inApp.arrayARS, forKey: "arrayARS")
                defaults.set(inApp.arrayyyyARSTotals, forKey: "arrayyyyARSTotals")
                break
            case "JMD":
                inApp.arrayJMD = dataModel!.entries
                inApp.arrayyyyJMDTotals = dataModel!.totals
                defaults.set(inApp.arrayJMD, forKey: "arrayJMD")
                defaults.set(inApp.arrayyyyJMDTotals, forKey: "arrayyyyJMDTotals")
                break
            case "EGP":
                inApp.arrayEGP = dataModel!.entries
                inApp.arrayyyyEGPTotals = dataModel!.totals
                defaults.set(inApp.arrayEGP, forKey: "arrayEGP")
                defaults.set(inApp.arrayyyyEGPTotals, forKey: "arrayyyyEGPTotals")
                break

            default: break
            }
        }
        fileprivate func setResultFieldText() {
            switch inApp.selectedCurrency {
            case "INR":
                self.resultTextField.text = inApp.INRResults
                break
            case "USD":
                self.resultTextField.text = inApp.USDResults
                break
            case "ILS":
                self.resultTextField.text = inApp.ILSResults
                break
            case "EUR":
                self.resultTextField.text = inApp.EURResults
                break
            case "RON":
                self.resultTextField.text = inApp.RONResults
                break
            case "HUF":
                self.resultTextField.text = inApp.HUFResults
                break
            case "GBP":
                self.resultTextField.text = inApp.GBPResults
                break
            case "KWD":
                self.resultTextField.text = inApp.KWDResults
                break
            case "CAD":
                self.resultTextField.text = inApp.CADResults
                break
            case "MYR":
                self.resultTextField.text = inApp.MYRResults
                break
            case "SGD":
                self.resultTextField.text = inApp.SGDResults
                break
            case "HKD":
                self.resultTextField.text = inApp.HKDResults
                break
            case "CNY":
                self.resultTextField.text = inApp.CNYResults
                break
            case "TWD":
                self.resultTextField.text = inApp.TWDResults
                break
            case "CHF":
                self.resultTextField.text = inApp.CHFResults
                break
            case "AUD":
                self.resultTextField.text = inApp.AUDResults
                break
            case "JPY":
                self.resultTextField.text = inApp.JPYResults
                break
            case "SEK":
                self.resultTextField.text = inApp.SEKResults
                break
            case "ZAR":
                self.resultTextField.text = inApp.ZARResults
                break
            case "MXN":
                self.resultTextField.text = inApp.MXNResults
                break
            case "RUB":
                self.resultTextField.text = inApp.RUBResults
                break
            case "BYN":
                self.resultTextField.text = inApp.BYNResults
                break
            case "CZK":
                self.resultTextField.text = inApp.CZKResults
                break
            case "CUP":
                self.resultTextField.text = inApp.CUPResults
                break
            
            case "KRW":
                self.resultTextField.text = inApp.KRWResults
                break
            case "MUR":
                self.resultTextField.text = inApp.MURResults
                break
            case "PLN":
                self.resultTextField.text = inApp.PLNResults
                break
            case "PEN":
                self.resultTextField.text = inApp.PENResults
                break
            case "PHP":
                self.resultTextField.text = inApp.PHPResults
                break
            case "CLP":
                self.resultTextField.text = inApp.CLPResults
                break
            case "BRL":
                self.resultTextField.text = inApp.BRLResults
                break
            case "TRY":
                self.resultTextField.text = inApp.TRYResults
                break
            case "NZD":
                self.resultTextField.text = inApp.NZDResults
                break
            case "NOK":
                self.resultTextField.text = inApp.NOKResults
                break
            case "UYU":
                self.resultTextField.text = inApp.UYUResults
                break
            case "DOP":
                self.resultTextField.text = inApp.DOPResults
                break
            case "MVR":
                self.resultTextField.text = inApp.MVRResults
                break
            case "THB":
                self.resultTextField.text = inApp.THBResults
                break
            case "COP":
                self.resultTextField.text = inApp.COPResults
                break
            case "ARS":
                self.resultTextField.text = inApp.ARSResults
                break
            case "JMD":
                self.resultTextField.text = inApp.JMDResults
                break
            case "EGP":
                self.resultTextField.text = inApp.EGPResults
                break
            default: break
            }
            
        }
        override func viewDidAppear(_ animated: Bool) {
            print("view did appear")
            if isPurchased() {
                removeds()
            }else{
                initiateAds()
            }
            inApp.soundKey = defaults.value(forKey: "soundKey") as? Bool ?? false
            let asi = CustomInputCollectionViewController.getASIdentifier()
            print("asi : \(asi)")
        }
        func isPurchased() -> Bool{
            let purchaseStatus = UserDefaults.standard.bool(forKey: IAPManager.productID)
            if purchaseStatus{
                print("Previously purchased")
                return true
            }else{
                print("not purchased")
                return false
            }
        }
        fileprivate func setDefaultIcon() {
            let defultImage = UIImage(named: "defaultIcon");
            let defultImageYellow = defultImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            defaultButton?.setBackgroundImage(defultImageYellow, for: .normal, barMetrics: UIBarMetrics.default)
            defaultButton?.tintColor = UIColor.systemTeal
        }
        class func getASIdentifier(){
            let asi =  ASIdentifierManager().advertisingIdentifier
            print("asi : \(asi)")
        }
        
        //  ads
        fileprivate func initiateAds() {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    // Tracking authorization completed. Start loading ads here.
                    switch status {
                    case .authorized:
                        FBAdSettings.setAdvertiserTrackingEnabled(true)
                    default:
                        break
                    }
                    self.showAds()
                    self.loadInterstitialAds()
                })
            } else {
                showAds()
            }
        }
        func showAds() {
            DispatchQueue.main.async {
                self.bannerView.adSize = self.getAdaptiveSize()
                self.bannerView.load(GADRequest())
            }
        }
        func getAdaptiveSize() -> GADAdSize {
            // Step 1 - Determine the view width to use for the ad width.
            //in this codelab we use the full safe area width
            var frame: CGRect
            // Here safe area is taken into account, hence the view frame is used
            // after the view has been laid out.
            if #available(iOS 11.0, *) {
                //frame = view.frame.inset(by: view.safeAreaInsets)
                frame  = view.frame.inset(by: view.safeAreaInsets)
            } else {
                frame = view.frame
            }
            let viewWidth = frame.size.width
            
            // Step 2 - Get Adaptive GADAdSize and set the ad view.
            let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
            
            return adSize
        }
        // MARK: - GADBannerViewDelegate
        //  let bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        let bannerView = GADBannerView()
        func addBannerViewToView(_ bannerView: GADBannerView) {
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerView)
            bannerView.backgroundColor = .clear
            NSLayoutConstraint.activate([
                //align your banner to the bottom of the safe area
                bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                //Center your banner horizontally
                bannerView.centerXAnchor.constraint(equalTo:view.centerXAnchor)
            ])
        }
        override func viewWillTransition(to size: CGSize,
                                         with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to:size, with:coordinator)
            coordinator.animate(alongsideTransition: { _ in
                self.showAds()
            })
        }
        // MARK: - view positioning
        @available (iOS 11, *)
        func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
            // Position the banner. Stick it to the bottom of the Safe Area.
            // Make it constrained to the edges of the safe area.
            let guide = view .safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
                guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
                guide.topAnchor.constraint(equalTo: bannerView.topAnchor)
            ])
        }
        // Called when an ad request loaded an ad.
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            print("bannerViewDidReceiveAd")
            addBannerViewToView(bannerView)
            bannerView.alpha = 0
            UIView.animate(withDuration: 1, animations: { [self] in
                self.topConstraint.constant = bannerView.adSize.size.height
                self.view.layoutIfNeeded()
                
            })
            self.view.layoutIfNeeded()
            bannerView.alpha = 1
            
        }
        // Called when an ad request failed.
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            UIView.animate(withDuration: 1, animations: {
                print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
                bannerView.removeFromSuperview()
                if self.topConstraint.constant > 5.0{
                    self.topConstraint.constant = 0.0
                    self.view.layoutIfNeeded()
                }
                
            })
        }
        
        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
            print("bannerViewDidRecordImpression")
        }
        
        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillPresentScreen")
        }
        
        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewWillDIsmissScreen")
        }
        
        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
            print("bannerViewDidDismissScreen")
        }
        func removeds() {
            bannerView.delegate = nil
            bannerView.isHidden = true
            UIView.animate(withDuration: 1, animations: {
            if self.topConstraint.constant > 10{
                self.topConstraint.constant = 0
            }
            })
        }
        @objc func handlePurchaseNotification(_ notification: Notification) {
            removeds()
            self.view.reloadInputViews()
            print("Iam callced from to unlock all calculators")
//            if (view.window != nil) {
//                // do stuff
//                removeds()
//                self.view.reloadInputViews()
//            }
            
        }
        //  ads
        @objc func showViewController(sender: UIBarButtonItem){  //  working method for iPhones
            self.performSegue(withIdentifier: "inAppSegue", sender: self)
        }
        @objc func setDefaultCurrency(sender: UIBarButtonItem){  //  working method for iPhones
            let defultImage = UIImage(named: "currecySelected");
            let defultImageYellow = defultImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            let message2 = NSLocalizedString("default currency", comment: "")
            if !sender.isSpringLoaded{
                // set selected
                sender.isSpringLoaded = true
                sender.setBackgroundImage(defultImageYellow, for: .selected, barMetrics: UIBarMetrics.compactPrompt)
                sender.tintColor = UIColor.systemYellow
                inApp.defaultCurrencyPath = NSIndexPath(item: inApp.selectedIndex, section: 0)
                let data = NSKeyedArchiver.archivedData(withRootObject: inApp.defaultCurrencyPath)
                UserDefaults.standard.set(data, forKey: "defaultCurrency")
                UserDefaults.standard.set("true", forKey: "currencySelectionStatus")
                let message1 = "\(inApp.selectedCurrency) - "
                
                let message3 = message1 + message2
                self.showToast(message: message3, font: .boldSystemFont(ofSize: 16.0))
            } else {
                // set deselected
                sender.isSpringLoaded = false
                sender.setBackgroundImage(defultImageYellow, for: .selected, barMetrics: UIBarMetrics.default)
                sender.tintColor =  UIColor.systemTeal
                inApp.defaultCurrencyPath = NSIndexPath(item: 0, section: 0)
                 
                let data = NSKeyedArchiver.archivedData(withRootObject: inApp.defaultCurrencyPath)
                UserDefaults.standard.set(data, forKey: "defaultCurrency")
                UserDefaults.standard.set("false", forKey: "currencySelectionStatus")
                let messageR = NSLocalizedString("- reset", comment: "")
                let resetMessage = message2 + messageR
                self.showToast(message: resetMessage, font: .boldSystemFont(ofSize: 16.0))
            }
        }
        fileprivate func setDefaultCurrencyIcon() {  //   seting up Icon for iPhones
            let defultImage = UIImage(named: "currecySelected");
            let defultImageYellow = defultImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            let currencyButton = UIBarButtonItem(image: UIImage(named:"currencySelected"), style: .plain, target:self, action: #selector(setDefaultCurrency(sender:)))
            inAppButton = UIBarButtonItem(image: UIImage(named:"noAdsImage"), style:.done, target:self, action: #selector(showViewController(sender:)))
            inAppButton!.setBackgroundImage(defultImageYellow, for: .selected, barMetrics: UIBarMetrics.compactPrompt)
            inAppButton!.tintColor = UIColor.systemTeal
            self.navigationItem.rightBarButtonItems = [currencyButton,inAppButton!]
            
            let data1 = UserDefaults.standard.object(forKey: "defaultCurrency") as? NSData
            if ((data1 != nil)){
                defaultCurrencyPath = NSKeyedUnarchiver.unarchiveObject(with: data1! as Data) as! NSIndexPath}
            if defaultCurrencyPath.row == inApp.selectedIndex{
                currencyButton.isSpringLoaded = true
                currencyButton.setBackgroundImage(defultImageYellow, for: .selected, barMetrics: UIBarMetrics.compactPrompt)
                currencyButton.tintColor = UIColor.systemYellow
            }else{
                currencyButton.isSpringLoaded = false
                currencyButton.setBackgroundImage(defultImageYellow, for: .selected, barMetrics: UIBarMetrics.compactPrompt)
                currencyButton.tintColor = UIColor.systemTeal
            }
            
        }
        fileprivate func setDefaultCurrencySwitchPad() {  //   seting up Icon for iPads
            let data1 = UserDefaults.standard.object(forKey: "defaultCurrency") as? NSData
            if ((data1 != nil)){
                defaultCurrencyPath = NSKeyedUnarchiver.unarchiveObject(with: data1! as Data) as! NSIndexPath}
            if defaultCurrencyPath.row == inApp.selectedIndex{
                currencySwitchPad.setOn(true, animated: true)
            }else{
                print("inApp.selectedIndex : \(inApp.selectedIndex)")
                currencySwitchPad.setOn(false, animated: true)
            }
        }
        @IBAction func setDefaultCurrencyPad(){  //  working method for iPads
            let message2 = NSLocalizedString("default currency", comment: "")
            if currencySwitchPad.isOn{
                // set selected
                inApp.defaultCurrencyPath = NSIndexPath(item: inApp.selectedIndex, section: 0)
                let data = NSKeyedArchiver.archivedData(withRootObject: inApp.defaultCurrencyPath)
                UserDefaults.standard.set(data, forKey: "defaultCurrency")
                UserDefaults.standard.set("true", forKey: "currencySelectionStatus")
                let message1 = "\(inApp.selectedCurrency) - "
                
                let message3 = message1 + message2
                self.showToast(message: message3, font: .boldSystemFont(ofSize: 18.0))
            } else {
                // set deselected
                inApp.defaultCurrencyPath = NSIndexPath(item: 0, section: 0)
                print("inApp.selectedCurrency : base currency")
                let data = NSKeyedArchiver.archivedData(withRootObject: inApp.defaultCurrencyPath)
                UserDefaults.standard.set(data, forKey: "defaultCurrency")
                UserDefaults.standard.set("false", forKey: "currencySelectionStatus")
                let messageR = NSLocalizedString("- reset", comment: "")
                let resetMessage = message2 + messageR
                self.showToast(message: resetMessage, font: .boldSystemFont(ofSize: 16.0))
            }
        }
   
        var products = [SKProduct]()
        
        /// Tells the delegate that the ad failed to present full screen content.
          func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
            print("Ad did fail to present full screen content.")
          }

          /// Tells the delegate that the ad presented full screen content.
          func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("Ad did present full screen content.")
          }

          /// Tells the delegate that the ad dismissed full screen content.
          func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("Ad did dismiss full screen content.")
          }
        fileprivate func loadInterstitialAds() {
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID:interstitialAdUnitId,
                                   request: request,
                                   completionHandler: { [self] ad, error in
                                    if let error = error {
                                        print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                        return
                                    }
                                    interstitial = ad
                                    interstitial?.fullScreenContentDelegate = self
                                   }
            )
        }
        var localeCurrencyCode : String?
        var currencyArray = [String]()
        var flagArray = [String]()
        let mainView = MainViewController()
  
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            currencyLabel.textColor = .systemGray   
            resultTextField.backgroundColor = .systemBackground
            resultTextField.textColor = .systemTeal
            topLabel.backgroundColor = UIColor.systemGray6
            notesTextField.backgroundColor = .systemBackground
            notesTextField.textColor = .systemGray
            dateLabel.backgroundColor = UIColor.systemYellow
            shareButton.tintColor = UIColor.systemTeal
            clearButton.setTitleColor(UIColor.systemTeal, for: .normal)
            clearButton.backgroundColor  = .systemBackground
            if inApp.reviewTempCount == 0{
                StoreReviewHelper.checkAndAskForReview()
                inApp.reviewTempCount += 1
            }
            
            bannerView.delegate = self
            bannerView.adUnitID = bannerViewadUnitID   // money ounter AdUnitAd
            bannerView.rootViewController = self
            if inApp.selectedCurrency == "USD"{
                localeCurrencyCode = "USD"
            }else{
                
                localeCurrencyCode = inApp.selectedCurrency
            }
            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "872ebcb05948f5ca1f4a247f9a41de8b" ]
            shareButton.addTarget(self, action: #selector(handleShare), for:.touchUpInside)
            if deviceIdiom == .pad{
                if let myImage = UIImage(named: "shareImage1") {
                    let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                   
                    shareButton.setBackgroundImage(tintableImage, for: .normal)
                    shareButton.tintColor = UIColor.systemTeal
                }
            }
            dollarImage.layer.cornerRadius = dollarImage.frame.width/2
            self.notesTextField.isUserInteractionEnabled = false
            let currencyResult = mainView.setCurrencyArray(code: localeCurrencyCode!)
            currencyArray = currencyResult.currencyArray
            dataBase.retrieveArray()
            switchForinAppSelectedCurrency()
            setResultFieldText()
            setDateLabel()
            setBottomConstraint()
            setBackgroundForCollectionView()
            setNotesTextField()
            collectionViewWidth = self.CustomInputCollectionView.bounds.width
            clearButton.layer.cornerRadius = 5.0
            CustomInputCollectionView.layer.cornerRadius = 10.0
            CustomInputCollectionView.clipsToBounds  = true
            if deviceIdiom == .pad{
                resultTextField.font = UIFont (name: "Avenir-Medium", size: 28)
                defaultCurrencyLabel.text = NSLocalizedString("default currency", comment: "")
                defaultCurrencyLabel.font = UIFont (name: "Avenir-Heavy", size: 14)
                defaultCurrencyLabel.textColor = UIColor.systemGray
            }else
            {
                resultTextField.font = UIFont (name: "Avenir-Medium", size: 20)
            }
            //MARK: step 3 declase self as the delegate to the protocol
            dataModel?.collectionViewDelegate = self
            setCustomInputCollectionView()
            self.clearButton.addTarget(self, action:#selector(deleteAll), for: .touchUpInside)
            clearButton.setTitle(NSLocalizedString("Clear", comment: ""), for: .normal)
            clearButton.titleLabel?.font = UIFont (name: "Avenir-Medium", size: 18)
            
            setDefaultCurrencyIcon()
            createObserver()
            CustomInputCollectionView.reloadData()
        }
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            //print("dataModelCount : \(dataModel!.count)")
            return dataModel!.count
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if deviceIdiom   == .pad{
                numberOfItemsPerRow = 5
            }else{
                numberOfItemsPerRow = 4
            }
            let paddingSpace = cellInterItemSpacing * (numberOfItemsPerRow + 1) + (edgeInset.left + edgeInset.right)
            let availableWidth = view.frame.width - paddingSpace
            let size = availableWidth / numberOfItemsPerRow
            return .init(width: size, height: size)
            
        }
    }
    extension CustomInputCollectionViewController: UICollectionViewDelegateFlowLayout,UITextFieldDelegate ,CustomInputCollectionViewControllerDelegate {
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            view.endEditing(true)
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            self.CustomInputCollectionView.alpha = 0.25
            shareButton.isUserInteractionEnabled = false
            shareButton.alpha = 0.25
            var aRect = self.view.frame
            aRect.size.height -= inApp.keyboardHeight
            bottomConstraint.constant = inApp.keyboardHeight + initialBottomConstraintValue
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.CustomInputCollectionView.alpha = 1.0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.bottomConstraint.constant = self.initialBottomConstraintValue
                
            })
            guard shareButton.alpha < 1.0 else {
                return
            }
            shareButton.isUserInteractionEnabled = true
            shareButton.alpha = 1.0
            scrollCollectionViewtoTop()
            
        }
        @objc  func backgroundTapped(_ sender: UIGestureRecognizer) {
            self.view.endEditing(true)
            
        }
        func setResultField() {
            resultTextField.text = dataModel?.resultString
            
            if resultTextField.text != ""{
                switch inApp.selectedCurrency {
                case "INR":
                    inApp.INRResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.INRResults, forKey: "INRResults")
                    break
                case "USD":
                    inApp.USDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.USDResults, forKey: "USDResults")
                    break
                case "ILS":
                    inApp.ILSResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.ILSResults, forKey: "ILSResults")
                    break
                case "EUR":
                    inApp.EURResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.EURResults, forKey: "EURResults")
                    break
                case "RON":
                    inApp.RONResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.RONResults, forKey: "RONResults")
                    break
                case "HUF":
                    inApp.HUFResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.HUFResults, forKey: "HUFResults")
                    break
                case "GBP":
                    inApp.GBPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.GBPResults, forKey: "GBPResults")
                    break
                case "KWD":
                    inApp.KWDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.KWDResults, forKey: "KWDResults")
                    break
                case "CAD":
                    inApp.CADResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CADResults, forKey: "CADResults")
                    break
                case "MYR":
                    inApp.MYRResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.MYRResults, forKey: "MYRResults")
                    break
                case "SGD":
                    inApp.SGDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.SGDResults, forKey: "SGDResults")
                    break
                case "HKD":
                    inApp.HKDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.HKDResults, forKey: "HKDResults")
                    break
                case "CNY":
                    inApp.CNYResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CNYResults, forKey: "CNYResults")
                    break
                case "TWD":
                    inApp.TWDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.TWDResults, forKey: "TWDResults")
                    break
                case "CHF":
                    inApp.CHFResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CHFResults, forKey: "CHFResults")
                    break
                case "AUD":
                    inApp.AUDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.AUDResults, forKey: "AUDResults")
                    break
                case "JPY":
                    inApp.JPYResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.JPYResults, forKey: "JPYResults")
                    break
                case "SEK":
                    inApp.SEKResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.SEKResults, forKey: "SEKResults")
                    break
                case "ZAR":
                    inApp.ZARResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.ZARResults, forKey: "ZARResults")
                    break
                case "MXN":
                    inApp.MXNResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.MXNResults, forKey: "MXNResults")
                    break
                case "RUB":
                    inApp.RUBResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.RUBResults, forKey: "RUBResults")
                    break
                case "BYN":
                    inApp.BYNResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.BYNResults, forKey: "BYNResults")
                    break
                case "CZK":
                    inApp.CZKResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CZKResults, forKey: "CZKResults")
                    break
                case "CUP":
                    inApp.CUPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CUPResults, forKey: "CUPResults")
                    break
               
                case "KRW":
                    inApp.KRWResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.KRWResults, forKey: "KRWResults")
                    break
                case "MUR":
                    inApp.MURResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.MURResults, forKey: "MURResults")
                    break
                case "PLN":
                    inApp.PLNResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.PLNResults, forKey: "PLNResults")
                    break
                case "PEN":
                    inApp.PENResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.PENResults, forKey: "PENResults")
                    break
                case "PHP":
                    inApp.PHPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.PHPResults, forKey: "PHPResults")
                    break
                case "CLP":
                    inApp.CLPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.CLPResults, forKey: "CLPResults")
                    break
                case "BRL":
                    inApp.BRLResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.BRLResults, forKey: "BRLResults")
                    break
                case "TRY":
                    inApp.TRYResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.TRYResults, forKey: "TRYResults")
                    break
                case "NZD":
                    inApp.NZDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.NZDResults, forKey: "NZDResults")
                    break
                case "NOK":
                    inApp.NOKResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.NOKResults, forKey: "NOKResults")
                    break
                case "UYU":
                    inApp.UYUResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.UYUResults, forKey: "UYUResults")
                    break
                case "DOP":
                    inApp.DOPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.DOPResults, forKey: "DOPResults")
                    break
                case "MVR":
                    inApp.MVRResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.MVRResults, forKey: "MVRResults")
                    break
                case "THB":
                    inApp.THBResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.THBResults, forKey: "THBResults")
                    break
                case "COP":
                    inApp.COPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.COPResults, forKey: "COPResults")
                    break
                case "ARS":
                    inApp.ARSResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.ARSResults, forKey: "ARSResults")
                    break
                case "JMD":
                    inApp.JMDResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.JMDResults, forKey: "JMDResults")
                    break
                case "EGP":
                    inApp.EGPResults = dataModel?.resultString ?? ""
                    defaults.set(inApp.EGPResults, forKey: "EGPResults")
                    break
                    
                default:
                    break
                }
            }
            saveArray()
        }
        // MARK: Collection View Delegate And Data Source Extension
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return cellInterItemSpacing
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return cellLineSpacing
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return edgeInset
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomInputCell", for: indexPath) as! CustomInputCell
            cell.inputDelegate = dataModel
            cell.configure(indexPath, using: (dataModel?[indexPath.item])!,row: inApp.selectedIndex)
            cell.layoutIfNeeded()
            return cell
        }
        fileprivate func showInterstitialAds() {
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
        
        @objc private func deleteAll(){
            let numberOfRows =  dataModel?.count
            for i in 0..<numberOfRows!{
                dataModel?.entries[i] = 0
                dataModel?.totals[i] = 0
            }
            dataModel?.result = 0
            playDeleteSound()
            activeCell = nil
            DispatchQueue.main.async {
                self.CustomInputCollectionView.reloadData()
            }
            if !isPurchased(){
                showInterstitialAds()
            }
            
        }
        @objc private func deleteNotes(){
            notesTextField.text = ""
        }
        
        fileprivate func scrollToSelectedCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CustomInputCell, cell.canBecomeFirstResponder {
                self.activeTextField = cell
                self.notesTextField.isUserInteractionEnabled = true
                
                let index:Int = (self.CustomInputCollectionView.indexPathsForSelectedItems?.first!.row)!
                self.CustomInputCollectionView.scrollToItem(at: IndexPath(row: index , section: 0), at: UICollectionView.ScrollPosition.top, animated: true)
                cell.becomeFirstResponder()
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            scrollToSelectedCell(collectionView, indexPath)
            
        }
    }
    
    extension UIFont {
        private struct CustomFont {
            static var fontFamily = "Avenir"
        }
        
        /// Returns a bold version of `self`
        public var bolded: UIFont {
            return fontDescriptor.withSymbolicTraits(.traitBold)
                .map { UIFont(descriptor: $0, size: 0) } ?? self
        }
        
        /// Returns an italic version of `self`
        public var italicized: UIFont {
            return fontDescriptor.withSymbolicTraits(.traitItalic)
                .map { UIFont(descriptor: $0, size: 0) } ?? self
        }
        
        /// Returns a scaled version of `self`
        func scaled(scaleFactor: CGFloat) -> UIFont {
            let newDescriptor = fontDescriptor.withSize(fontDescriptor.pointSize * scaleFactor)
            return UIFont(descriptor: newDescriptor, size: 0)
        }
        
        class func preferredCustomFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
            // we are using the UIFontDescriptor which is less expensive than creating an intermediate UIFont
            let systemFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
            
            let customFontDescriptor = UIFontDescriptor.init(fontAttributes: [
                UIFontDescriptor.AttributeName.family: CustomFont.fontFamily,
                UIFontDescriptor.AttributeName.size: systemFontDescriptor.pointSize // use the font size of the default dynamic font
            ])
            
            // return font of new family with same size as the preferred system font
            return UIFont(descriptor: customFontDescriptor, size: 0)
        }
        
    }
    extension Double {
        func round(to places: Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
    }
    extension CustomInputCollectionViewController{
        @objc func currencyChangedPad(){
            print("units changed accessed : \(inApp.selectedCurrency)")
            dataBase.retrieveArray()
            switchForinAppSelectedCurrency()
            setResultFieldText()
        }
    }
    
    extension UIView {
        enum GlowEffect: Float {
            case small = 0.4, medium = 2, big = 5, bigger = 8
        }
        func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .big) {
            layer.masksToBounds = false
            layer.shadowColor = color.cgColor
            layer.shadowRadius = 0
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
            
            let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
            glowAnimation.fromValue = 0
            glowAnimation.toValue = effect.rawValue
            glowAnimation.beginTime = CACurrentMediaTime()+0.3
            glowAnimation.duration = CFTimeInterval(0.6)
            glowAnimation.autoreverses = true
            glowAnimation.isRemovedOnCompletion = true
            layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
        }
    }
    extension CustomInputCollectionViewController    {
        func showToast(message : String, font: UIFont) {
            var toastLabel = UILabel(frame: CGRect(x: self.currencyLabel.frame.minX, y: self.currencyLabel.frame.minY, width: self.currencyLabel.frame.width, height: currencyLabel.frame.height))
            if deviceIdiom == .pad{
                toastLabel = UILabel(frame: CGRect(x: self.currencyLabel.frame.minX + (currencyLabel.frame.width/(6)), y: self.currencyLabel.frame.minY, width: self.currencyLabel.frame.width/(1.5), height: currencyLabel.frame.height))
            }
           // toastLabel.backgroundColor = yellowColor.withAlphaComponent(1.0)
            toastLabel.backgroundColor = UIColor.systemYellow
            toastLabel.textColor = UIColor.systemTeal
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 6.0, delay: 0, options: .curveEaseInOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
    }
