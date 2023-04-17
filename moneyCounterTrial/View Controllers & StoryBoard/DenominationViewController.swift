//
//  DenominationViewController.swift
//  Money Counter
//
//  Created by V PUGAZHENTHI on 31/12/22.
//  Copyright © 2022 V PUGAZHENTHI. All rights reserved.
//
import UIKit
import Foundation
class DenominationViewController :UIViewController,UIScrollViewDelegate  {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var contentView : UIView!
    
    var remarks : String?
    var date : String?
    
    private let denominationStackView : UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = true
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 1.0
        stack.backgroundColor = .systemGray
        stack.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    private let rowStackView : UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = true
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 1.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dnStackView : UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = true
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 1.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let blankLabel1 : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    private let noteLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    private let currencyNameLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    private let dollarLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        label.textAlignment = .center
        return label
    }()
    
    private let crossLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private let valueLabel : UILabel = {
        let label  = UILabel()
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    private let equalsLabel : UILabel = {
        let label  = UILabel()
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    
    private let subTotalLabel : UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12.0)
        return label
    }()
    
    override func viewDidLayoutSubviews() {
         
        
        denominationStackView.frame = CGRect(
            x: 5.0,
            y: view.safeAreaInsets.top - 40,
            width: view.frame.width - 10,
            height: (CGFloat(40 * filledRows))
        )
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("number of rows in denomination stck : \(denominationStackView.arrangedSubviews.count)")
    }
    var filledRows = 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.dnStackView.frame.maxY + 100)
    }
    @objc func exportAsPdfFromViewNew(){
        // MARK:-  to be undone later after testing
//        if !IAPManager.shared.isSubscribed(){
//            let vc = PayWallViewController()
//            vc.delegate = self
//            let navigationVC = UINavigationController(rootViewController: vc)
//
//                self.present(navigationVC, animated: true, completion: nil)
//
//        }
        
        
        let pdfPageFrame = self.contentView.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame,nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame,nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        self.contentView.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        var fileURL : URL?
        do{
            let fileName = "Final Report.pdf"
            let tempDirectory = FileManager.default.temporaryDirectory
            fileURL = tempDirectory.appendingPathComponent(fileName)
            try pdfData.write(to: fileURL!)
        }
        catch{
            print("cannot write to file")
        }
        if let pdfUrl = fileURL{
            let textToShare = NSLocalizedString("Check out this App", comment: "")
            let appName  =   NSLocalizedString("Money Counter", comment: "")
            let textToShareappName = textToShare + " : " + appName
            guard let appLink = NSURL(string: appIdString) else {return}
            let vc = UIActivityViewController(
                activityItems: [pdfUrl,textToShareappName,appLink],
                applicationActivities: []
            )
            self.present(vc, animated: true, completion: nil)
            vc.popoverPresentationController?.sourceView = self.navigationItem.titleView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItemTitle(text: "Money Counter - \(inApp.selectedCurrency)", titleColor: UIColor.systemGray, backColor : .clear, margin: 140)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(exportAsPdfFromViewNew))
        self.scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(currencyNameLabel)
        contentView.addSubview(denominationStackView)
        switch inApp.selectedCurrency{
        case "USD":
            guard inApp.arrayUSD.count != 0 else {return}
            for row in 0..<currencyModel.usdStruct.inrCurrency.count{
                if inApp.arrayUSD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.USDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "EUR":
            guard inApp.arrayEUR.count != 0 else {return}
            for row in 0..<currencyModel.eurStruct.inrCurrency.count{
                if inApp.arrayEUR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.EURResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "INR":
            guard inApp.arrayINR.count != 0 else {return}
            for row in 0..<currencyModel.inrStruct.inrCurrency.count{
                if inApp.arrayINR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.INRResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "GBP":
            guard inApp.arrayGBP.count != 0 else {return}
            for row in 0..<currencyModel.gbpStruct.inrCurrency.count{
                if inApp.arrayGBP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.GBPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "KWD":
            guard inApp.arrayKWD.count != 0 else {return}
            for row in 0..<currencyModel.kwdStruct.inrCurrency.count{
                if inApp.arrayKWD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.KWDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "MYR":
            guard inApp.arrayMYR.count != 0 else {return}
            for row in 0..<currencyModel.myrStruct.inrCurrency.count{
                if inApp.arrayMYR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.MYRResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "SGD":
            guard inApp.arraySGD.count != 0 else {return}
            for row in 0..<currencyModel.sgdStruct.inrCurrency.count{
                if inApp.arraySGD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.SGDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "HKD":
            guard inApp.arrayHKD.count != 0 else {return}
            for row in 0..<currencyModel.hkdStruct.inrCurrency.count{
                if inApp.arrayHKD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.HKDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "RON":
            guard inApp.arrayRON.count != 0 else {return}
            for row in 0..<currencyModel.ronStruct.inrCurrency.count{
                if inApp.arrayRON[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.RONResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CNY":
            guard inApp.arrayCNY.count != 0 else {return}
            for row in 0..<currencyModel.cnyStruct.inrCurrency.count{
                if inApp.arrayCNY[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CNYResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
        case "TWD":
            guard inApp.arrayTWD.count != 0 else {return}
            for row in 0..<currencyModel.twdStruct.inrCurrency.count{
                if inApp.arrayTWD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.TWDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CHF":
            guard inApp.arrayCHF.count != 0 else {return}
            for row in 0..<currencyModel.chfStruct.inrCurrency.count{
                if inApp.arrayCHF[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CHFResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "AUD":
            guard inApp.arrayAUD.count != 0 else {return}
            for row in 0..<currencyModel.audStruct.inrCurrency.count{
                if inApp.arrayAUD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.AUDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CAD":
            guard inApp.arrayCAD.count != 0 else {return}
            for row in 0..<currencyModel.cadStruct.inrCurrency.count{
                if inApp.arrayCAD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CADResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "JPY":
            guard inApp.arrayJPY.count != 0 else {return}
            for row in 0..<currencyModel.jpyStruct.inrCurrency.count{
                if inApp.arrayJPY[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.JPYResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "SEK":
            guard inApp.arraySEK.count != 0 else {return}
            for row in 0..<currencyModel.sekStruct.inrCurrency.count{
                if inApp.arraySEK[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.SEKResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "ZAR":
            guard inApp.arrayZAR.count != 0 else {return}
            for row in 0..<currencyModel.zarStruct.inrCurrency.count{
                if inApp.arrayZAR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.ZARResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "MXN":
            guard inApp.arrayMXN.count != 0 else {return}
            for row in 0..<currencyModel.mxnStruct.inrCurrency.count{
                if inApp.arrayMXN[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.MXNResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "RUB":
            guard inApp.arrayRUB.count != 0 else {return}
            for row in 0..<currencyModel.rubStruct.inrCurrency.count{
                if inApp.arrayRUB[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.RUBResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "BYN":
            guard inApp.arrayBYN.count != 0 else {return}
            for row in 0..<currencyModel.bynStruct.inrCurrency.count{
                if inApp.arrayBYN[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.BYNResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "HUF":
            guard inApp.arrayHUF.count != 0 else {return}
            for row in 0..<currencyModel.hufStruct.inrCurrency.count{
                if inApp.arrayHUF[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.HUFResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CZK":
            guard inApp.arrayCZK.count != 0 else {return}
            for row in 0..<currencyModel.czkStruct.inrCurrency.count{
                if inApp.arrayCZK[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CZKResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CUP":
            guard inApp.arrayCUP.count != 0 else {return}
            for row in 0..<currencyModel.cupStruct.inrCurrency.count{
                if inApp.arrayCUP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CUPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "KRW":
            guard inApp.arrayKRW.count != 0 else {return}
            for row in 0..<currencyModel.krwStruct.inrCurrency.count{
                if inApp.arrayKRW[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.KRWResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "MUR":
            guard inApp.arrayMUR.count != 0 else {return}
            for row in 0..<currencyModel.murStruct.inrCurrency.count{
                if inApp.arrayMUR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.MURResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "PLN":
            guard inApp.arrayPLN.count != 0 else {return}
            for row in 0..<currencyModel.plnStruct.inrCurrency.count{
                if inApp.arrayPLN[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.PLNResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "PEN":
            guard inApp.arrayPEN.count != 0 else {return}
            for row in 0..<currencyModel.penStruct.inrCurrency.count{
                if inApp.arrayPEN[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.PENResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "PHP":
            guard inApp.arrayPHP.count != 0 else {return}
            for row in 0..<currencyModel.phpStruct.inrCurrency.count{
                if inApp.arrayPHP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.PHPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "CLP":
            guard inApp.arrayCLP.count != 0 else {return}
            for row in 0..<currencyModel.clpStruct.inrCurrency.count{
                if inApp.arrayCLP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.CLPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "BRL":
            guard inApp.arrayBRL.count != 0 else {return}
            for row in 0..<currencyModel.brlStruct.inrCurrency.count{
                if inApp.arrayBRL[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.BRLResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "TRY":
            guard inApp.arrayTRY.count != 0 else {return}
            for row in 0..<currencyModel.tryStruct.inrCurrency.count{
                if inApp.arrayTRY[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.TRYResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "NZD":
            guard inApp.arrayNZD.count != 0 else {return}
            for row in 0..<currencyModel.nzdStruct.inrCurrency.count{
                if inApp.arrayNZD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.NZDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "NOK":
            guard inApp.arrayNOK.count != 0 else {return}
            for row in 0..<currencyModel.nokStruct.inrCurrency.count{
                if inApp.arrayNOK[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.NOKResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "UYU":
            guard inApp.arrayUYU.count != 0 else {return}
            for row in 0..<currencyModel.uyuStruct.inrCurrency.count{
                if inApp.arrayUYU[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.UYUResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "DOP":
            guard inApp.arrayDOP.count != 0 else {return}
            for row in 0..<currencyModel.dopStruct.inrCurrency.count{
                if inApp.arrayDOP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.DOPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "MVR":
            guard inApp.arrayMVR.count != 0 else {return}
            for row in 0..<currencyModel.mvrStruct.inrCurrency.count{
                if inApp.arrayMVR[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.MVRResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "THB":
            guard inApp.arrayTHB.count != 0 else {return}
            for row in 0..<currencyModel.thbStruct.inrCurrency.count{
                if inApp.arrayTHB[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.THBResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "COP":
            guard inApp.arrayCOP.count != 0 else {return}
            for row in 0..<currencyModel.copStruct.inrCurrency.count{
                if inApp.arrayCOP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.COPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "ARS":
            guard inApp.arrayARS.count != 0 else {return}
            for row in 0..<currencyModel.arsStruct.inrCurrency.count{
                if inApp.arrayARS[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.ARSResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "ILS":
            guard inApp.arrayILS.count != 0 else {return}
            for row in 0..<currencyModel.ilsStruct.inrCurrency.count{
                if inApp.arrayILS[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.ILSResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "JMD":
            guard inApp.arrayJMD.count != 0 else {return}
            for row in 0..<currencyModel.jmdStruct.inrCurrency.count{
                if inApp.arrayJMD[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.JMDResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            
        case "EGP":
            guard inApp.arrayEGP.count != 0 else {return}
            for row in 0..<currencyModel.egpStruct.inrCurrency.count{
                if inApp.arrayEGP[row] != 0{
                    filledRows += 1
                    setupRow(row: row)
                }
            }
            rowStackView.addArrangedSubview(blankLabel1)
            blankLabel1.text = "Totals"
            rowStackView.addArrangedSubview(subTotalLabel)
            subTotalLabel.text = inApp.EGPResults
            denominationStackView.addArrangedSubview(self.rowStackView)
            break
            

       
        default:
            break
        }
        dnStackView.addArrangedSubview(dateLabel)
        dateLabel.text = self.date
        dnStackView.addArrangedSubview(noteLabel)
        noteLabel.text = self.remarks
        denominationStackView.addArrangedSubview(self.dnStackView)
        
    }
    func sendRowStackView(row : Int) -> UIStackView{
        let rowStackView = UIStackView()
        rowStackView.clipsToBounds = true
        rowStackView.alignment = .fill
        rowStackView.axis = .horizontal
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 2.0
        rowStackView.backgroundColor = .systemGray
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let dollarLabel = UILabel()
        dollarLabel.clipsToBounds = true
        dollarLabel.backgroundColor = .systemBackground
        dollarLabel.font = .systemFont(ofSize: 12.0)
        dollarLabel.textAlignment = .center
        
        rowStackView.addArrangedSubview(dollarLabel)
        
        let crossLabel = UILabel()
        crossLabel.clipsToBounds = true
        crossLabel.backgroundColor = .systemBackground
        crossLabel.font = .systemFont(ofSize: 12.0)
        crossLabel.textAlignment = .center
        crossLabel.text = "×"
        
        rowStackView.addArrangedSubview(crossLabel)
        
        let valueLabel = UILabel()
        valueLabel.clipsToBounds = true
        valueLabel.backgroundColor = .systemBackground
        valueLabel.font = .systemFont(ofSize: 12.0)
        valueLabel.textAlignment = .center
        
        rowStackView.addArrangedSubview(valueLabel)
        
        let equalsLabel = UILabel()
        equalsLabel.clipsToBounds = true
        equalsLabel.backgroundColor = .systemBackground
        equalsLabel.font = .systemFont(ofSize: 12.0)
        equalsLabel.textAlignment = .center
        equalsLabel.text = "="
        rowStackView.addArrangedSubview(equalsLabel)
        
        let subTotalLabel = UILabel()
        subTotalLabel.clipsToBounds = true
        subTotalLabel.backgroundColor = .systemBackground
        subTotalLabel.font = .systemFont(ofSize: 12.0)
        subTotalLabel.textAlignment = .center
        subTotalLabel.adjustsFontSizeToFitWidth = true
       
        rowStackView.addArrangedSubview(subTotalLabel)
        switch inApp.selectedCurrency {
        case "USD":
            valueLabel.text = "\(inApp.arrayUSD[row])"
            dollarLabel.text = "\(currencyModel.usdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyUSDTotals[row])
            break
            
        case "EUR":
            valueLabel.text = "\(inApp.arrayEUR[row])"
            dollarLabel.text = "\(currencyModel.eurStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyEURTotals[row])
            break
            
        case "INR":
            valueLabel.text = "\(inApp.arrayINR[row])"
            dollarLabel.text = "\(currencyModel.inrStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyINRTotals[row])
            break
            
        case "GBP":
            valueLabel.text = "\(inApp.arrayGBP[row])"
            dollarLabel.text = "\(currencyModel.gbpStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyGBPTotals[row])
            break
            
        case "KWD":
            valueLabel.text = "\(inApp.arrayKWD[row])"
            dollarLabel.text = "\(currencyModel.kwdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyKWDTotals[row])
            break
            
        case "MYR":
            valueLabel.text = "\(inApp.arrayMYR[row])"
            dollarLabel.text = "\(currencyModel.myrStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyMYRTotals[row])
            break
            
        case "SGD":
            valueLabel.text = "\(inApp.arraySGD[row])"
            dollarLabel.text = "\(currencyModel.sgdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyySGDTotals[row])
            break
            
        case "HKD":
            valueLabel.text = "\(inApp.arrayHKD[row])"
            dollarLabel.text = "\(currencyModel.hkdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyHKDTotals[row])
            break
            
        case "RON":
            valueLabel.text = "\(inApp.arrayRON[row])"
            dollarLabel.text = "\(currencyModel.ronStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyRONTotals[row])
            break
            
        case "CNY":
            valueLabel.text = "\(inApp.arrayCNY[row])"
            dollarLabel.text = "\(currencyModel.cnyStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCNYTotals[row])
            break
        case "TWD":
            valueLabel.text = "\(inApp.arrayTWD[row])"
            dollarLabel.text = "\(currencyModel.twdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyTWDTotals[row])
            break
            
        case "CHF":
            valueLabel.text = "\(inApp.arrayCHF[row])"
            dollarLabel.text = "\(currencyModel.chfStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCHFTotals[row])
            break
            
        case "AUD":
            valueLabel.text = "\(inApp.arrayAUD[row])"
            dollarLabel.text = "\(currencyModel.audStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyAUDTotals[row])
            break
            
        case "CAD":
            valueLabel.text = "\(inApp.arrayCAD[row])"
            dollarLabel.text = "\(currencyModel.cadStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCADTotals[row])
            break
            
        case "JPY":
            valueLabel.text = "\(inApp.arrayJPY[row])"
            dollarLabel.text = "\(currencyModel.jpyStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyJPYTotals[row])
            break
            
        case "SEK":
            valueLabel.text = "\(inApp.arraySEK[row])"
            dollarLabel.text = "\(currencyModel.sekStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyySEKTotals[row])
            break
            
        case "ZAR":
            valueLabel.text = "\(inApp.arrayZAR[row])"
            dollarLabel.text = "\(currencyModel.zarStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyZARTotals[row])
            break
            
        case "MXN":
            valueLabel.text = "\(inApp.arrayMXN[row])"
            dollarLabel.text = "\(currencyModel.mxnStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyMXNTotals[row])
            break
            
        case "RUB":
            valueLabel.text = "\(inApp.arrayRUB[row])"
            dollarLabel.text = "\(currencyModel.rubStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyRUBTotals[row])
            break
            
        case "BYN":
            valueLabel.text = "\(inApp.arrayBYN[row])"
            dollarLabel.text = "\(currencyModel.bynStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyBYNTotals[row])
            break
            
        case "HUF":
            valueLabel.text = "\(inApp.arrayHUF[row])"
            dollarLabel.text = "\(currencyModel.hufStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyHUFTotals[row])
            break
            
        case "CZK":
            valueLabel.text = "\(inApp.arrayCZK[row])"
            dollarLabel.text = "\(currencyModel.czkStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCZKTotals[row])
            break
            
        case "CUP":
            valueLabel.text = "\(inApp.arrayCUP[row])"
            dollarLabel.text = "\(currencyModel.cupStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCUPTotals[row])
            break
            
        case "KRW":
            valueLabel.text = "\(inApp.arrayKRW[row])"
            dollarLabel.text = "\(currencyModel.krwStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyKRWTotals[row])
            break
            
        case "MUR":
            valueLabel.text = "\(inApp.arrayMUR[row])"
            dollarLabel.text = "\(currencyModel.murStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyMURTotals[row])
            break
            
        case "PLN":
            valueLabel.text = "\(inApp.arrayPLN[row])"
            dollarLabel.text = "\(currencyModel.plnStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyPLNTotals[row])
            break
            
        case "PEN":
            valueLabel.text = "\(inApp.arrayPEN[row])"
            dollarLabel.text = "\(currencyModel.penStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyPENTotals[row])
            break
            
        case "PHP":
            valueLabel.text = "\(inApp.arrayPHP[row])"
            dollarLabel.text = "\(currencyModel.phpStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyPHPTotals[row])
            break
            
        case "CLP":
            valueLabel.text = "\(inApp.arrayCLP[row])"
            dollarLabel.text = "\(currencyModel.clpStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCLPTotals[row])
            break
            
        case "BRL":
            valueLabel.text = "\(inApp.arrayBRL[row])"
            dollarLabel.text = "\(currencyModel.brlStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyBRLTotals[row])
            break
            
        case "TRY":
            valueLabel.text = "\(inApp.arrayTRY[row])"
            dollarLabel.text = "\(currencyModel.tryStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyTRYTotals[row])
            break
            
        case "NZD":
            valueLabel.text = "\(inApp.arrayNZD[row])"
            dollarLabel.text = "\(currencyModel.nzdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyNZDTotals[row])
            break
            
        case "NOK":
            valueLabel.text = "\(inApp.arrayNOK[row])"
            dollarLabel.text = "\(currencyModel.nokStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyNOKTotals[row])
            break
            
        case "UYU":
            valueLabel.text = "\(inApp.arrayUYU[row])"
            dollarLabel.text = "\(currencyModel.uyuStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyUYUTotals[row])
            break
            
        case "DOP":
            valueLabel.text = "\(inApp.arrayDOP[row])"
            dollarLabel.text = "\(currencyModel.dopStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyDOPTotals[row])
            break
            
        case "MVR":
            valueLabel.text = "\(inApp.arrayMVR[row])"
            dollarLabel.text = "\(currencyModel.mvrStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyMVRTotals[row])
            break
            
        case "THB":
            valueLabel.text = "\(inApp.arrayTHB[row])"
            dollarLabel.text = "\(currencyModel.thbStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyTHBTotals[row])
            break
            
        case "COP":
            valueLabel.text = "\(inApp.arrayCOP[row])"
            dollarLabel.text = "\(currencyModel.copStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyCOPTotals[row])
            break
            
        case "ARS":
            valueLabel.text = "\(inApp.arrayARS[row])"
            dollarLabel.text = "\(currencyModel.arsStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyARSTotals[row])
            break
            
        case "ILS":
            valueLabel.text = "\(inApp.arrayILS[row])"
            dollarLabel.text = "\(currencyModel.ilsStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyILSTotals[row])
            break
            
        case "JMD":
            valueLabel.text = "\(inApp.arrayJMD[row])"
            dollarLabel.text = "\(currencyModel.jmdStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyJMDTotals[row])
            break
            
        case "EGP":
            valueLabel.text = "\(inApp.arrayEGP[row])"
            dollarLabel.text = "\(currencyModel.egpStruct.inrCurrency[row])"
            subTotalLabel.text = returnSubTotal(sub: inApp.arrayyyyEGPTotals[row])
            break
            
        default:
            break
        }
            
            
        return rowStackView
    }
    
    func returnSubTotal(sub : Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = inApp.selectedCurrency
        let resultString = formatter.string(from: sub as NSNumber)!
        return resultString
    }
    func setupRow(row : Int){
        denominationStackView.addArrangedSubview(sendRowStackView(row: row))

    }
   
    
}
extension UIViewController
{
    func setInterfaceOrientation(_value : UIInterfaceOrientation){
       UIDevice.current.setValue(_value.rawValue, forKey: "orientation")
        print("change to landscape view")
    }
        
    func setNavigationItemTitle(text: String,
                                titleColor: UIColor,
                                backColor: UIColor,
                                margin left: CGFloat)
    {
        let titleLabel = UILabel()
        titleLabel.textColor = titleColor
        titleLabel.backgroundColor = backColor
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir Next Demi Bold", size: 18.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.titleView = titleLabel
        
        guard let containerView = self.navigationItem.titleView?.superview else { return }
        
        // NOTE: This always seems to be 0. Huh??
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 100),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant:-100)
        ])
    }
}
