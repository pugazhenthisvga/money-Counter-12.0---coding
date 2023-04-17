//
//  databaseClass.swift
//  Money Counter
//
//  Created by V PUGAZHENTHI on 01/04/21.
//  Copyright © 2021 V PUGAZHENTHI. All rights reserved.
//

import Foundation
class DataBaseClass: NSObject{
  //  func  retrieveArray(finished: () -> Void){
        // Retrieve array
    func  retrieveArray(){
        switch inApp.selectedCurrency {
            
        case "EGP":
            inApp.arrayEGP = defaults.array(forKey: "arrayEGP")  as? [Int] ?? [Int]()
            inApp.arrayyyyEGPTotals = defaults.array(forKey: "arrayyyyEGPTotals")  as? [Double] ?? [Double]()
            inApp.EGPResults = defaults.object(forKey: "EGPResults") as? String ?? ""
            break
        case "JMD":
            inApp.arrayJMD = defaults.array(forKey: "arrayJMD")  as? [Int] ?? [Int]()
            inApp.arrayyyyJMDTotals = defaults.array(forKey: "arrayyyyJMDTotals")  as? [Double] ?? [Double]()
            inApp.JMDResults = defaults.object(forKey: "JMDResults") as? String ?? ""
            break
        case "TWD":
            inApp.arrayTWD = defaults.array(forKey: "arrayTWD")  as? [Int] ?? [Int]()
            inApp.arrayyyyTWDTotals = defaults.array(forKey: "arrayyyyTWDTotals")  as? [Double] ?? [Double]()
            inApp.TWDResults = defaults.object(forKey: "TWDResults") as? String ?? ""
            break
        case "BYN":
            inApp.arrayBYN = defaults.array(forKey: "arrayBYN")  as? [Int] ?? [Int]()
            inApp.arrayyyyBYNTotals = defaults.array(forKey: "arrayyyyBYNTotals")  as? [Double] ?? [Double]()
            inApp.BYNResults = defaults.object(forKey: "BYNResults") as? String ?? ""
            break
        case "HUF":
            inApp.arrayHUF = defaults.array(forKey: "arrayHUF")  as? [Int] ?? [Int]()
            inApp.arrayyyyHUFTotals = defaults.array(forKey: "arrayyyyHUFTotals")  as? [Double] ?? [Double]()
            inApp.HUFResults = defaults.object(forKey: "HUFResults") as? String ?? ""
            break
        case "CZK":
            inApp.arrayCZK = defaults.array(forKey: "arrayCZK")  as? [Int] ?? [Int]()
            inApp.arrayyyyCZKTotals = defaults.array(forKey: "arrayyyyCZKTotals")  as? [Double] ?? [Double]()
            inApp.CZKResults = defaults.object(forKey: "CZKResults") as? String ?? ""
            break
        case "INR":
            inApp.arrayINR = defaults.array(forKey: "arrayINR")  as? [Int] ?? [Int]()
            inApp.arrayyyyINRTotals = defaults.array(forKey: "arrayyyyINRTotals")  as? [Double] ?? [Double]()
            inApp.INRResults = defaults.object(forKey: "INRResults") as? String ?? ""
            break
        case "ILS":
            inApp.arrayILS = defaults.array(forKey: "arrayILS")  as? [Int] ?? [Int]()
            inApp.arrayyyyILSTotals = defaults.array(forKey: "arrayyyyILSTotals")  as? [Double] ?? [Double]()
            inApp.ILSResults = defaults.object(forKey: "ILSResults") as? String ?? ""
            break
        case "SAR":
            inApp.arraySAR = defaults.array(forKey: "arraySAR")  as? [Int] ?? [Int]()
            inApp.arrayyyySARTotals = defaults.array(forKey: "arrayyyySARTotals")  as? [Double] ?? [Double]()
            inApp.SARResults = defaults.object(forKey: "SARResults") as? String ?? ""
            break
        case "USD":
            inApp.arrayUSD = defaults.array(forKey: "arrayUSD")  as? [Int] ?? [Int]()
            inApp.arrayyyyUSDTotals = defaults.array(forKey: "arrayyyyUSDTotals")  as? [Double] ?? [Double]()
            inApp.USDResults = defaults.object(forKey: "USDResults") as? String ?? ""
            break
        case "EUR":
            inApp.arrayEUR = defaults.array(forKey: "arrayEUR")  as? [Int] ?? [Int]()
            inApp.arrayyyyEURTotals = defaults.array(forKey: "arrayyyyEURTotals")  as? [Double] ?? [Double]()
            inApp.EURResults = defaults.object(forKey: "EURResults") as? String ?? ""
            break
        case "GBP":
            inApp.arrayGBP = defaults.array(forKey: "arrayGBP")  as? [Int] ?? [Int]()
            inApp.arrayyyyGBPTotals = defaults.array(forKey: "arrayyyyGBPTotals")  as? [Double] ?? [Double]()
            inApp.GBPResults = defaults.object(forKey: "GBPResults") as? String ?? ""
            break
        case "KWD":
            inApp.arrayKWD = defaults.array(forKey: "arrayKWD")  as? [Int] ?? [Int]()
            inApp.arrayyyyKWDTotals = defaults.array(forKey: "arrayyyyKWDTotals")  as? [Double] ?? [Double]()
            inApp.KWDResults = defaults.object(forKey: "KWDResults") as? String ?? ""
            break
        case "CAD":
            inApp.arrayCAD = defaults.array(forKey: "arrayCAD")  as? [Int] ?? [Int]()
            inApp.arrayyyyCADTotals = defaults.array(forKey: "arrayyyyCADTotals")  as? [Double] ?? [Double]()
            inApp.CADResults = defaults.object(forKey: "CADResults") as? String ?? ""
            break
        case "MYR":
            inApp.arrayMYR = defaults.array(forKey: "arrayMYR")  as? [Int] ?? [Int]()
            inApp.arrayyyyMYRTotals = defaults.array(forKey: "arrayyyyMYRTotals")  as? [Double] ?? [Double]()
            inApp.MYRResults = defaults.object(forKey: "MYRResults") as? String ?? ""
            break
        case "SGD":
            inApp.arraySGD = defaults.array(forKey: "arraySGD")  as? [Int] ?? [Int]()
            inApp.arrayyyySGDTotals = defaults.array(forKey: "arrayyyySGDTotals")  as? [Double] ?? [Double]()
            inApp.SGDResults = defaults.object(forKey: "SGDResults") as? String ?? ""
            break
        case "HKD":
            inApp.arrayHKD = defaults.array(forKey: "arrayHKD")  as? [Int] ?? [Int]()
            inApp.arrayyyyHKDTotals = defaults.array(forKey: "arrayyyyHKDTotals")  as? [Double] ?? [Double]()
            inApp.HKDResults = defaults.object(forKey: "HKDResults") as? String ?? ""
            break
        case "RON":
            inApp.arrayRON = defaults.array(forKey: "arrayRON")  as? [Int] ?? [Int]()
            inApp.arrayyyyRONTotals = defaults.array(forKey: "arrayyyyRONTotals")  as? [Double] ?? [Double]()
            inApp.RONResults = defaults.object(forKey: "RONResults") as? String ?? ""
            break
        case "CNY":
            inApp.arrayCNY = defaults.array(forKey: "arrayCNY")  as? [Int] ?? [Int]()
            inApp.arrayyyyCNYTotals = defaults.array(forKey: "arrayyyyCNYTotals")  as? [Double] ?? [Double]()
            inApp.CNYResults = defaults.object(forKey: "CNYResults") as? String ?? ""
            break
        case "CHF":
            inApp.arrayCHF = defaults.array(forKey: "arrayCHF")  as? [Int] ?? [Int]()
            inApp.arrayyyyCHFTotals = defaults.array(forKey: "arrayyyyCHFTotals")  as? [Double] ?? [Double]()
            inApp.CHFResults = defaults.object(forKey: "CHFResults") as? String ?? ""
            break
        case "AUD":
            inApp.arrayAUD = defaults.array(forKey: "arrayAUD")  as? [Int] ?? [Int]()
            inApp.arrayyyyAUDTotals = defaults.array(forKey: "arrayyyyAUDTotals")  as? [Double] ?? [Double]()
            inApp.AUDResults = defaults.object(forKey: "AUDResults") as? String ?? ""
            break
        case "JPY":
            inApp.arrayJPY = defaults.array(forKey: "arrayJPY")  as? [Int] ?? [Int]()
            inApp.arrayyyyJPYTotals = defaults.array(forKey: "arrayyyyJPYTotals")  as? [Double] ?? [Double]()
            inApp.JPYResults = defaults.object(forKey: "JPYResults") as? String ?? ""
            break
        case "SEK":
            inApp.arraySEK = defaults.array(forKey: "arraySEK")  as? [Int] ?? [Int]()
            inApp.arrayyyySEKTotals = defaults.array(forKey: "arrayyyySEKTotals")  as? [Double] ?? [Double]()
            inApp.SEKResults = defaults.object(forKey: "SEKResults") as? String ?? ""
            break
        case "ZAR":
            inApp.arrayZAR = defaults.array(forKey: "arrayZAR")  as? [Int] ?? [Int]()
            inApp.arrayyyyZARTotals = defaults.array(forKey: "arrayyyyZARTotals")  as? [Double] ?? [Double]()
            inApp.ZARResults = defaults.object(forKey: "ZARResults") as? String ?? ""
            break
        case "MXN":
            inApp.arrayMXN = defaults.array(forKey: "arrayMXN")  as? [Int] ?? [Int]()
            inApp.arrayyyyMXNTotals = defaults.array(forKey: "arrayyyyMXNTotals")  as? [Double] ?? [Double]()
            inApp.MXNResults = defaults.object(forKey: "MXNResults") as? String ?? ""
            break
        case "RUB":
            inApp.arrayRUB = defaults.array(forKey: "arrayRUB")  as? [Int] ?? [Int]()
            inApp.arrayyyyRUBTotals = defaults.array(forKey: "arrayyyyRUBTotals")  as? [Double] ?? [Double]()
            inApp.RUBResults = defaults.object(forKey: "RUBResults") as? String ?? ""
            break
        case "CUP":
            inApp.arrayCUP = defaults.array(forKey: "arrayCUP")  as? [Int] ?? [Int]()
            inApp.arrayyyyCUPTotals = defaults.array(forKey: "arrayyyyCUPTotals")  as? [Double] ?? [Double]()
            inApp.CUPResults = defaults.object(forKey: "CUPResults") as? String ?? ""
            break
 
        case "KRW":
            inApp.arrayKRW = defaults.array(forKey: "arrayKRW")  as? [Int] ?? [Int]()
            inApp.arrayyyyKRWTotals = defaults.array(forKey: "arrayyyyKRWTotals")  as? [Double] ?? [Double]()
            inApp.KRWResults = defaults.object(forKey: "KRWResults") as? String ?? ""
            break
        case "MUR":
            inApp.arrayMUR = defaults.array(forKey: "arrayMUR")  as? [Int] ?? [Int]()
            inApp.arrayyyyMURTotals = defaults.array(forKey: "arrayyyyMURTotals")  as? [Double] ?? [Double]()
            inApp.MURResults = defaults.object(forKey: "MURResults") as? String ?? ""
            break
        case "PLN":
            inApp.arrayPLN = defaults.array(forKey: "arrayPLN")  as? [Int] ?? [Int]()
            inApp.arrayyyyPLNTotals = defaults.array(forKey: "arrayyyyPLNTotals")  as? [Double] ?? [Double]()
            inApp.PLNResults = defaults.object(forKey: "PLNResults") as? String ?? ""
            break
        case "PEN":
            inApp.arrayPEN = defaults.array(forKey: "arrayPEN")  as? [Int] ?? [Int]()
            inApp.arrayyyyPENTotals = defaults.array(forKey: "arrayyyyPENTotals")  as? [Double] ?? [Double]()
            inApp.PENResults = defaults.object(forKey: "PENResults") as? String ?? ""
            break
        case "PHP":
            inApp.arrayPHP = defaults.array(forKey: "arrayPHP")  as? [Int] ?? [Int]()
            inApp.arrayyyyPHPTotals = defaults.array(forKey: "arrayyyyPHPTotals")  as? [Double] ?? [Double]()
            inApp.PHPResults = defaults.object(forKey: "PHPResults") as? String ?? ""
            break
        case "CLP":
            inApp.arrayCLP = defaults.array(forKey: "arrayCLP")  as? [Int] ?? [Int]()
            inApp.arrayyyyCLPTotals = defaults.array(forKey: "arrayyyyCLPTotals")  as? [Double] ?? [Double]()
            inApp.CLPResults = defaults.object(forKey: "CLPResults") as? String ?? ""
            break
        case "BRL":
            inApp.arrayBRL = defaults.array(forKey: "arrayBRL")  as? [Int] ?? [Int]()
            inApp.arrayyyyBRLTotals = defaults.array(forKey: "arrayyyyBRLTotals")  as? [Double] ?? [Double]()
            inApp.BRLResults = defaults.object(forKey: "BRLResults") as? String ?? ""
            break
        case "TRY":
            inApp.arrayTRY = defaults.array(forKey: "arrayTRY")  as? [Int] ?? [Int]()
            inApp.arrayyyyTRYTotals = defaults.array(forKey: "arrayyyyTRYTotals")  as? [Double] ?? [Double]()
            inApp.TRYResults = defaults.object(forKey: "TRYResults") as? String ?? ""
            break
        case "NZD":
            inApp.arrayNZD = defaults.array(forKey: "arrayNZD")  as? [Int] ?? [Int]()
            inApp.arrayyyyNZDTotals = defaults.array(forKey: "arrayyyyNZDTotals")  as? [Double] ?? [Double]()
            inApp.NZDResults = defaults.object(forKey: "NZDResults") as? String ?? ""
            break
        case "NOK":
            inApp.arrayNOK = defaults.array(forKey: "arrayNOK")  as? [Int] ?? [Int]()
            inApp.arrayyyyNOKTotals = defaults.array(forKey: "arrayyyyNOKTotals")  as? [Double] ?? [Double]()
            inApp.NOKResults = defaults.object(forKey: "NOKResults") as? String ?? ""
            break
        case "UYU":
            inApp.arrayUYU = defaults.array(forKey: "arrayUYU")  as? [Int] ?? [Int]()
            inApp.arrayyyyUYUTotals = defaults.array(forKey: "arrayyyyUYUTotals")  as? [Double] ?? [Double]()
            inApp.UYUResults = defaults.object(forKey: "UYUResults") as? String ?? ""
            break
        case "DOP":
            inApp.arrayDOP = defaults.array(forKey: "arrayDOP")  as? [Int] ?? [Int]()
            inApp.arrayyyyDOPTotals = defaults.array(forKey: "arrayyyyDOPTotals")  as? [Double] ?? [Double]()
            inApp.DOPResults = defaults.object(forKey: "DOPResults") as? String ?? ""
            break
        case "MVR":
            inApp.arrayMVR = defaults.array(forKey: "arrayMVR")  as? [Int] ?? [Int]()
            inApp.arrayyyyMVRTotals = defaults.array(forKey: "arrayyyyMVRTotals")  as? [Double] ?? [Double]()
            inApp.MVRResults = defaults.object(forKey: "MVRResults") as? String ?? ""
            break
        case "THB":
            inApp.arrayTHB = defaults.array(forKey: "arrayTHB")  as? [Int] ?? [Int]()
            inApp.arrayyyyTHBTotals = defaults.array(forKey: "arrayyyyTHBTotals")  as? [Double] ?? [Double]()
            inApp.THBResults = defaults.object(forKey: "THBResults") as? String ?? ""
            break
        case "COP":
            inApp.arrayCOP = defaults.array(forKey: "arrayCOP")  as? [Int] ?? [Int]()
            inApp.arrayyyyCOPTotals = defaults.array(forKey: "arrayyyyCOPTotals")  as? [Double] ?? [Double]()
            inApp.COPResults = defaults.object(forKey: "COPResults") as? String ?? ""
            break
        case "ARS":
            inApp.arrayARS = defaults.array(forKey: "arrayARS")  as? [Int] ?? [Int]()
            inApp.arrayyyyARSTotals = defaults.array(forKey: "arrayyyyARSTotals")  as? [Double] ?? [Double]()
            inApp.ARSResults = defaults.object(forKey: "ARSResults") as? String ?? ""
            break
        default: break
        }
     //   finished()
    }
    
}
